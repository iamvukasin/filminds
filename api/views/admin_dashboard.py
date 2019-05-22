from django.core.exceptions import ObjectDoesNotExist
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.views import APIView

from app.models.expert_picks import ExpertPicksCategory
from app.models.movie import MovieGenre
from app.models.user import AuthUser, User


class DeleteUser(APIView):
    def post(self, request):
        username = request.POST.get('message', '')

        try:
            if '@' in username:
                user = AuthUser.objects.get(email=username)
            else:
                user = AuthUser.objects.get(username=username)

            check = User.get_user(user)

            if check.type == User.ADMIN:
                message = "User is admin."
            else:
                user.delete()
                message = "User is successfully removed."
        except ObjectDoesNotExist:
            if '@' in username:
                message = "Email doesn't exist."
            else:
                message = "Username doesn't exist."

        return JsonResponse({'message': message})


class AddExpert(APIView):
    def post(self, request):
        username = request.POST.get('expert', '')
        category = request.POST.get('category', '')
        try:
            if '@' in username:
                user = AuthUser.objects.get(email=username)
            else:
                user = AuthUser.objects.get(username=username)
            user_type = User.objects.get(user_id=user.pk)
            if user_type.type == User.EXPERT:
                message = "That user is already an expert."
            elif user.is_staff:
                message = "That user is admin."
            else:
                try:
                    ExpertPicksCategory.objects.get(name__iexact=category)
                    message = "An expert for that category already exists."
                except ObjectDoesNotExist:
                    expert = ExpertPicksCategory(name=category, expert_id=user.pk)
                    user_type = User.objects.get(user_id=user.pk)
                    user_type.type = User.EXPERT
                    user_type.save()
                    expert.save()
                    message = "Expert added."
        except ObjectDoesNotExist:
            if '@' in username:
                message = "Email doesn't exist."
            else:
                message = "Username doesn't exist."

        return JsonResponse({'message': message})
