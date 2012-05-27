from tastypie.resources import ModelResource
from tastypie import fields
from tastypie.utils import trailing_slash
from facilities.models import Hospital
from django.core import serializers
from django.http import HttpResponse
from django.db.models import Q
from django.conf.urls.defaults import url


class HospitalResource(ModelResource):

    class Meta:
        queryset = Hospital.objects.all()
        list_allowed_methods = ['get']
        detail_allowed_methods = ['get']


def autocomplete(request):
    response = HttpResponse(mimetype='application/json')
    name = request.GET.get('name','')
    hospitals = []

    if len(name) >= 2:
        hospitals = Hospital.objects.filter(name__icontains=name).all()

    JSONSerializer = serializers.get_serializer("json")
    json_serializer = JSONSerializer()
    json_serializer.serialize(hospitals, stream=response)

    return response