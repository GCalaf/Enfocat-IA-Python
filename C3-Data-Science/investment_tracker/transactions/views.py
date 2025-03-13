from django.core.paginator import Paginator
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib import messages
from .models import Transaction, Purpose
from .forms import TransactionForm, PurposeForm

# Vista para listar las transacciones del usuario
@login_required
def transaction_list(request):
    transactions = Transaction.objects.filter(investment__user=request.user)
    paginator = Paginator(transactions, 5)  # Número de registros por página
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'transactions/transaction_list.html', {'page_obj': page_obj})

# Vista para mostrar el detalle de una transacción específica
@login_required
def transaction_detail(request, pk):
    transaction = get_object_or_404(Transaction, pk=pk)
    return render(request, 'transactions/transaction_detail.html', {'transaction': transaction})

# Vista para crear una nueva transacción
@login_required
def transaction_new(request):
    if request.method == "POST":
        form = TransactionForm(request.POST, user=request.user)
        if form.is_valid():
            transaction = form.save(commit=False)
            transaction.save()
            form.save_m2m()  # Guardar la relación muchos a muchos
            messages.success(request, 'Transacción creada exitosamente.')
            return redirect('transactions:transaction_detail', pk=transaction.pk)
        else:
            messages.error(request, 'Por favor corrige los errores a continuación.')
    else:
        form = TransactionForm(user=request.user)
    return render(request, 'transactions/transaction_edit.html', {'form': form})

# Vista para editar una transacción existente
@login_required
def transaction_edit(request, pk):
    transaction = get_object_or_404(Transaction, pk=pk)
    if request.method == "POST":
        form = TransactionForm(request.POST, instance=transaction, user=request.user)
        if form.is_valid():
            form.save()
            return redirect('transactions:transaction_detail', pk=transaction.pk)
    else:
        form = TransactionForm(instance=transaction, user=request.user)
    return render(request, 'transactions/transaction_edit.html', {'form': form})

# Vista para eliminar una transacción
@login_required
def transaction_delete(request, pk):
    transaction = get_object_or_404(Transaction, pk=pk)
    transaction.delete()
    messages.success(request, 'Transacción eliminada exitosamente.')
    return redirect('transactions:transaction_list')

# Vista para gestionar los propósitos de las transacciones (solo para staff)
@staff_member_required
def manage_purposes(request):
    purposes = Purpose.objects.all()
    if request.method == "POST":
        form = PurposeForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('transactions:manage_purposes')
    else:
        form = PurposeForm()
    return render(request, 'transactions/manage_purposes.html', {'form': form, 'purposes': purposes})

# Vista para eliminar un propósito (solo para staff)
@staff_member_required
def delete_purpose(request, pk):
    purpose = get_object_or_404(Purpose, pk=pk)
    purpose.delete()
    return redirect('transactions:manage_purposes')