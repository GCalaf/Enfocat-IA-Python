from django import forms
from django.contrib.auth.forms import UserCreationForm
from .models import CustomUser

class CustomUserCreationForm(UserCreationForm):
    risk_tolerance = forms.ChoiceField(choices=CustomUser.RISK_TOLERANCE_CHOICES, label='Tolerancia al Riesgo')
    password1 = forms.CharField(label='Contraseña', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Confirmar Contraseña', widget=forms.PasswordInput)
    class Meta:
        model = CustomUser
        fields = ('username', 'email', 'password1', 'password2', 'risk_tolerance')
        labels = {
            'username': 'Nombre de Usuario',
            'email': 'Correo Electrónico',
            'risk_tolerance': 'Tolerancia al Riesgo'
        
        }