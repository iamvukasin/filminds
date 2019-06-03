from abc import ABC, abstractmethod

import tmdbsimple as tmdb

import config
from api.chat_responses.builder import TextMessage, Message
from api.chat_responses.response import Response
from app.models import MovieGenre, Movie
from app.utils import trim_text_by_sentence


class MovieMessage(Message):
    """
    Representation of response message with movie data.
    """

    def __init__(self, movies):
        self.movies = movies

    def get(self):
        """
        Retrieves a dictionary representation of response with the
        movie data.
        """

        movies = []

        for movie in self.movies:
            movie_data = {
                'id': movie['id'],
                'title': movie['title'],
                'backdrop': Movie.get_backdrop_url(movie['backdrop_path']),
                'overview': trim_text_by_sentence(movie['overview'], Movie.DESCRIPTION_MAX_LENGTH)
            }
            movies.append(movie_data)

        return {'type': 'movies', 'content': movies}


class ResponseMovie(Response, ABC):
    """
    Represents a response for user request to get movie recommendations.
    """

    def __init__(self):
        super(ResponseMovie, self).__init__()
        tmdb.API_KEY = config.TMDB_API_KEY

    @abstractmethod
    def find_movies(self, request):
        """
        Finds movie recommendations based on provided request.
        """

        raise NotImplementedError

    def get(self, request):
        """
        Returns a JSON representation of recommendation messages for
        given request.

        :param request: a dictionary representing user request
        """

        requested_genres = MovieGenre.get_genre_ids_by_names(request['genres'])
        request['genres'] = requested_genres

        found_movies = self.find_movies(request)

        found_movies = found_movies[:9]

        text_message = TextMessage('Here are my picks for you')
        data_message = MovieMessage(found_movies)

        self.response_builder.add(text_message)
        self.response_builder.add(data_message)

        return self.response_builder.get_response()


class ResponseRecommendMovie(ResponseMovie):
    """
    Represents a response for user request to get a specific
    movie recommendation.
    """

    def find_movies(self, request):
        args = {}

        if 'genres' in request and request['genres']:
            args['with_genres'] = ','.join(str(genre) for genre in request['genres'])

        if 'dates' in request and request['dates']:
            args['release_date_gte'] = request['dates']['from']
            args['release_date_lte'] = request['dates']['to']

        return tmdb.Discover().movie(**args)['results']


class ResponsePopularMovie(ResponseMovie):
    """
    Represents a response for user request to get popular movies
    recommendation.
    """

    def find_movies(self, request):
        return tmdb.Movies().popular()['results']
