from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    RISK_TOLERANCE_CHOICES = [
        ('low', 'Bajo'),
        ('medium', 'Medio'),
        ('high', 'Alto'),
    ]
    risk_tolerance = models.CharField(max_length=6, choices=RISK_TOLERANCE_CHOICES, default='medium')