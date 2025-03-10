from django.db import models
from portfolio.models import Investment

class Purpose(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class Transaction(models.Model):
    investment = models.ForeignKey(Investment, on_delete=models.CASCADE)
    transaction_date = models.DateField()
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    purposes = models.ManyToManyField(Purpose, related_name='transactions')

    def __str__(self):
        return f"{self.amount} - {self.transaction_date}"