from django.db import models
from django.db.models.signals import pre_save
from django.dispatch import receiver

from app import utils


class MovieGenre(models.Model):
    id = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=20)

    @staticmethod
    def get_genre_id_by_name(genre_name):
        """
        Returns genre ID for genre with the given name, if exists.
        """

        genre = MovieGenre.objects.filter(name__iexact=genre_name).first()
        return genre.id if genre is not None else None

    @staticmethod
    def get_genre_ids_by_names(genre_names):
        """
        Returns list of genre IDs for the given names.

        :param genre_names: a list of genre names
        :return: a list of genre IDs
        """

        if not genre_names:
            return []

        return MovieGenre.objects.filter(name__iregex=r'(' + '|'.join(genre_names) + ')').values_list('id', flat=True)


class Movie(models.Model):
    # constraints
    TITLE_MAX_LENGTH = 100
    DESCRIPTION_MAX_LENGTH = 300

    # fields
    id = models.IntegerField(primary_key=True)
    title = models.CharField(max_length=TITLE_MAX_LENGTH)
    description = models.CharField(max_length=DESCRIPTION_MAX_LENGTH)
    rating = models.DecimalField(
        max_digits=3,
        decimal_places=1
    )
    release_date = models.DateField()
    poster = models.CharField(max_length=50, null=True)
    backdrop = models.CharField(max_length=50, null=True)
    trailer = models.CharField(max_length=70, null=True)
    genres = models.ManyToManyField(MovieGenre)


@receiver(pre_save, sender=Movie)
def limit_movie_char_fields(sender, instance, *args, **kwargs):
    """
    Limits Movie's character fields based on maximum length.
    """

    if len(instance.title) > Movie.TITLE_MAX_LENGTH:
        instance.title = instance.title[:Movie.TITLE_MAX_LENGTH-1] + '…'

    instance.description = utils.trim_text_by_sentence(instance.description, Movie.DESCRIPTION_MAX_LENGTH)
