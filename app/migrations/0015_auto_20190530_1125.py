# Generated by Django 2.2.1 on 2019-05-30 11:25

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):
    dependencies = [
        ('app', '0014_auto_20190517_2232'),
    ]

    operations = [
        migrations.AlterField(
            model_name='collectedmovie',
            name='date',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
        migrations.AlterField(
            model_name='message',
            name='timestamp',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
    ]
