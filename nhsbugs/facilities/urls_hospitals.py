from django.conf.urls.defaults import url, patterns
from django.views.generic.simple import redirect_to, direct_to_template

from views import list_hospitals, view_hospital

urlpatterns = patterns('',
    url(r'^$', list_hospitals, name='list_hospitals'),
    url(r'^(?P<slug>[\w-]+)$', view_hospital, name='view_hospital'),
)
