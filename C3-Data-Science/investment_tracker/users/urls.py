from django.urls import path
from . import views
from .views import CustomLoginView

urlpatterns = [
    path('signup/', views.signup, name='signup'),
    path('profile/', views.profile, name='profile'),
    path('profile/edit/', views.update_profile, name='profile_edit'),
    path('login/', CustomLoginView.as_view(), name='login'),
]