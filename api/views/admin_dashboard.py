from django.core.exceptions import ObjectDoesNotExist
from django.http import JsonResponse

from rest_framework.views import APIView
from app.models.user import AuthUser, User


class DeleteUser(APIView):
    def post(self, request):
        username = request.POST.get('message', '')

        try:
            if '@' in username:
                user = AuthUser.objects.get(email=username)
            else:
                user = AuthUser.objects.get(username=username)

            user = User.get_user(user)

            if user.type == User.ADMIN:
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

