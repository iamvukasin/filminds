from django.urls import path, re_path

from api.views import MovieAddToFavorites, MovieAddToWatched, RemoveCollectedMovie, MovieInfo, ChatLoad, ChatReply,\
    DeleteUser, AddExpert, RemoveExpert, AddExpertPick, SavePicks, ExpertPicksResponseView, Statistics,\
    GetCategories, Autosuggest

urlpatterns = [
    path('movies/favorites/add/<int:pk>', MovieAddToFavorites.as_view()),
    re_path(r'movies/(?:favorites|watched)/remove/(?P<pk>[0-9]+)', RemoveCollectedMovie.as_view()),
    path('movies/watched/add/<int:pk>', MovieAddToWatched.as_view()),
    path('movies/info/<int:pk>', MovieInfo.as_view()),
    path('chat/reply', ChatReply.as_view()),
    path('chat/load', ChatLoad.as_view()),
    path('admin_dashboard/delete_user', DeleteUser.as_view()),
    path('admin_dashboard/add_expert', AddExpert.as_view()),
    path('admin_dashboard/remove_expert', RemoveExpert.as_view()),
    path('admin_dashboard/get_categories', GetCategories.as_view()),
    path('expert_picks/expert_pick', AddExpertPick.as_view()),
    path('expert_picks/save_picks', SavePicks.as_view()),
    path('expert-picks/response', ExpertPicksResponseView.as_view()),
    path('expert-picks/autosuggest', Autosuggest.as_view()),
    path('statistics', Statistics.as_view()),
]
