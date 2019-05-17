from rest_framework import serializers

from app.models import Movie


class MovieSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Movie
        fields = ('title', 'description', 'rating', 'release_date', 'poster', 'backdrop', 'trailer')