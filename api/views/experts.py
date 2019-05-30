import tmdbsimple as tmdb
from django.core.exceptions import ObjectDoesNotExist
from django.http import JsonResponse
from rest_framework.views import APIView

import config
from app.models import Movie
from app.models.expert_picks import ExpertPicksCategory
from app.models.movie_interaction import ExpertPickMovie
from app.views.utils import add_collected_data


class AddExpertPick(APIView):
    def post(self, request):
        tmdb.API_KEY = config.TMDB_API_KEY
        title = request.POST.get('title', '')
        year = request.POST.get('year', '0')
        search = tmdb.Search()
        search.movie(query=title)
        success = 0
        message = "Film with that title doesn't exist"
        for result in search.results:
            message = "There is a film with that title but isn't released in that year"
            release_date = result['release_date']
            split = release_date.split('-')
            if split[0] == year and result['title'] == title:
                picture = result['poster_path']
                id = result['id']
                success = 1
                message = "The film is successfully added"
                return JsonResponse({
                    'message': message,
                    'success': success,
                    'picture': picture,
                    'id': id,
                })
        return JsonResponse({
            'message': message,
            'success': success,
         })

class SavePicks(APIView):
    def post(self, request):
        tmdb.API_KEY = config.TMDB_API_KEY
        try:
            expert = ExpertPicksCategory.objects.get(expert_id=request.user.pk)
            category = expert.pk
            picks = ExpertPickMovie.objects.filter(category=category)
            picks.delete()
            str = request.POST.get('message', '')
            split = str.split(',')
            i = 1
            for spl in split:
                ID = int(spl)
                Movie.get_or_create(ID)
                new_pick = ExpertPickMovie(
                    category_id=category,
                    order=i,
                    movie_id=ID
                )
                new_pick.save()
                i = i+1
            message = "The list is saved"
            changes = 0
        except ObjectDoesNotExist:
            message = "The user is not expert"
            changes = 1
        return JsonResponse({
            'message': message,
            'changes': changes
        })


class ExpertPicksResponseView(APIView):
    def post(self, request):
        category_id = request.POST.get('category', '')
        picks = list(ExpertPickMovie.get(category_id))

        add_collected_data(picks, request)

        return JsonResponse({'picks': picks})
