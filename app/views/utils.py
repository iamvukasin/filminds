from django.contrib.auth import REDIRECT_FIELD_NAME
from django.contrib.auth.decorators import user_passes_test
from django.shortcuts import redirect

from app.models import User, Movie, CollectedMovie


def anonymous_required(redirect_page='index'):
    """
    Decorator for views that checks that the user is not logged in,
    redirecting to the redirect page if necessary.

    :param redirect_page: the name of the page where the authenticated
    user will be redirected
    """

    def decorator(func):
        def as_view(request, *args, **kwargs):
            if request.user.is_authenticated:
                return redirect(redirect_page)

            response = func(request, *args, **kwargs)
            return response

        return as_view

    return decorator


def expert_required(function=None, redirect_field_name=REDIRECT_FIELD_NAME, login_url=None):
    """
    Decorator for views that checks that the user is an expert,
    redirecting to the login page if necessary.
    """

    actual_decorator = user_passes_test(
        lambda u: User.is_auth_user_expert(u),
        login_url=login_url,
        redirect_field_name=redirect_field_name
    )

    if function:
        return actual_decorator(function)

    return actual_decorator


def admin_required(function=None, redirect_field_name=REDIRECT_FIELD_NAME, login_url=None):
    """
    Decorator for views that checks that the user is an administrator,
    redirecting to the login page if necessary.
    """

    actual_decorator = user_passes_test(
        lambda u: User.is_auth_user_admin(u),
        login_url=login_url,
        redirect_field_name=redirect_field_name
    )

    if function:
        return actual_decorator(function)

    return actual_decorator


def add_collected_data(recommended_movies, request):
    """
    Inserts information if the movie is collected by current user.
    """

    for recommended_movie in recommended_movies:
        if request.user.is_authenticated and Movie.exists(recommended_movie['id']):
            user = User.get_user(request.user)
            movie = Movie.get_or_create(recommended_movie['id'])

            if CollectedMovie.is_favorite(user, movie):
                recommended_movie['favorite'] = True
            elif CollectedMovie.is_watched(user, movie):
                recommended_movie['watched'] = True
