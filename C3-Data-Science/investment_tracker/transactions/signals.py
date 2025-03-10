from django.db.models.signals import post_migrate
from django.dispatch import receiver
from .models import Purpose

@receiver(post_migrate)
def create_purposes(sender, **kwargs):
    if sender.name == 'transactions':
        purposes = [
            'Ahorro',
            'Inversión a Largo Plazo',
            'Gastos Médicos',
            'Educación',
            'Viajes',
            'Emergencias',
        ]
        for purpose in purposes:
            Purpose.objects.get_or_create(name=purpose)