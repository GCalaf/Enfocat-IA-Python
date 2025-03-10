from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.models import User
import re
from .models import CustomUser, Profile

class CustomUserCreationForm(UserCreationForm):
    password1 = forms.CharField(label='Contraseña', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Confirmar Contraseña', widget=forms.PasswordInput)
    
    class Meta:
        model = CustomUser
        fields = ['username', 'email', 'password1', 'password2']
        labels = {
            'username': 'Nombre de Usuario',
            'email': 'Correo Electrónico',
        }
        help_texts = {
            'username': '',  # Ocultar el texto de ayuda predeterminado
        }

    def clean_username(self):
        username = self.cleaned_data.get('username')
        if not re.match(r'^[a-zA-Z0-9]*$', username):
            raise forms.ValidationError('El nombre de usuario solo puede contener letras y números.')
        return username

class ProfileForm(forms.ModelForm):
    class Meta:
        model = Profile
        fields = ['image', 'bio']
        labels = {
            'image': 'Imagen de Perfil',
            'bio': 'Biografía',
        }

class CustomAuthenticationForm(AuthenticationForm):
    username = forms.CharField(label='Nombre de Usuario', widget=forms.TextInput(attrs={'autofocus': True}))
    password = forms.CharField(label='Contraseña', strip=False, widget=forms.PasswordInput)