from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from django.utils.decorators import method_decorator
from django.views.generic import TemplateView

from app.models import CollectedMovie, User, ExpertPicksCategory
from app.models.user import AuthUser


class ChatView(TemplateView):
    template_name = "chat.html"


class FavoritesView(TemplateView):
    template_name = "collected.html"

    @method_decorator(login_required)
    def get(self, request, *args, **kwargs):
        return render(request, self.template_name, {
            'type' : 'Favorites',
            'movies': CollectedMovie.get_favorites(User.get_user(request.user))
        })


class WatchedView(TemplateView):
    template_name = "collected.html"

    @method_decorator(login_required)
    def get(self, request, *args, **kwargs):
        return render(request, self.template_name, {
            'type' : 'Watched',
            'movies': CollectedMovie.get_watched(User.get_user(request.user))
        })


class ExpertPicksView(TemplateView):
    template_name = "expert-picks.html"


class AddExpertPicksView(TemplateView):
    template_name = "add-expert-picks.html"


class StatisticsView(TemplateView):
    template_name = "statistics.html"


class AdminDashboardView(TemplateView):
    template_name = "admin-dashboard.html"

    @method_decorator(login_required)
    def get(self, request, *args, **kwargs):
        categories = ExpertPicksCategory.objects.all()
        experts = []

        for categorie in categories:
            expert = AuthUser.objects.get(id=categorie.expert_id)
            experts.append({
                'first_name': expert.first_name,
                'last_name': expert.last_name,
                'username': expert.username,
                'email': expert.email,
                'category': categorie.name
            })

        return render(request, self.template_name, {
            'experts': experts
        })
