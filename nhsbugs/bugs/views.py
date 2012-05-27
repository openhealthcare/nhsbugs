from django import forms
from django.contrib import auth
from django.conf import settings
from django.http import HttpResponseRedirect, HttpResponse, Http404, HttpResponseForbidden
from django.shortcuts import render_to_response, redirect, get_object_or_404, render
from django.template import RequestContext
from django.contrib.auth.decorators import login_required
from django.contrib import messages

from voting.models import Vote

from models import Bug
from forms import BugForm

from facilities.models import Hospital

def view_bug(request, slug):
    bug = get_object_or_404( Bug, slug=slug)
    votes = Vote.objects.get_for_object(bug)
    votes_up = sum( [ 1 for x in votes if x.direction == 1])
    votes_down = sum( [ 1 for x in votes if x.direction == -1])
    votes_total = len(votes)
    user_vote = 0
    if request.user.is_authenticated():
        user_vote_list = Vote.objects.get_user_votes(request.user, obj=bug)
        if user_vote_list:
            user_vote = user_vote_list[0].direction
    return render_to_response('bugs/view.html',
                               {
                                  "bug": bug,
                                  "votes_up": votes_up,
                                  "votes_down": votes_down,
                                  "votes_total": votes_total,
                                  "user_vote": user_vote
                               },
                               context_instance=RequestContext(request))

@login_required
def vote_bug(request, slug, score):
    bug = get_object_or_404( Bug, slug=slug)
    Vote.objects.record_vote(request.user, bug, int(score))
    bug.save() # we want activity

    #messages.add_message(request, messages.INFO, 'Thanks for voting up for %s' % bug.title )

    return HttpResponseRedirect("/bugs/view/%s" % bug.slug)

@login_required
def report_bug(request,hospital_slug=None):
    init_data = {}
    try:
        hospital = Hospital.objects.get(slug=hospital_slug)
        init_data["hospital"] = hospital
    except Hospital.DoesNotExist:
        hospital = None

    hospitals = Hospital.objects.order_by('name').all()

    form = BugForm(request.POST or None,
                   request.FILES or None,
                   initial=init_data)
    if request.method == 'POST':
        if form.is_valid():
            b = form.save(commit=False)
            b.hospital = form.cleaned_data['hospital']
            b.reporter = request.user
            b.save()
            messages.add_message(request, messages.INFO, '''Thanks for the reporting a fault!''' )

            return HttpResponseRedirect("/bugs/view/" + b.slug)
        else:
            messages.add_message(request, messages.ERROR, 'There was an error with the form, '\
                                                          'please correct it' )
    return render_to_response('bugs/report.html',
                               {
                                "form": form,
                                "hospitalKnown": not hospital is None,
                                "hospitals": hospitals
                               },
                               context_instance=RequestContext(request))

@login_required
def view_my_bugs(request):
    bugs = Bug.objects.filter(reporter=request.user).all()
    return render_to_response('bugs/my_bugs.html',
                               {
                                  "bugs": bugs
                               },
                               context_instance=RequestContext(request))
