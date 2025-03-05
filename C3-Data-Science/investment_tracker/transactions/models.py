from django.db import models
from portfolio.models import Investment

class Transaction(models.Model):
    investment = models.ForeignKey(Investment, on_delete=models.CASCADE)
    transaction_date = models.DateField()
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    transaction_type = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.transaction_type} - {self.amount}"