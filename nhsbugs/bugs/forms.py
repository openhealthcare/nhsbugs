from django.forms.fields import MultipleChoiceField
from django.forms.widgets import CheckboxSelectMultiple
from django.conf import settings
from django.utils.safestring import mark_safe
from django.core.urlresolvers import reverse
from django import forms
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import User
from facilities.models import Hospital
from bugs.models import Bug

class BugForm(forms.ModelForm):

    title = forms.CharField(label="A short summary",required=True)
    description = forms.CharField(label="What's the problem?", widget=forms.Textarea(), required=True)
    pic = forms.FileField(required=False)

    class Meta:
        model = Bug
        fields = ("title","description","pic")

