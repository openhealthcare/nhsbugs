from django import forms
from django.contrib import auth
from django.conf import settings
from django.http import HttpResponseRedirect, HttpResponse, Http404, HttpResponseForbidden
from django.shortcuts import render_to_response, redirect, get_object_or_404, render
from django.template import RequestContext

from models import Bug
from forms import BugForm

def view_bug(request, slug):
    bug = get_object_or_404( Bug, slug=slug)
    return render_to_response('bugs/view.html',
                               {
                                  "bug": bug
                               },
                               context_instance=RequestContext(request))

def report_bug(request):

    form = BugForm(request.POST or None, request.FILES or None, initial={"reporter":request.user})
    if request.method == 'POST':
        if form.is_valid():
            print 'Valid form'
    return render_to_response('bugs/report.html',
                               {
                                "form": form
                               },
                               context_instance=RequestContext(request))


"""

"""