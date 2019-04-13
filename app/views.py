from django.views.generic import TemplateView


class IndexView(TemplateView):
    template_name = "index.html"
    login_headline = "Smart movie recommendations for you!"
    login_description_text = "Decide which movie to watch next just by asking our personal movie assistant."


class RegisterView(TemplateView):
    template_name = "register.html"


class ChatView(TemplateView):
    template_name = "chat.html"
