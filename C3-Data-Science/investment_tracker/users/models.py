from django.contrib.auth.models import AbstractUser
from django.db import models

# Modelo personalizado de usuario
class CustomUser(AbstractUser):
    pass

# Modelo para representar el perfil del usuario
class Profile(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    image = models.ImageField(upload_to='profiles/', blank=True, null=True)
    bio = models.TextField(blank=True)

    def __str__(self):
        return self.user.username