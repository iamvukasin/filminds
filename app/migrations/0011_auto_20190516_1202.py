# Generated by Django 2.2.1 on 2019-05-16 12:02

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ('app', '0010_auto_20190514_1804'),
    ]

    operations = [
        migrations.AlterField(
            model_name='movie',
            name='description',
            field=models.CharField(max_length=300),
        ),
    ]
