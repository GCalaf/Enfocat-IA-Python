from django.db import models
from django.conf import settings

# Modelo para representar una inversión
class Investment(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    initial_amount = models.DecimalField(max_digits=10, decimal_places=2)
    current_value = models.DecimalField(max_digits=10, decimal_places=2)
    purchase_date = models.DateField()
    investment_type = models.CharField(max_length=50)

    def __str__(self):
        return self.name