from django.contrib.auth import views as auth_views
from django.urls import path

from app.views import IndexView, LoginView, RegistrationView, ChatView

urlpatterns = [
    path('', IndexView.as_view(), name='index'),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('register/', RegistrationView.as_view(), name='register'),
    path('chat/', ChatView.as_view(), name='chat')
]
