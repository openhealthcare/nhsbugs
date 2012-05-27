from django import forms
from django.contrib import auth
from django.conf import settings
from django.http import HttpResponseRedirect, HttpResponse, Http404, HttpResponseForbidden
from django.shortcuts import render_to_response, redirect, get_object_or_404, render
from django.template import RequestContext

from models import SHA, Hospital, GPSurgery
from bugs.models import Bug

def chunkIt(seq, num):
  avg = len(seq) / float(num)
  out = []
  last = 0.0
  while last < len(seq):
    out.append(seq[int(last):int(last + avg)])
    last += avg
  return out

def list_estate(request, estate_type):
    return HttpResponse(estate_type)

def list_hospitals(request):
    hospitals_a, hospitals_b = chunkIt(Hospital.objects.order_by('name').all(), 2)
    hospitals = Hospital.objects.order_by('name').all()
    return render_to_response('facilities/hospital/list.html',
                               {
                                 'hospitals_a': hospitals_a,
                                 'hospitals_b': hospitals_b,
                                 'hospitals': hospitals
                               },
                               context_instance=RequestContext(request))

def view_hospital(request, slug):
    hospital = get_object_or_404( Hospital, slug=slug)
    bugs = Bug.objects.filter(hospital=hospital).all()
    return render_to_response('facilities/hospital/view.html',
                               {
                                  "hospital": hospital,
                                  "bugs": bugs
                               },
                               context_instance=RequestContext(request))

def list_shas(request):
    shas = SHA.objects.all()
    return render_to_response('facilities/sha/list.html',
                               {
                                'shas': shas
                               },
                               context_instance=RequestContext(request))

def view_sha(request, slug):
    sha = get_object_or_404( SHA, slug=slug)
    hospitals = Hospital.objects.filter(sha_code=sha.code).all()
    return render_to_response('facilities/sha/view.html',
                               {
                                "sha": sha
                               },
                               context_instance=RequestContext(request))


def list_surgeries(request):
    surgeries = GPSurgery.objects.all()
    return render_to_response('facilities/surgery/list.html',
                               {
                                'surgeries': surgery
                               },
                               context_instance=RequestContext(request))

def view_surgery(request, slug):
    surgery = get_object_or_404( GPSurgery, slug=slug)
    return render_to_response('facilities/surgery/view.html',
                               {
                                "surgery": surgery
                               },
                               context_instance=RequestContext(request))
