from django.forms.fields import MultipleChoiceField
from django.forms.widgets import CheckboxSelectMultiple
from django.conf import settings
from django.utils.safestring import mark_safe
from django.core.urlresolvers import reverse
from django import forms
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import User


class LoginForm(forms.Form):

    username = forms.CharField(label="Username/Email",required=True)
    password = forms.CharField(label="Password", widget=forms.PasswordInput(), required=True)


