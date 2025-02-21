# Generated by Django 2.2 on 2019-04-13 18:01

import django.contrib.postgres.fields.jsonb
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        ('app', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Message',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('type', models.CharField(choices=[('T', 'Text message'), ('D', 'Message with data')], default='T',
                                          max_length=1)),
                ('sender_type',
                 models.CharField(choices=[('U', 'Sender user'), ('B', 'Sender bot')], default='B', max_length=1)),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
                ('content', django.contrib.postgres.fields.jsonb.JSONField()),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.User')),
            ],
        ),
    ]
