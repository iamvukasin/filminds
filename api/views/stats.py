from django.http import JsonResponse
from rest_framework.views import APIView
from django.db.models import Sum, Count
from app.models.user import AuthUser
from app.models.movie_interaction import SearchedMovie, CollectedMovie
from app.models.movie import Movie
from datetime import date, timedelta


def _get_data(type):
    results_filter = CollectedMovie.objects.filter(type=type)
    results = results_filter.values('movie_id').annotate(count=Count('movie_id')).order_by('-count')[:7]

    favoured_movies = ""
    favoured_counts = ""
    favoured_number = results.count()
    for result in results:
        movie = Movie.objects.get(pk=result['movie_id'])
        favoured_movies += movie.title + ","
        favoured_counts += str(result['count']) + ","

    return favoured_number, favoured_movies, favoured_counts


class MostSearched(APIView):
    def post(self, request):

        results = SearchedMovie.objects.values('movie_id').annotate(dcount=Sum('count')).order_by('-dcount')[:7]
        searched_titles = ""
        searched_counts = ""
        searched_number = len(results)
        for result in results:
            movie = Movie.objects.get(pk=result['movie_id'])
            searched_titles += movie.title+","
            searched_counts += str(result['dcount'])+","

        today = date.today()
        dates = ""
        user_counts = ""
        for i in reversed(range(10)):
            min_date = today - timedelta(days=i)
            result = AuthUser.objects.filter(date_joined__date=min_date)
            dates += str(min_date) + ","
            user_counts += str(result.count()) + ","

        favoured_number, favoured_movies, favoured_counts = _get_data(CollectedMovie.TYPE_WISH)
        watched_number, watched_movies, watched_counts = _get_data(CollectedMovie.TYPE_WATCH)

        searched_results = SearchedMovie.objects.values('movie_id')\
            .annotate(count=Sum('count')).order_by('-movie_id')

        collected_results = CollectedMovie.objects.values('movie_id')\
            .annotate(count=Count('movie_id')).order_by('-movie_id')

        all_results = {}

        for result in searched_results:
            all_results[result['movie_id']] = result['count']
        for result in collected_results:
            if result['movie_id'] in all_results:
                all_results[result['movie_id']] += result['count']
            else:
                all_results[result['movie_id']] = result['count']

        genres_counter = {}
        for result in all_results:
            movie = Movie.objects.get(pk=result)
            for genre in movie.genres.all():
                if genre.name in genres_counter:
                    genres_counter[genre.name] += all_results[result]
                else:
                    genres_counter[genre.name] = all_results[result]

        top_genres = list()
        for result in genres_counter:
            item = [genres_counter[result], result]
            top_genres.append(item)

        def get_key(item):
            return item[0]
        top_genres_sorted = sorted(top_genres, key=get_key)
        top_genres_sorted.reverse()

        i = 0
        genres_names = ""
        genres_counter = ""

        for result in top_genres_sorted:
            genres_names += result[1] + ","
            genres_counter += str(result[0]) + ","
            i += 1
            if i == 7:
                break
        genres_number = i

        return JsonResponse({
            'most_searched_titles': searched_titles,
            'most_searched_counts': searched_counts,
            'most_searched_number': searched_number,
            'most_favoured_titles': favoured_movies,
            'most_favoured_counts': favoured_counts,
            'most_favoured_number': favoured_number,
            'most_watched_titles': watched_movies,
            'most_watched_counts': watched_counts,
            'most_watched_number': watched_number,
            'top_genres_names': genres_names,
            'top_genres_counter': genres_counter,
            'top_genres_number': genres_number,
            'per_day_dates': dates,
            'per_day_counts': user_counts,
        })

