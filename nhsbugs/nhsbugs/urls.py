from django.conf.urls import patterns, include, url
from django.conf import settings
from django.contrib import admin
from django.conf.urls.defaults import *
from tastypie.api import Api

from facilities.api import HospitalResource

admin.autodiscover()

v1_api = Api(api_name='v1')
v1_api.register(HospitalResource())


urlpatterns = patterns('',
    url(r'^$', 'nhsbugs.views.home', name='home'),
    url(r'^login/$', 'nhsbugs.views.login_view', name='login'),
    url(r'^logout/$', 'nhsbugs.views.logout_view', name='login'),

    url(r'^bugs/', include('bugs.urls')),
    url(r'^hospital/', include('facilities.urls_hospitals')),
    url(r'^sha/', include('facilities.urls_sha')),

    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
    url(r'^admin/', include(admin.site.urls)),

    url(r'^api/', include(v1_api.urls)),
)


if settings.DEBUG:
    urlpatterns += patterns('',
        url(r'^media/(?P<path>.*)$', 'django.views.static.serve', {
            'document_root': settings.MEDIA_ROOT,
        }),
   )