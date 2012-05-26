from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^$', 'nhsbugs.views.home', name='home'),
    # url(r'^nhsbugs/', include('nhsbugs.foo.urls')),

    url(r'^bug/', include('bugs.urls')),
    url(r'^hospital/', include('bugs.urls')),

    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
    url(r'^admin/', include(admin.site.urls)),
)
