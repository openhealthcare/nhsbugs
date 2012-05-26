from django import forms
from django.contrib import auth
from django.conf import settings
from django.http import HttpResponseRedirect, HttpResponse, Http404, HttpResponseForbidden
from django.shortcuts import render_to_response, redirect, get_object_or_404, render
from django.template import RequestContext
from django.contrib.auth.decorators import login_required

from models import Bug
from forms import BugForm

from facilities.models import Hospital

def view_bug(request, slug):
    bug = get_object_or_404( Bug, slug=slug)
    return render_to_response('bugs/view.html',
                               {
                                  "bug": bug
                               },
                               context_instance=RequestContext(request))

@login_required
def report_bug(request,hospital_slug):
    hospital = get_object_or_404(Hospital, slug=hospital_slug)
    form = BugForm(request.POST or None,
                   request.FILES or None,
                   initial={"reporter":request.user,"hospital_id":hospital.id})
    if request.method == 'POST':
        if form.is_valid():
            b = form.save(commit=False)
            b.reporter = request.user
            b.hospital = hospital
            b.save()
            return HttpResponseRedirect("/bugs/view/" + b.slug)
    return render_to_response('bugs/report.html',
                               {
                                "form": form
                               },
                               context_instance=RequestContext(request))


"""

"""