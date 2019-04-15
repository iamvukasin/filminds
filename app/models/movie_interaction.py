from django.db import models

from .user import User
from .movie import Movie


class SearchedMovie(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    count = models.IntegerField(default=0)
