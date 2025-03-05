from django.urls import path
from . import views

app_name = 'portfolio'

urlpatterns = [
    path('', views.investment_list, name='investment_list'),
    path('investment/<int:pk>/', views.investment_detail, name='investment_detail'),
    path('investment/new/', views.investment_new, name='investment_new'),
    path('investment/<int:pk>/edit/', views.investment_edit, name='investment_edit'),
    path('investment/<int:pk>/delete/', views.investment_delete, name='investment_delete'),
]
