from django.core.paginator import Paginator
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Investment
from .forms import InvestmentForm

# Vista para listar las inversiones del usuario
@login_required
def investment_list(request):
    investments = Investment.objects.filter(user=request.user)
    paginator = Paginator(investments, 5)  # Número de registros por página
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'portfolio/investment_list.html', {'page_obj': page_obj})

# Vista para mostrar el detalle de una inversión específica
@login_required
def investment_detail(request, pk):
    investment = get_object_or_404(Investment, pk=pk)
    return render(request, 'portfolio/investment_detail.html', {'investment': investment})

# Vista para crear una nueva inversión
@login_required
def investment_new(request):
    if request.method == "POST":
        form = InvestmentForm(request.POST)
        if form.is_valid():
            investment = form.save(commit=False)
            investment.user = request.user
            investment.save()
            messages.success(request, 'Inversión creada exitosamente.')
            return redirect('portfolio:investment_detail', pk=investment.pk)
        else:
            messages.error(request, 'Por favor corrige los errores a continuación.')
    else:
        form = InvestmentForm()
    return render(request, 'portfolio/investment_edit.html', {'form': form})

# Vista para editar una inversión existente
@login_required
def investment_edit(request, pk):
    investment = get_object_or_404(Investment, pk=pk)
    if request.method == "POST":
        form = InvestmentForm(request.POST, instance=investment)
        if form.is_valid():
            form.save()
            messages.success(request, 'Inversión actualizada exitosamente.')
            return redirect('portfolio:investment_detail', pk=investment.pk)
        else:
            messages.error(request, 'Por favor corrige los errores a continuación.')
    else:
        form = InvestmentForm(instance=investment)
    return render(request, 'portfolio/investment_edit.html', {'form': form})

# Vista para eliminar una inversión
@login_required
def investment_delete(request, pk):
    investment = get_object_or_404(Investment, pk=pk)
    investment.delete()
    messages.success(request, 'Inversión eliminada exitosamente.')
    return redirect('portfolio:investment_list')