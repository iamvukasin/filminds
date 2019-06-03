import tmdbsimple as tmdb
from django.contrib.auth.decorators import login_required
from django.core.exceptions import ObjectDoesNotExist
from django.http import JsonResponse
from django.utils.decorators import method_decorator
from rest_framework.views import APIView

import config
from api.serializers import MoviePickSerializer
from app.models import Movie, User
from app.models.expert_picks import ExpertPicksCategory
from app.models.movie_interaction import ExpertPickMovie


class AddExpertPick(APIView):
    def post(self, request):
        tmdb.API_KEY = config.TMDB_API_KEY
        title = request.POST.get('title', '')
        search = tmdb.Search()
        search.movie(query=title)
        success = 0
        message = "Film with that title doesn't exist"
        for result in search.results:
            release_date = result['release_date']
            split = release_date.split('-')
            picture = Movie.get_poster_url(result['poster_path'], is_small=True)
            id = result['id']
            success = 1
            message = "The film is successfully added"
            return JsonResponse({
                'message': message,
                'success': success,
                'picture': picture,
                'year': split[0],
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
    @method_decorator(login_required)
    def post(self, request):
        category_id = request.POST.get('category', '')
        picks = ExpertPickMovie.get(category_id)
        serializer = MoviePickSerializer(instance=picks, user=User.get_user(request.user), many=True)

        return JsonResponse(serializer.data, safe=False)


class Autosuggest(APIView):
    def post(self, request):
        tmdb.API_KEY = config.TMDB_API_KEY
        title = request.POST.get('title', '')
        search = tmdb.Search()
        search.movie(query=title)
        message = []
        i = 0
        for result in search.results:
            message.append(result['title'])
            i += 1
            if i == 10:
                break
        return JsonResponse({
            'message': message
        })
