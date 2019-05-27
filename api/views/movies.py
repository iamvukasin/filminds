import tmdbsimple as tmdb
from django.contrib.auth.decorators import login_required
from django.http import Http404
from django.utils.decorators import method_decorator
from rest_framework.response import Response
from rest_framework.views import APIView

from api.serializers import MovieSerializer
from app.models import Movie, SearchedMovie, User, CollectedMovie

MAX_NUM_CASTS = 4


class MovieAddToFavorites(APIView):
    """
    Adds the given movie to the user's favorites list.
    """

    @method_decorator(login_required)
    def get(self, request, pk):
        user = User.get_user(request.user)
        movie = Movie.get_or_create(pk)

        if movie is None:
            raise Http404

        CollectedMovie.objects.update_or_create(
            user=user,
            movie=movie,
            type=CollectedMovie.TYPE_WISH
        )

        # success status
        return Response('')


class MovieRemoveFromFavorites(APIView):
    """
    Removes the given movie to the user's favorites list.
    """

    @method_decorator(login_required)
    def get(self, request, pk):
        user = User.get_user(request.user)
        movie = Movie.get_or_create(pk)

        if movie is None:
            raise Http404

        CollectedMovie.objects.filter(user=user, movie=movie).delete()

        # success status
        return Response('')


class MovieInfo(APIView):
    """
    Returns movie information from the database (data defined in Movie
    model + cast information), if the movie has been already added. If
    not, gets the information from TMDB, saves to the database and
    then returns it.
    """

    def get(self, request, pk):
        movie = Movie.get_or_create(pk)

        if movie is None:
            raise Http404

        # insert movie into searched movies table
        if request.user.is_authenticated:
            SearchedMovie.increment_search_count(User.get_user(request.user), movie)

        serializer = MovieSerializer(movie)
        data = serializer.data

        # set default poster image if no poster
        # is received from TMDB
        if data['poster'] is None:
            data['poster'] = ''
        else:
            data['poster'] = f'https://image.tmdb.org/t/p/w600_and_h900_bestv2{data["poster"]}'

        # set default backdrop image if no backdrop
        # is received from TMDB
        if data['backdrop'] is None:
            data['backdrop'] = ''
        else:
            data['backdrop'] = ''

        # create trailer URL
        if data['trailer'] is None:
            data['trailer'] = '#'
        else:
            data['trailer'] = f'https://youtu.be/{data["trailer"]}'

        # get actors from TMDB
        movie_credits = tmdb.Movies(pk).credits()
        data['cast'] = []

        for cast in movie_credits['cast'][:MAX_NUM_CASTS]:
            cast_data = {k: v for k, v in cast.items() if k in {'character', 'name', 'profile_path'}}

            # set default profile photo if no photo is received
            # from TMDB
            if cast_data['profile_path'] is None:
                cast_data['profile_path'] = ''
            else:
                cast_data['profile_path'] = f'https://image.tmdb.org/t/p/w276_and_h350_face{cast_data["profile_path"]}'

            data['cast'].append(cast_data)

        return Response(data)
