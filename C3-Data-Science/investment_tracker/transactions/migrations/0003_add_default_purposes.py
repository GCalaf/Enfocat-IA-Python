from django.db import migrations

def add_default_purposes(apps, schema_editor):
    Purpose = apps.get_model('transactions', 'Purpose')
    default_purposes = [
        'Ahorro',
        'Inversión',
        'Gastos Personales',
        'Educación',
        'Salud',
        'Entretenimiento'
    ]
    for purpose in default_purposes:
        Purpose.objects.get_or_create(name=purpose)

class Migration(migrations.Migration):

    dependencies = [
        ('transactions', '0002_purpose_remove_transaction_transaction_type_and_more'),
    ]

    operations = [
        migrations.RunPython(add_default_purposes),
    ]