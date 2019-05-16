from django.urls import path

from api.views import MovieInfo

urlpatterns = [
    path('movies/info/<int:pk>', MovieInfo.as_view())
]
