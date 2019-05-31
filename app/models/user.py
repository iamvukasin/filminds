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

    @staticmethod
    def get_user(auth_user):
        return User.objects.get(user=auth_user)

    @staticmethod
    def is_auth_user_expert(auth_user):
        return auth_user.is_authenticated and User.get_user(auth_user).is_expert

    @staticmethod
    def is_auth_user_admin(auth_user):
        return auth_user.is_authenticated and User.get_user(auth_user).is_admin

    @property
    def is_registered(self):
        return self.type == self.REGISTERED_USER

    @property
    def is_expert(self):
        return self.type == self.EXPERT

    @property
    def is_admin(self):
        return self.type == self.ADMIN


@receiver(post_save, sender=AuthUser)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        user_type = User.ADMIN if instance.is_superuser else User.REGISTERED_USER
        User.objects.create(user=instance, type=user_type)


@receiver(post_save, sender=AuthUser)
def save_user_profile(sender, instance, **kwargs):
    instance.user.save()
