from django import forms
from .models import Investment

class InvestmentForm(forms.ModelForm):
    class Meta:
        model = Investment
        fields = ['name', 'initial_amount', 'current_value', 'purchase_date', 'investment_type']
        widgets = {
            'purchase_date': forms.DateInput(attrs={'type': 'date'}),
        }
        labels = {
            'name': 'Nombre',
            'initial_amount': 'Cantidad Inicial',
            'current_value': 'Valor Actual',
            'purchase_date': 'Fecha de Compra',
            'investment_type': 'Tipo de Inversión'
        }