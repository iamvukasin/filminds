from django.db import models

from .user import User


class ExpertPicksCategory(models.Model):
    name = models.CharField(max_length=30)
    expert = models.ForeignKey(User, null=True, on_delete=models.CASCADE)

    class Meta:
        ordering = ['name']

    @staticmethod
    def _get_valid_categories():
        """
        Returns categories which have a dedicated expert and have at
        least one movie added.

        :return: the list of valid categories
        """

        return ExpertPicksCategory.objects.filter(expert__isnull=False, expertpickmovie__isnull=False).distinct()

    @classmethod
    def get_all(cls):
        return cls._get_valid_categories().values()

    @classmethod
    def get_first(cls):
        return cls._get_valid_categories().first()
