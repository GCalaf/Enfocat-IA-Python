from django.urls import path
from . import views

app_name = 'transactions'

urlpatterns = [
    path('', views.transaction_list, name='transaction_list'),
    path('<int:pk>/', views.transaction_detail, name='transaction_detail'),
    path('new/', views.transaction_new, name='transaction_new'),
    path('<int:pk>/edit/', views.transaction_edit, name='transaction_edit'),
    path('<int:pk>/delete/', views.transaction_delete, name='transaction_delete'),
    path('manage_purposes/', views.manage_purposes, name='manage_purposes'),
    path('delete_purpose/<int:pk>/', views.delete_purpose, name='delete_purpose'),
]