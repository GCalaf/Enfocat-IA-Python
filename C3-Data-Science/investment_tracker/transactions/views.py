from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from .models import Transaction
from .forms import TransactionForm

@login_required
def transaction_list(request):
    transactions = Transaction.objects.filter(investment__user=request.user)
    return render(request, 'transactions/transaction_list.html', {'transactions': transactions})

@login_required
def transaction_detail(request, pk):
    transaction = get_object_or_404(Transaction, pk=pk)
    return render(request, 'transactions/transaction_detail.html', {'transaction': transaction})

@login_required
def transaction_new(request):
    if request.method == "POST":
        form = TransactionForm(request.POST, user=request.user)
        if form.is_valid():
            transaction = form.save(commit=False)
            transaction.save()
            return redirect('transactions:transaction_detail', pk=transaction.pk)
    else:
        form = TransactionForm(user=request.user)
    return render(request, 'transactions/transaction_edit.html', {'form': form})

@login_required
def transaction_edit(request, pk):
    transaction = get_object_or_404(Transaction, pk=pk)
    if request.method == "POST":
        form = TransactionForm(request.POST, instance=transaction, user=request.user)
        if form.is_valid():
            transaction = form.save(commit=False)
            transaction.save()
            return redirect('transactions:transaction_detail', pk=transaction.pk)
    else:
        form = TransactionForm(instance=transaction, user=request.user)
    return render(request, 'transactions/transaction_edit.html', {'form': form})

@login_required
def transaction_delete(request, pk):
    transaction = get_object_or_404(Transaction, pk=pk)
    transaction.delete()
    return redirect('transactions:transaction_list')