import json

from django.contrib.postgres.fields import JSONField
from django.db import models

from .user import User


class Message(models.Model):
    SENDER_USER = 'U'
    SENDER_BOT = 'B'
    MESSAGE_SENDER_CHOICES = (
        (SENDER_USER, "Sender user"),
        (SENDER_BOT, "Sender bot")
    )

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    sender_type = models.CharField(
        max_length=1,
        choices=MESSAGE_SENDER_CHOICES,
        default=SENDER_BOT
    )
    timestamp = models.DateTimeField(auto_now_add=True)
    content = JSONField()

    @staticmethod
    def get_messages(user):
        return Message.objects.filter(user=user).values('sender_type', 'content').order_by('timestamp')
