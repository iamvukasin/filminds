from django.core.exceptions import ObjectDoesNotExist
from django.http import JsonResponse
from rest_framework.views import APIView

from app.models.expert_picks import ExpertPicksCategory
from app.models.user import AuthUser, User
from app.models.movie_interaction import ExpertPickMovie


def _get_message(username):
    if '@' in username:
        message = "Email doesn't exist."
    else:
        message = "Username doesn't exist."
    return message


def _remove_expert(username):
    auth_user = AuthUser.objects.get(username=username)
    user = User.objects.get(user_id=auth_user.pk)
    user.type = User.REGISTERED_USER
    user.save()
    category = ExpertPicksCategory.objects.get(expert_id=auth_user.pk)
    category.expert_id = None
    category.save()
    ExpertPickMovie.objects.filter(category=category.pk).delete()


class DeleteUser(APIView):
    def post(self, request):
        username = request.POST.get('message', '')

        try:
            if '@' in username:
                user = AuthUser.objects.get(email=username)
            else:
                user = AuthUser.objects.get(username=username)
            if user.is_active:
                if User.is_auth_user_admin(user):
                    message = "User is admin."
                else:
                    user_user = User.objects.get(user_id=user.pk)
                    if user_user.type == User.EXPERT:
                        _remove_expert(user.username)
                    user.is_active = False
                    user.save()
                    message = "User is successfully removed."
            else:
                message = _get_message(username)
        except ObjectDoesNotExist:
            message = _get_message(username)

        return JsonResponse({'message': message})


class AddExpert(APIView):
    def post(self, request):
        username = request.POST.get('expert', '')
        category = request.POST.get('category', '')
        success = 0
        try:
            if '@' in username:
                user = AuthUser.objects.get(email=username)
            else:
                user = AuthUser.objects.get(username=username)
            if user.is_active:
                if User.is_auth_user_expert(user):
                    message = "That user is already an expert."
                elif User.is_auth_user_admin(user):
                    message = "That user is admin."
                else:
                    expert = ExpertPicksCategory.objects.get(name__iexact=category)
                    if expert.expert_id is not None:
                        message = "An expert for that category already exists."
                    else:
                        expert.expert_id = user.pk
                        expert.save()
                        user_type = User.objects.get(user_id=user.pk)
                        user_type.type = User.EXPERT
                        user_type.save()
                        success = 1
                        message = "Expert added."
                        return JsonResponse({
                            'message': message,
                            'success': success,
                            'username': user.username,
                            'firstName': user.first_name,
                            'lastName': user.last_name,
                            'category': expert.name,
                            'email': user.email,
                        })
            else:
                message = _get_message(username)
        except ObjectDoesNotExist:
            message = _get_message(username)

        return JsonResponse({
            'message': message,
            'success': success
        })


class RemoveExpert(APIView):
    def post(self, request):
        username = request.POST.get('message', '')
        _remove_expert(username)
        return JsonResponse({'message': "Expert is successfully removed"})


class GetCategories(APIView):
    def post(self, request):
        categories = ExpertPicksCategory.objects.exclude(expert__isnull=False).order_by('name')
        message = ""
        values = ""
        for category in categories:
            message += category.name + ","
            values += str(category.pk) + ","
        return JsonResponse({
            'message': message,
            'values': values
        })
