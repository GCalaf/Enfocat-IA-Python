from django import forms
from .models import Transaction, Purpose
from portfolio.models import Investment

class TransactionForm(forms.ModelForm):
    class Meta:
        model = Transaction
        fields = ['investment', 'transaction_date', 'amount', 'purposes']
        widgets = {
            'transaction_date': forms.DateInput(attrs={'type': 'date'}),
            'purposes': forms.CheckboxSelectMultiple,
        }
        labels = {
            'investment': 'Inversión',
            'transaction_date': 'Fecha de Transacción',
            'amount': 'Monto',
            'purposes': 'Propósitos',
        }

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user', None)
        super().__init__(*args, **kwargs)
        if user:
            self.fields['investment'].queryset = user.investment_set.all()
        self.fields['purposes'].queryset = Purpose.objects.all()

class PurposeForm(forms.ModelForm):
    class Meta:
        model = Purpose
        fields = ['name']