from django.urls import path

from api.views import MovieInfo
from api.views.chat import ChatLoad
from api.views import ChatReply

urlpatterns = [
    path('movies/info/<int:pk>', MovieInfo.as_view()),
    path('chat/reply', ChatReply.as_view()),
    path('chat/load', ChatLoad.as_view())
]
