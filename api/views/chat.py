import calendar
import datetime
import json

from rest_framework.response import Response
from rest_framework.views import APIView
from wit import Wit

import config
from api import chat_responses
from api.chat_responses.builder import TextMessage, ResponseBuilder

from app.models import Message, User

RESPONSE_BUILDERS = {
    'greetings': chat_responses.ResponseGreeting,
    'recommend_movies': chat_responses.ResponseRecommendMovie,
    'popular_movies': chat_responses.ResponsePopularMovie,
    'help': chat_responses.ResponseHelp,
    'no_intent': chat_responses.ResponseNoIntent
}


def _increment_date(date, grain):
    """
    Creates a range of dates where the starting date is the given date and the
    ending date is the given date incremented for 1 unit of the given grain
    (year, month or day).

    :param date: the starting date in string format 'YYYY-MM-DD'
    :param grain: the grain of increment 'year', 'month' or 'day'
    :return: a dictionary with starting and ending date
    """

    result = {'from': date}
    date_from = datetime.datetime.strptime(date, '%Y-%m-%d')

    if grain == 'year':
        date_to = datetime.date(date_from.year + 1, date_from.month, date_from.day)
    elif grain == 'month':
        days_in_month = calendar.monthrange(date_from.year, date_from.month)[1]
        date_to = date_from + datetime.timedelta(days=days_in_month)
    else:
        date_to = date_from + datetime.timedelta(days=1)

    result['to'] = str(date_to)[:10]  # format 'YYYY-MM-DD'
    return result


class ChatReply(APIView):
    @staticmethod
    def _parse_response(response):
        entities = response['entities']

        if 'greetings' in entities:
            return {'type': 'greetings'}
        elif 'intent' in entities:
            summary = {}

            # parse intent
            if entities['intent'][0]['confidence'] > 0.5:
                summary['type'] = entities['intent'][0]['value']
            else:
                return None

            summary['genres'] = []
            summary['dates'] = {}

            # parse genres
            if 'genre' in entities:
                for genre in entities['genre']:
                    if genre['confidence'] > 0.5:
                        summary['genres'].append(genre['value'])

            # parse time
            if 'datetime' in entities:
                date = entities['datetime'][0]
                if date['confidence'] > 0.5:
                    if date['type'] == 'value':  # exact date
                        summary['dates'] = _increment_date(date['value'][:10], date['grain'])
                    elif date['type'] == 'interval':
                        if 'from' in date:
                            summary['dates']['from'] = date['from']['value'][:10]
                        if 'to' in date:
                            summary['dates']['to'] = date['to']['value'][:10]
            return summary
        else:
            return None

    def post(self, request):
        #get and save user message
        message = request.POST.get('message', '')
        if request.user.is_authenticated:
            text_message = TextMessage(message)
            builder = ResponseBuilder()
            builder.add(text_message)

            message_to_save = Message(
                user=User.get_user(request.user),
                sender_type=Message.SENDER_USER,
                content=builder.get_response()
            )

            message_to_save.save()

        # get chat_responses from Wit
        client = Wit(access_token=config.WIT_ACCESS_TOKEN)
        wit_response = client.message(message)
        wit_response = self._parse_response(wit_response)

        try:
            response_builder = RESPONSE_BUILDERS[wit_response['type']]
        except (KeyError, TypeError):
            response_builder = RESPONSE_BUILDERS['no_intent']

        # get and save bot message
        bot_response = response_builder().get(wit_response)
        if request.user.is_authenticated:
            message_to_save = Message(
                user=User.get_user(request.user),
                type=Message.TYPE_DATA,
                content=bot_response
            )

            message_to_save.save()

        return Response(bot_response)


class ChatLoad(APIView):
    def post(self, request):
        if request.user.is_authenticated:
            user_messages = Message.get_messages(user=User.get_user(request.user))
            return Response(user_messages)
        else:
            return Response()
