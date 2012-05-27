from django.db import models
from django.contrib.auth.models import User
from autoslug import AutoSlugField
from voting.models import Vote

STATUS_CHOICES = (
    ('F',  'Fixed'),
    ('NF', 'Not Fixed'),
)

class Bug(models.Model):

    slug = AutoSlugField(populate_from='title', unique=True)
    title = models.CharField(max_length=120, blank=False, null=False)
    description = models.TextField(blank=False, null=False)
    pic = models.FileField(upload_to='uploads/')

    reporter = models.ForeignKey(User)
    report_date = models.DateTimeField(auto_now=False, auto_now_add=True)
    update_date = models.DateTimeField(auto_now=True, auto_now_add=True)
    hospital = models.ForeignKey( "facilities.Hospital", related_name='bugs' )
    status = models.CharField(max_length=2, choices=STATUS_CHOICES, default='NF')

    def get_score(self):
        votes = Vote.objects.get_for_object(self)
        return sum( [ x.direction for x in votes ] )

