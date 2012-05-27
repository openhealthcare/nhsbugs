from django.conf.urls.defaults import url, patterns

from django.views.generic.simple import redirect_to, direct_to_template

from views import view_bug, report_bug, vote_bug, view_my_bugs

urlpatterns = patterns('',
    url(r'^report/$', report_bug, name='report_bug'),
    url(r'^report/(?P<hospital_slug>[\w-]+)$', report_bug, name='report_bug_hospital'),
    url(r'^view/(?P<slug>[\w-]+)$', view_bug, name='view_bug'),
    url(r'^vote/(?P<slug>[\w-]+)/(?P<score>.*)/$', vote_bug, name='vote_bug'),
    url(r'^my-bugs/$', view_my_bugs, name='my_bugs'),
)


