from django.db import models
from django.db.models import F

from .user import User
from .movie import Movie
from .expert_picks import ExpertPicksCategory


class SearchedMovie(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, default=None, blank=True, null=True)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    count = models.IntegerField(default=0)

    @staticmethod
    def increment_search_count(user, movie):
        searched_movie, _ = SearchedMovie.objects.get_or_create(user=user, movie=movie)

        SearchedMovie.objects.filter(user=user, movie=movie).update(
            count=F('count') + 1,
        )


class CollectedMovie(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    date = models.DateField()
    TYPE_WATCH = 'WA'
    TYPE_WISH = 'WI'
    TYPE_CHOICES = (
        (TYPE_WATCH, 'Watch list'),
        (TYPE_WISH, 'Wish list')
    )
    type = models.CharField(
        choices=TYPE_CHOICES,
        max_length=2,
        default=TYPE_WISH
    )

    @staticmethod
    def get_favorites(user):
        movie_ids = CollectedMovie.objects.filter(user=user, type=CollectedMovie.TYPE_WISH).values_list('movie', flat=True)
        return Movie.objects.filter(id__in=movie_ids)

    @staticmethod
    def get_watched(user):
        return CollectedMovie.objects.filter(user=user, type=CollectedMovie.TYPE_WATCH).values_list('movie', flat=True)


class ExpertPickMovie(models.Model):
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    category = models.ForeignKey(ExpertPicksCategory, on_delete=models.CASCADE)
    order = models.IntegerField(default=1)
