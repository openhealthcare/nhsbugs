from django import forms
from django.contrib import auth
from django.conf import settings
from django.http import HttpResponseRedirect, HttpResponse, Http404, HttpResponseForbidden
from django.shortcuts import render_to_response, redirect, get_object_or_404, render
from django.template import RequestContext


def home(request):
    # render(request, template[, dictionary][, context_instance][, content_type][, status][, current_app])
    return render_to_response('home.html',
                               {},
                               context_instance=RequestContext(request))
