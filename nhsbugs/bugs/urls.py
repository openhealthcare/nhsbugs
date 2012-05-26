from django.conf.urls.defaults import url, patterns

from django.views.generic.simple import redirect_to, direct_to_template

from views import view_bug, report_bug

urlpatterns = patterns('',
    url(r'^report/', report_bug, name='report_bug'),
    url(r'^view/(?P<slug>[\w-]+)$', view_bug, name='view_bug'),
)