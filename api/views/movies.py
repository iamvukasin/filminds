import tmdbsimple as tmdb
from django.http import Http404
from requests import HTTPError
from rest_framework.response import Response
from rest_framework.views import APIView

import config
from api.serializers import MovieSerializer
from app.models import Movie, MovieGenre

MAX_NUM_CASTS = 4


class MovieInfo(APIView):
    """
    Returns movie information from the database (data defined in Movie
    model + cast information), if the movie has been already added. If
    not, gets the information from TMDB, saves to the database and
    then returns it.
    """

    @classmethod
    def _get_trailer(cls, videos):
        finder = (video['key'] for video in videos if video['site'] == 'YouTube' and video['type'] == 'Trailer')
        return next(finder, None)

    @classmethod
    def _get_object(cls, pk):
        try:
            return Movie.objects.get(pk=pk)
        except Movie.DoesNotExist:
            try:
                # find all movies with basic information + trailer videos
                tmdb.API_KEY = config.TMDB_API_KEY
                found_movie = tmdb.Movies(pk).info(append_to_response='videos')

                movie = Movie(
                    id=pk,
                    title=found_movie['title'],
                    description=found_movie['overview'],
                    rating=found_movie['vote_average'],
                    release_date=found_movie['release_date'],
                    poster=found_movie['poster_path'],
                    backdrop=found_movie['backdrop_path'],
                    trailer=cls._get_trailer(found_movie['videos']['results'])
                )
                movie.save()

                # add genres
                for found_genre in found_movie['genres']:
                    genre = MovieGenre.objects.get(pk=found_genre['id'])
                    movie.genres.add(genre)

                return movie
            except HTTPError:
                raise Http404

    def get(self, request, pk):
        movie = self._get_object(pk)
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
