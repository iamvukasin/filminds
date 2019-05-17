from django import forms
from django.contrib.auth.forms import UserCreationForm

from app.models.user import AuthUser


class RegistrationForm(UserCreationForm):
    first_name = forms.CharField(label='First name', required=True, widget=forms.TextInput())
    last_name = forms.CharField(label='Last name', required=True, widget=forms.TextInput())
    email = forms.EmailField(label='Email', required=True, widget=forms.EmailInput())

    class Meta(UserCreationForm.Meta):
        model = AuthUser
        fields = ('first_name', 'last_name', 'email') + UserCreationForm.Meta.fields

    def clean_email(self):
        """
        Validates if the entered email is being used by another user.

        :return: cleaned email
        :raises: ValidationError if the email already exists
        """

        email = self.cleaned_data.get('email')
        username = self.cleaned_data.get('username')

        if email and AuthUser.objects.filter(email__iexact=email).exclude(username=username).exists():
            raise forms.ValidationError('A user with that email already exists.')

        return email
