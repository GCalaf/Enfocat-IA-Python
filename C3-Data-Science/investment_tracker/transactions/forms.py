from django import forms
from .models import Transaction
from portfolio.models import Investment

class TransactionForm(forms.ModelForm):
    class Meta:
        model = Transaction
        fields = ['investment', 'transaction_date', 'amount', 'transaction_type']
        widgets = {
            'transaction_date': forms.DateInput(attrs={'type': 'date'}),
        }
        labels = {
            'investment': 'Inversión',
            'transaction_date': 'Fecha de Transacción',
            'amount': 'Cantidad',
            'transaction_type': 'Tipo de Transacción'
        }

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user')
        super().__init__(*args, **kwargs)
        self.fields['investment'].queryset = Investment.objects.filter(user=user)