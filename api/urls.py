from django.urls import path

from api.views import MovieInfo, ChatLoad, ChatReply, DeleteUser

urlpatterns = [
    path('movies/info/<int:pk>', MovieInfo.as_view()),
    path('chat/reply', ChatReply.as_view()),
    path('chat/load', ChatLoad.as_view()),
    path('admin_dashboard/delete_user', DeleteUser.as_view())
]
