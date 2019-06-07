import random

from api.chat_responses.builder import TextMessage
from api.chat_responses.response import Response


class ResponseNoIntent(Response):
    """
    Represents a response for non understandable user request.
    """

    def get(self, request):
        message = TextMessage('Sorry, I cannot understand you. '
                              'Type something like: \'Recommend me a horror movie released in 2019\'.')
        self.response_builder.add(message)
        return self.response_builder.get_response()


class ResponseGreeting(Response):
    """
    Represents a greeting response.
    """

    GREETING_MESSAGES = ['Hello, how can I help you?',
                         'Hello there!',
                         'I\'m ready to recommend you some great movies',
                         'What do you want to watch today?']

    def get(self, request):
        message = TextMessage(random.choice(self.GREETING_MESSAGES))
        self.response_builder.add(message)
        return self.response_builder.get_response()


class ResponseThanks(Response):
    """
    Represents a welcome response message.
    """

    WELCOME_MESSAGES = ['You\'re welcome!',
                        'It was nothing. I\'m always here to help you.',
                        'My pleasure!']

    def get(self, request):
        message = TextMessage(random.choice(self.WELCOME_MESSAGES))
        self.response_builder.add(message)
        return self.response_builder.get_response()


class ResponseBye(Response):
    """
    Represents a goodbye response message.
    """

    BYE_MESSAGES = ['Goodbye!',
                        'Hope to see you again!',
                        'Have a nice day!']

    def get(self, request):
        message = TextMessage(random.choice(self.BYE_MESSAGES))
        self.response_builder.add(message)
        return self.response_builder.get_response()


class ResponseHelp(Response):
    """
    Represents a help response.
    """

    HELP_MESSAGES = ['Ask me to recommend you movie that you want to watch.',
                     'I\'m ready to recommend you some great movies. '
                     'Type something like: \'Recommend me a horror movie released in 2019\'',
                     'Type what do you want to watch today and I will find some picks for you.']

    def get(self, request):
        message = TextMessage(random.choice(self.HELP_MESSAGES))
        self.response_builder.add(message)
        return self.response_builder.get_response()
