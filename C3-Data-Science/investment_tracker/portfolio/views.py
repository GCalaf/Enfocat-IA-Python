from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from .models import Investment
from .forms import InvestmentForm

@login_required
def investment_list(request):
    investments = Investment.objects.filter(user=request.user)
    return render(request, 'portfolio/investment_list.html', {'investments': investments})

@login_required
def investment_detail(request, pk):
    investment = get_object_or_404(Investment, pk=pk)
    return render(request, 'portfolio/investment_detail.html', {'investment': investment})

@login_required
def investment_new(request):
    if request.method == "POST":
        form = InvestmentForm(request.POST)
        if form.is_valid():
            investment = form.save(commit=False)
            investment.user = request.user
            investment.save()
            return redirect('portfolio:investment_detail', pk=investment.pk)
    else:
        form = InvestmentForm()
    return render(request, 'portfolio/investment_edit.html', {'form': form})

@login_required
def investment_edit(request, pk):
    investment = get_object_or_404(Investment, pk=pk)
    if request.method == "POST":
        form = InvestmentForm(request.POST, instance=investment)
        if form.is_valid():
            form.save()
            return redirect('portfolio:investment_detail', pk=investment.pk)
    else:
        form = InvestmentForm(instance=investment)
    return render(request, 'portfolio/investment_edit.html', {'form': form})

@login_required
def investment_delete(request, pk):
    investment = get_object_or_404(Investment, pk=pk)
    investment.delete()
    return redirect('portfolio:investment_list')