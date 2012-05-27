from django.conf.urls.defaults import *
from tastypie.utils import trailing_slash
from tastypie.resources import ModelResource
from django.core.paginator import Paginator, InvalidPage
from bugs.models import Bug
from django.core import serializers
from django.http import HttpResponse
from django.db.models import Q
from tastypie import fields

class BugResource(ModelResource):

    def override_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/search%s$" % (self._meta.resource_name, trailing_slash()), self.wrap_view('get_search'), name="api_get_search"),
        ]

    def dehydrate(self, bundle):
        if 'pic' in bundle.data:
            if bundle.data.get('pic', ''):
                bundle.data['pic'] = '/media/' + bundle.data['pic']
        return bundle

    def get_search(self, request, **kwargs):
        self.method_check(request, allowed=['get'])
        self.is_authenticated(request)
        self.throttle_check(request)

        # Do the query.
        sqs = Bug.objects.filter(hospital__slug=request.GET.get('q', ''))
        paginator = Paginator(sqs, 20)
        print sqs

        try:
            page = paginator.page(int(request.GET.get('page', 1)))
        except InvalidPage:
            raise Http404("Sorry, no results on that page.")

        objects = []

        for result in page.object_list:
            bundle = self.build_bundle(obj=result, request=request)
            bundle = self.full_dehydrate(bundle)
            objects.append(bundle)

        object_list = {
            'objects': objects,
        }

        self.log_throttled_access(request)
        return self.create_response(request, object_list)

    class Meta:
        queryset = Bug.objects.all()
        list_allowed_methods = ['get']
        detail_allowed_methods = ['get']



