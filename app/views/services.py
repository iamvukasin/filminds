from django.views.generic import TemplateView


class ChatView(TemplateView):
    template_name = "chat.html"


class FavoritesView(TemplateView):
    template_name = "favorites.html"


class WatchedView(TemplateView):
    template_name = "watched.html"


class ExpertPicksView(TemplateView):
    template_name = "expert-picks.html"


class AddExpertPicksView(TemplateView):
    template_name = "add-expert-picks.html"


class StatisticsView(TemplateView):
    template_name = "statistics.html"


class AdminDashboardView(TemplateView):
    template_name = "admin-dashboard.html"
