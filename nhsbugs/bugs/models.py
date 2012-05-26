from django.db import models
from django.contrib.auth.models import User

class Bug(models.Model):
    summary = models.CharField(max_length=120, blank=False, null=False)
    description = models.TextField(blank=False, null=False)
    reporter = models.ForeignKeyField(User)
    report_date = models.DateTimeField(auto_now=False, auto_now_add=True)