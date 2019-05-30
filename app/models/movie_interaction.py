from django.db import models
from django.db.models import F
from django.utils import timezone

from .expert_picks import ExpertPicksCategory
from .movie import Movie
from .user import User


class SearchedMovie(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, default=None, blank=True, null=True)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    count = models.IntegerField(default=0)

    @classmethod
    def increment_search_count(cls, user, movie):
        searched_movie, _ = SearchedMovie.objects.get_or_create(user=user, movie=movie)

        SearchedMovie.objects.filter(user=user, movie=movie).update(
            count=F('count') + 1,
        )


class CollectedMovie(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    date = models.DateTimeField(default=timezone.now)
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
        movie_ids = CollectedMovie.objects.filter(user=user, type=CollectedMovie.TYPE_WATCH).values_list('movie', flat=True)
        return Movie.objects.filter(id__in=movie_ids)

    @staticmethod
    def is_favorite(user, movie):
        return CollectedMovie.objects.filter(user=user, movie=movie, type=CollectedMovie.TYPE_WISH).exists()

    @staticmethod
    def is_watched(user, movie):
        return CollectedMovie.objects.filter(user=user, movie=movie, type=CollectedMovie.TYPE_WATCH).exists()


class ExpertPickMovie(models.Model):
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    category = models.ForeignKey(ExpertPicksCategory, on_delete=models.CASCADE)
    order = models.IntegerField(default=1)

    @classmethod
    def get(cls, category):
        movies = ExpertPickMovie.objects\
            .order_by('order')\
            .prefetch_related('movie')\
            .filter(category=category)\
            .values_list('movie', flat=True)
        return Movie.objects.filter(id__in=movies).values()
