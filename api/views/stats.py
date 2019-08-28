from datetime import date, timedelta

from django.db.models import Sum, Count
from django.http import JsonResponse
from django.utils.decorators import method_decorator
from rest_framework.views import APIView

from app.models import User, SearchedMovie, CollectedMovie
from app.views.utils import expert_or_admin_required

NUM_RETURNED_MOVIES = 7
STATS_FOR_LAST_N_DAYS = 10


def _create_statistics_data(data_list, is_multi_series=False):
    """
    Transforms the given list of data to the format suitable for
    presenting it on the front-end. Supports multi series charts (like
    line and bar charts) and or single series ones (like pie/donut
    charts).

    :param data_list: a list of pairs (label, value)
    :param is_multi_series: true if data will be shown on multi series
    charts
    :return: a dictionary of formatted input data
    """

    statistics_data = {
        'labels': [],
        'series': [[]] if is_multi_series else []
    }

    for data in data_list:
        statistics_data['labels'].append(data[0])

        if is_multi_series:
            statistics_data['series'][0].append(data[1])
        else:
            statistics_data['series'].append(data[1])

    return statistics_data


def _get_most_searched_movies():
    most_searched_movies = SearchedMovie.objects \
        .annotate(searches=Sum('count')) \
        .order_by('-searches') \
        .values_list('movie__title', 'searches')[:NUM_RETURNED_MOVIES]
    return _create_statistics_data(most_searched_movies, is_multi_series=True)


def _get_most_collected_movies(collection_type):
    most_collected_movies = CollectedMovie.objects \
        .filter(type=collection_type) \
        .values('movie_id') \
        .annotate(num_collected=Count('movie_id')) \
        .order_by('-num_collected') \
        .values_list('movie__title', 'num_collected')[:NUM_RETURNED_MOVIES]
    return _create_statistics_data(most_collected_movies, is_multi_series=True)


def _get_most_popular_genres():
    most_searched_genres = SearchedMovie.objects \
        .annotate(searches=Sum('count')) \
        .values_list('movie__genres__name', 'searches')
    most_collected_genres = CollectedMovie.objects \
        .annotate(num_collected=Count('movie_id')) \
        .values_list('movie__genres__name', 'num_collected')

    genres_count = {}

    for genre, count in list(most_searched_genres) + list(most_collected_genres):
        genres_count[genre] = genres_count.get(genre, 0) + count

    return _create_statistics_data(genres_count.items())


def _get_registered_users_number():
    result = []
    today = date.today()

    for delta in reversed(range(STATS_FOR_LAST_N_DAYS)):
        day = today - timedelta(days=delta)
        num_users = User.objects \
            .filter(user__date_joined__date=day) \
            .count()
        result.append((day, num_users))

    return _create_statistics_data(result, is_multi_series=True)


class Statistics(APIView):
    """
    Returns statistics about most searched, favoured and watched
    movies, most popular genres and number of new users per day in
    last 10 days.
    """

    @method_decorator(expert_or_admin_required)
    def get(self, request):
        result = {
            'searched': _get_most_searched_movies(),
            'watched': _get_most_collected_movies(CollectedMovie.TYPE_WATCH),
            'favorite': _get_most_collected_movies(CollectedMovie.TYPE_WISH),
            'genres': _get_most_popular_genres()
        }

        if User.is_auth_user_admin(request.user):
            result['users'] = _get_registered_users_number()

        return JsonResponse(result)
