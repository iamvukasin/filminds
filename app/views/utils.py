from django.contrib.auth import REDIRECT_FIELD_NAME
from django.contrib.auth.decorators import user_passes_test
from django.shortcuts import redirect

from app.models import User


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
        lambda u: u is not None and User.get_user(u).is_expert,
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
        lambda u: u is not None and User.get_user(u).is_admin,
        login_url=login_url,
        redirect_field_name=redirect_field_name
    )

    if function:
        return actual_decorator(function)

    return actual_decorator
