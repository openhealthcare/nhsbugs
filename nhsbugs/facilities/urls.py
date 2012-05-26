from django.conf.urls.defaults import url, patterns
from django.views.generic.simple import redirect_to, direct_to_template

from views import list_hospitals, view_hospital, list_shas, view_sha

urlpatterns = patterns('',
    url(r'^hospital/$', list_hospitals, name='list_hospitals'),
    url(r'^hospital/(?P<slug>[\w-]+)$', view_hospital, name='view_hospital'),
    url(r'^sha/$', list_shas, name='list_shas'),
    url(r'^sha/(?P<slug>[\w-]+)$', view_sha, name='view_sha'),
)