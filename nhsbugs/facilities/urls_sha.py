from django.conf.urls.defaults import url, patterns
from django.views.generic.simple import redirect_to, direct_to_template

from views import list_shas, view_sha

urlpatterns = patterns('',
    url(r'^$', list_shas, name='list_shas'),
    url(r'^(?P<slug>[\w-]+)$', view_sha, name='view_sha'),
)