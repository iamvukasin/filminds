from django.core.exceptions import ObjectDoesNotExist
from django.shortcuts import render
from django.utils.decorators import method_decorator
from django.views.generic import TemplateView

from app.models import CollectedMovie, User, ExpertPicksCategory, ExpertPickMovie, Movie
from app.models.user import AuthUser
from app.views.utils import expert_required, admin_required


class ChatView(TemplateView):
    template_name = "chat.html"


class FavoritesView(TemplateView):
    template_name = "collected.html"

    def get(self, request, *args, **kwargs):
        is_authenticated = request.user.is_authenticated

        return render(request, self.template_name, {
            'type': 'Favorites',
            'movies': CollectedMovie.get_favorites(User.get_user(request.user)) if is_authenticated else None
        })


class WatchedView(TemplateView):
    template_name = "collected.html"

    def get(self, request, *args, **kwargs):
        is_authenticated = request.user.is_authenticated

        return render(request, self.template_name, {
            'type': 'Watched',
            'movies': CollectedMovie.get_watched(User.get_user(request.user)) if is_authenticated else None
        })


class ExpertPicksView(TemplateView):
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
    template_name = "statistics.html"

    @method_decorator(admin_required)
    def get(self, request, *args, **kwargs):
        return render(request, self.template_name)


class AdminDashboardView(TemplateView):
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
