from django.conf.urls import patterns, include, url
from django.conf import settings
from django.contrib import admin
from django.conf.urls.defaults import *
from tastypie.api import Api
from django.views.generic.simple import direct_to_template
from facilities.api import HospitalResource
from bugs.api import BugResource

admin.autodiscover()

v1_api = Api(api_name='v1')
v1_api.register(HospitalResource())
v1_api.register(BugResource())


urlpatterns = patterns('',
    url(r'^$', 'nhsbugs.views.home', name='home'),
    url(r'^login/$', 'nhsbugs.views.login_view', name='login'),
    url(r'^logout/$', 'nhsbugs.views.logout_view', name='logout'),
    url(r'^about/$', direct_to_template, {'template': 'about.html'}),
    url(r'^comments/', include('django.contrib.comments.urls')),
    url(r'^bugs/', include('bugs.urls')),

    url(r'^hospital/$',"facilities.views.list_hospitals", name='hospital_list'),
    url(r'^hospital/(?P<slug>[\w-]+)$', "facilities.views.view_hospital", name='hospital_view'),
    url(r'^sha/$',"facilities.views.list_shas", name='sha_list'),
    url(r'^sha/(?P<slug>[\w-]+)$', "facilities.views.view_sha", name='sha_view'),
    url(r'^surgery/$',"facilities.views.list_surgeries", name='surgery_list'),
    url(r'^surgery/(?P<slug>[\w-]+)$', "facilities.views.view_surgery", name='surgery_view'),

    url(r'', include('social_auth.urls')),
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
    url(r'^admin/', include(admin.site.urls)),

    url(r'^api/v1/autocomplete', "facilities.api.autocomplete", name="hospital_autocomplete"),
    url(r'^api/', include(v1_api.urls)),
)


if settings.DEBUG:
    urlpatterns += patterns('',
        url(r'^media/(?P<path>.*)$', 'django.views.static.serve', {
            'document_root': settings.MEDIA_ROOT,
        }),
   )