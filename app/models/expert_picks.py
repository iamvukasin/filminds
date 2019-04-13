from django.db import models

from .user import User


class ExpertPicksCategory(models.Model):
    name = models.CharField(max_length=30)
    expert = models.ForeignKey(User, null=True, on_delete=models.CASCADE)
