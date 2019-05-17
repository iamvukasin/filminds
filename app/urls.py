from django.contrib.auth import views as auth_views
from django.urls import path

from app.views import IndexView, LoginView, RegistrationView, ChatView, FavoritesView, WatchedView, ExpertPicksView,\
    AddExpertPicksView, StatisticsView, AdminDashboardView

urlpatterns = [
    path('', IndexView.as_view(), name='index'),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('register/', RegistrationView.as_view(), name='register'),
    path('chat/', ChatView.as_view(), name='chat'),
    path('favorites/', FavoritesView.as_view(), name='favorites'),
    path('watched/', WatchedView.as_view(), name='watched'),
    path('expert-picks/', ExpertPicksView.as_view(), name='expert_picks'),
    path('add-expert-picks/', AddExpertPicksView.as_view(), name='add_expert_picks'),
    path('statistics/', StatisticsView.as_view(), name='statistics'),
    path('admin-dashboard/', AdminDashboardView.as_view(), name="admin_dashboard")
]
