from django.db import models

from .user import User
from .movie import Movie
from .expert_picks import ExpertPicksCategory


class SearchedMovie(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, default=None, blank=True, null=True)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    count = models.IntegerField(default=0)


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


class ExpertPickMovie(models.Model):
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    category = models.ForeignKey(ExpertPicksCategory, on_delete=models.CASCADE)
    order = models.IntegerField(default=1)
