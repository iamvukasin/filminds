from django.core.exceptions import ObjectDoesNotExist
from django.shortcuts import render
from django.utils.decorators import method_decorator
from django.views.generic import TemplateView

from app.models import CollectedMovie, User, ExpertPicksCategory, ExpertPickMovie, Movie
from app.models.user import AuthUser
from app.views.utils import expert_required, admin_required, expert_or_admin_required


class ChatView(TemplateView):
    """
    View where user can send text messages to the bot.
    """

    template_name = "chat.html"


class FavoritesView(TemplateView):
    """
    View where user can see a list of movies saved to watch.
    """

    template_name = "collected.html"

    def get(self, request, *args, **kwargs):
        is_authenticated = request.user.is_authenticated

        return render(request, self.template_name, {
            'type': 'Favorites',
            'movies': CollectedMovie.get_favorites(User.get_user(request.user)) if is_authenticated else None
        })


class WatchedView(TemplateView):
    """
    View where user can see a list of movies marked as watched.
    """

    template_name = "collected.html"

    def get(self, request, *args, **kwargs):
        is_authenticated = request.user.is_authenticated

        return render(request, self.template_name, {
            'type': 'Watched',
            'movies': CollectedMovie.get_watched(User.get_user(request.user)) if is_authenticated else None
        })


class ExpertPicksView(TemplateView):
    """
    View where user can see a list of movies from specific categories
    recommended by experts.
    """

    template_name = "expert-picks.html"

    def get(self, request, *args, **kwargs):
        categories = ExpertPicksCategory.get_all()
        category = ExpertPicksCategory.get_first()
        category_name = category.name if category is not None else ''

        return render(request, self.template_name, {
            'categories': categories,
            'category_name': category_name
        })


class AddExpertPicksView(TemplateView):
    """
    View where expert can see picks he posted or add new picks.
    """

    template_name = "add-expert-picks.html"

    @method_decorator(expert_required)
    def get(self, request, *args, **kwargs):
        try:
            category = ExpertPicksCategory.objects.get(expert_id=request.user.pk)
            area = category.name
            try:
                picks = ExpertPickMovie.objects.filter(category_id=category)
                movies = []
                i = 1
                code = ""
                for pick in picks:
                    movie = Movie.objects.get(pk=pick.movie_id)
                    year = movie.release_date.year
                    code += str(pick.movie_id)+","
                    mov = {
                        'id': movie.pk,
                        'src': Movie.get_poster_url(movie.poster, is_small=True),
                        'order': i,
                        'title': movie.title,
                        'year': year,
                    }
                    movies.append(mov)
                    i = i+1
            except ObjectDoesNotExist:
                movies = []
                code = ""
        except ObjectDoesNotExist:
            area = ""
            movies = []
            code = ""
        return render(request, self.template_name, {
            'category': area,
            'changes': 0,
            'movies': movies,
            'code': code
        })


class StatisticsView(TemplateView):
    """
    View for admin and expert user to have a look at various statistics.
    """
    template_name = "statistics.html"

    @method_decorator(expert_or_admin_required)
    def get(self, request, *args, **kwargs):
        return render(request, self.template_name, {
            'is_admin': User.is_auth_user_admin(request.user)
        })


class AdminDashboardView(TemplateView):
    """
    View for admin user to maintain the site.
    """

    template_name = "admin-dashboard.html"

    @method_decorator(admin_required)
    def get(self, request, *args, **kwargs):
        categories = ExpertPicksCategory.objects.exclude(expert__isnull=True)
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
