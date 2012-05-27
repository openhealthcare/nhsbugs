from django import forms
from django.contrib import auth
from django.conf import settings
from django.http import HttpResponseRedirect, HttpResponse, Http404, HttpResponseForbidden
from django.shortcuts import render_to_response, redirect, get_object_or_404, render
from django.template import RequestContext

from models import SHA, Hospital
from bugs.models import Bug

def chunkIt(seq, num):
  avg = len(seq) / float(num)
  out = []
  last = 0.0
  while last < len(seq):
    out.append(seq[int(last):int(last + avg)])
    last += avg
  return out

def list_hospitals(request):
    hospitals_a, hospitals_b = chunkIt(Hospital.objects.order_by('name').all(), 2)
    return render_to_response('facilities/hospital_list.html',
                               {
                                 'hospitals_a': hospitals_a,
                                 'hospitals_b': hospitals_b,
                               },
                               context_instance=RequestContext(request))

def view_hospital(request, slug):
    hospital = get_object_or_404( Hospital, slug=slug)
    bugs = Bug.objects.filter(hospital=hospital).all()
    return render_to_response('facilities/hospital_view.html',
                               {
                                  "hospital": hospital,
                                  "bugs": bugs
                               },
                               context_instance=RequestContext(request))

def list_shas(request):
    shas = SHA.objects.all()
    return render_to_response('facilities/sha_list.html',
                               {
                                'shas': shas
                               },
                               context_instance=RequestContext(request))

def view_sha(request, slug):
    sha = get_object_or_404( SHA, slug=slug)
    hospitals = Hospital.objects.filter(sha_code=sha.code).all()
    return render_to_response('facilities/sha_view.html',
                               {
                                "sha": sha
                               },
                               context_instance=RequestContext(request))
