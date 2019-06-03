from rest_framework import serializers
from rest_framework.fields import ReadOnlyField, SerializerMethodField

from app.models import Movie, ExpertPickMovie, CollectedMovie


class MovieSerializer(serializers.HyperlinkedModelSerializer):
    poster = SerializerMethodField()
    backdrop = ReadOnlyField(source='backdrop_url')
    trailer = ReadOnlyField(source='trailer_url')

    def __init__(self, instance, small_poster=False, **kwargs):
        super().__init__(instance, **kwargs)
        self.small_poster = small_poster

    def get_poster(self, obj):
        return Movie.get_poster_url(obj.poster, self.small_poster)

    class Meta:
        model = Movie
        fields = ('id', 'title', 'description', 'rating', 'release_date', 'poster', 'backdrop', 'trailer')


class MoviePickSerializer(serializers.ModelSerializer):
    favorite = serializers.SerializerMethodField()
    watched = serializers.SerializerMethodField()
    movie = serializers.SerializerMethodField()

    def __init__(self, instance, user, **kwargs):
        super().__init__(instance, **kwargs)
        self.user = user

    def get_favorite(self, obj):
        if Movie.exists(obj.movie.id):
            movie = Movie.get_or_create(obj.movie.id)

            if CollectedMovie.is_favorite(self.user, movie):
                return True

        return False

    def get_watched(self, obj):
        if Movie.exists(obj.movie.id):
            movie = Movie.get_or_create(obj.movie.id)

            if CollectedMovie.is_watched(self.user, movie):
                return True

        return False

    def get_movie(self, obj):
        serializer = MovieSerializer(obj.movie, small_poster=True)
        return serializer.data

    class Meta:
        model = ExpertPickMovie
        fields = ('movie', 'favorite', 'watched')
