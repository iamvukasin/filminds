from django.db import models
from django.contrib.auth.models import User as AuthUser
from django.db.models.signals import post_save
from django.dispatch import receiver


class User(models.Model):
    REGISTERED_USER = 'R'
    EXPERT = 'E'
    ADMIN = 'A'
    USER_TYPE_CHOICES = (
        (REGISTERED_USER, 'Registered user'),
        (EXPERT, 'Movie expert'),
        (ADMIN, 'Administrator')
    )

    user = models.OneToOneField(AuthUser, on_delete=models.CASCADE)
    type = models.CharField(
        max_length=1,
        choices=USER_TYPE_CHOICES,
        default=REGISTERED_USER
    )


@receiver(post_save, sender=AuthUser)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        User.objects.create(user=instance)


@receiver(post_save, sender=AuthUser)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()
