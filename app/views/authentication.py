from django.conf import settings
from django.contrib.auth import login, views as auth_views
from django.shortcuts import render, redirect
from django.utils.decorators import method_decorator
from django.views.generic.edit import FormView
from django.contrib.auth.forms import AuthenticationForm

from app.forms import RegistrationForm
from app.views.utils import anonymous_required


class IndexView(FormView):
    """
    Home page view with login form.
    """

    template_name = 'index.html'
    form_class = AuthenticationForm
    login_headline = 'Smart movie recommendations for you!'
    login_description_text = 'Decide which movie to watch next just by asking our personal movie assistant.'

    @method_decorator(anonymous_required(settings.LOGIN_REDIRECT_URL))
    def get(self, request, *args, **kwargs):
        return render(request, self.template_name, {
            'login_headline': self.login_headline,
            'login_description_text': self.login_description_text,
            'form': self.form_class()
        })


class LoginView(auth_views.LoginView):
    """
    View for user login.
    """

    template_name = 'login.html'

    def __init__(self, *args, **kwargs):
        super(LoginView, self).__init__(*args, **kwargs)

    @method_decorator(anonymous_required(settings.LOGIN_REDIRECT_URL))
    def get(self, request, *args, **kwargs):
        return super(LoginView, self).get(request, *args, **kwargs)


class RegistrationView(FormView):
    """
    View for user registration.
    """

    template_name = 'register.html'
    form_class = RegistrationForm

    @method_decorator(anonymous_required(settings.LOGIN_REDIRECT_URL))
    def get(self, request, *args, **kwargs):
        return render(request, self.template_name, {
            'form': self.form_class()
        })

    def post(self, request, *args, **kwargs):
        form = self.form_class(request.POST)

        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('chat')

        return render(request, self.template_name, {
            'form': form
        })
