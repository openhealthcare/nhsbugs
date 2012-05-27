from django import forms
from django.contrib import auth
from django.conf import settings
from django.http import HttpResponseRedirect, HttpResponse, Http404, HttpResponseForbidden
from django.shortcuts import render_to_response, redirect, get_object_or_404, render
from django.template import RequestContext
from django.contrib.auth import authenticate, login, logout
from voting.models import Vote

from voting.models import Vote
from bugs.models import Bug
from forms import LoginForm
from bugs.forms import BugForm
from facilities.models import Hospital

def home(request):
    recent_bugs = Bug.objects.order_by('-update_date')
    hospitals = Hospital.objects.all()
    form = BugForm(initial={"reporter":request.user})
    return render_to_response('home.html',
                               {
                               'top_bugs': recent_bugs,
                               'form': form
                               },
                               context_instance=RequestContext(request))

def logout_view(request):
    logout(request)
    return HttpResponseRedirect('/')

def login_view(request):

    form = LoginForm(request.POST or None)
    if request.method == "POST":
        if form.is_valid():
            user = authenticate(username=form.cleaned_data['username'],
                                password=form.cleaned_data['password'])
            if user is not None:
                if user.is_active:
                    login(request, user)
                    return HttpResponseRedirect(request.GET.get('next', '/'))
                else:
                    pass
            else:
                pass

    return render_to_response('login.html',
                               {"form":form},
                               context_instance=RequestContext(request))
