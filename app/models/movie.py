from django.db import models


class MovieGenre(models.Model):
    id = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=20)


class Movie(models.Model):
    id = models.IntegerField(primary_key=True)
    title = models.CharField(max_length=100)
    description = models.CharField(max_length=200)
    rating = models.DecimalField(
        max_digits=3,
        decimal_places=1
    )
    release_date = models.DateField()
    trailer = models.CharField(max_length=70)
    genres = models.ManyToManyField(MovieGenre)
