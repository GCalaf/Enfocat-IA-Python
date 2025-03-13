from django.shortcuts import render

# Vista principal que renderiza la página de inicio
def index(request):
    return render(request, 'index.html')