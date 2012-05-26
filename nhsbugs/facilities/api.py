from tastypie.resources import ModelResource
from facilities.models import Hospital
from django.core import serializers
from django.http import HttpResponse
from django.db.models import Q

class HospitalResource(ModelResource):
    class Meta:
        queryset = Hospital.objects.all()
