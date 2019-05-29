from django.urls import path

from api.views import MovieAddToFavorites, MovieAddToWatched, RemoveCollectedMovie, MovieInfo, ChatLoad, ChatReply,\
    DeleteUser, AddExpert, RemoveExpert, AddExpertPick, SavePicks, ExpertPicksResponseView

urlpatterns = [
    path('movies/favorites/add/<int:pk>', MovieAddToFavorites.as_view()),
    path('movies/favorites/remove/<int:pk>', RemoveCollectedMovie.as_view()),
    path('movies/watched/add/<int:pk>', MovieAddToWatched.as_view()),
    path('movies/watched/remove/<int:pk>', RemoveCollectedMovie.as_view()),
    path('movies/info/<int:pk>', MovieInfo.as_view()),
    path('chat/reply', ChatReply.as_view()),
    path('chat/load', ChatLoad.as_view()),
    path('admin_dashboard/delete_user', DeleteUser.as_view()),
    path('admin_dashboard/add_expert', AddExpert.as_view()),
    path('admin_dashboard/remove_expert', RemoveExpert.as_view()),
    path('expert_picks/expert_pick', AddExpertPick.as_view()),
    path('expert_picks/save_picks', SavePicks.as_view()),
    path('expert-picks/response', ExpertPicksResponseView.as_view()),
]
