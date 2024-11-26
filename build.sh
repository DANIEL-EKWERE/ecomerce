#!/usr/bin/env bash
# Exit on error
set -o errexit

# Install dependencies
pip install -r requirements.txt

pip install gunicorn

# Collect static files
python manage.py collectstatic --no-input

# Apply migrations
python manage.py migrate

# Create superuser
echo "from django.contrib.auth.models import User; \
if not User.objects.filter(username='admin').exists(): \
    User.objects.create_superuser('admin', 'admin@example.com', 'adminpassword')" | python manage.py shell