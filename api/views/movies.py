from abc import ABC, abstractmethod

import tmdbsimple as tmdb
from django.contrib.auth.decorators import login_required
from django.http import Http404
from django.utils.decorators import method_decorator
from rest_framework.response import Response
from rest_framework.views import APIView

from api.serializers import MovieSerializer
from app.models import Movie, SearchedMovie, User, CollectedMovie

MAX_NUM_CASTS = 4


class AddCollectedMovie(ABC, APIView):
    """
    Adds the given movie to the user's favorites or watch list based
    on list_type property.
    """

    @method_decorator(login_required)
    def get(self, request, pk):
        user = User.get_user(request.user)
        movie = Movie.get_or_create(pk)

        if movie is None:
            raise Http404

        try:
            collected_item = CollectedMovie.objects.filter(user=user, movie=movie).get()
            collected_item.type = self.list_type
        except CollectedMovie.DoesNotExist:
            collected_item = CollectedMovie(
                user=user,
                movie=movie,
                type=self.list_type
            )

        collected_item.save()

        # success status
        return Response('')

    @property
    @abstractmethod
    def list_type(self):
        pass


class MovieAddToFavorites(AddCollectedMovie):
    """
    Adds the given movie to the user's favorites list.
    """

    list_type = CollectedMovie.TYPE_WISH


class MovieAddToWatched(AddCollectedMovie):
    """
    Adds the given movie to the user's watch list.
    """

    list_type = CollectedMovie.TYPE_WATCH


class RemoveCollectedMovie(APIView):
    """
    Removes the given movie to the user's favorites or watch list.
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
