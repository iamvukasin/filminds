from django.shortcuts import redirect


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
