from django.db import models

from .user import User
from .movie import Movie


class SearchedMovie(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
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
