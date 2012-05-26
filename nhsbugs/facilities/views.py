from django import forms
from django.contrib import auth
from django.conf import settings
from django.http import HttpResponseRedirect, HttpResponse, Http404, HttpResponseForbidden
from django.shortcuts import render_to_response, redirect, get_object_or_404, render
from django.template import RequestContext


def list_hospitals(request):
    return render_to_response('facilities/hospital_list.html',
                               {},
                               context_instance=RequestContext(request))

def view_hospital(request, slug):
    return render_to_response('facilities/hospital_view.html',
                               {},
                               context_instance=RequestContext(request))

def list_shas(request):
    return render_to_response('facilities/sha_list.html',
                               {},
                               context_instance=RequestContext(request))

def view_sha(request, slug):
    return render_to_response('facilities/sha_view.html',
                               {},
                               context_instance=RequestContext(request))
