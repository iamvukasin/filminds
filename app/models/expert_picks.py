from django.db import models

from .user import User


class ExpertPicksCategory(models.Model):
    name = models.CharField(max_length=30)
    expert = models.ForeignKey(User, null=True, on_delete=models.CASCADE)

    @staticmethod
    def get_all():
        return ExpertPicksCategory.objects.exclude(expert__isnull=True).values()

    @staticmethod
    def get_first():
        return ExpertPicksCategory.objects.exclude(expert__isnull=True).first()
