from django.views.generic import TemplateView


class IndexView(TemplateView):
    template_name = "index.html"


class RegisterView(TemplateView):
    template_name = "register.html"


class ChatView(TemplateView):
    template_name = "chat.html"
