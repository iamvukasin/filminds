import tmdbsimple as tmdb
from django.contrib.staticfiles.templatetags.staticfiles import static
from django.db import models
from django.db.models.signals import pre_save
from django.dispatch import receiver
from requests import HTTPError

import config
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

    @property
    def poster_url(self):
        return self.get_poster_url(self.poster)

    @property
    def backdrop_url(self):
        return self.get_backdrop_url(self.backdrop)

    @property
    def trailer_url(self):
        return self.get_trailer_url(self.trailer)

    @staticmethod
    def get_poster_url(poster, is_small=False):
        if poster is None:
            size_suffix = '-small' if is_small else ''
            return static(f'images/default-poster{size_suffix}.png')
        else:
            size = 'w185' if is_small else 'w600_and_h900_bestv2'
            return f'https://image.tmdb.org/t/p/{size}{poster}'

    @staticmethod
    def get_backdrop_url(backdrop):
        if backdrop is None:
            return static('images/default-backdrop.png')
        else:
            return f'https://image.tmdb.org/t/p/w400{backdrop}'

    @staticmethod
    def get_trailer_url(trailer):
        return f'https://youtu.be/{trailer}' if trailer is not None else None

    @classmethod
    def _get_trailers_from_videos(cls, videos):
        finder = (video['key'] for video in videos if video['site'] == 'YouTube' and video['type'] == 'Trailer')
        return next(finder, None)

    @classmethod
    def get_or_create(cls, pk):
        try:
            return Movie.objects.get(pk=pk)
        except Movie.DoesNotExist:
            try:
                # find all movies with basic information + trailer videos
                tmdb.API_KEY = config.TMDB_API_KEY
                found_movie = tmdb.Movies(pk).info(append_to_response='videos')

                movie = Movie(
                    id=pk,
                    title=found_movie['title'],
                    description=found_movie['overview'],
                    rating=found_movie['vote_average'],
                    release_date=found_movie['release_date'],
                    poster=found_movie['poster_path'],
                    backdrop=found_movie['backdrop_path'],
                    trailer=cls._get_trailers_from_videos(found_movie['videos']['results'])
                )
                movie.save()

                # add genres
                for found_genre in found_movie['genres']:
                    genre = MovieGenre.objects.get(pk=found_genre['id'])
                    movie.genres.add(genre)

                return movie
            except HTTPError:
                return None

    @classmethod
    def exists(cls, id):
        return Movie.objects.filter(id=id).exists()


@receiver(pre_save, sender=Movie)
def limit_movie_char_fields(sender, instance, *args, **kwargs):
    """
    Limits Movie's character fields based on maximum length.
    """

    if len(instance.title) > Movie.TITLE_MAX_LENGTH:
        instance.title = instance.title[:Movie.TITLE_MAX_LENGTH-1] + '…'

    instance.description = utils.trim_text_by_sentence(instance.description, Movie.DESCRIPTION_MAX_LENGTH)
