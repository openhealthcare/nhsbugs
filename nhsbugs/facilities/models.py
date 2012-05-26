from django.db import models
from autoslug import AutoSlugField

class SHA(models.Model):
    slug = AutoSlugField(populate_from='name')
    code = models.CharField(max_length=10, null=False, blank=False)
    name = models.CharField(max_length=100, null=False, blank=False)
    it_code  = models.CharField(max_length=32, null=True, blank=True)

    # SHA is always empty
    sha_code = models.CharField(max_length=32, null=True, blank=True)
    address1 = models.CharField(max_length=64, null=False, blank=False)
    address2 = models.CharField(max_length=64, null=False, blank=False)
    address3 = models.CharField(max_length=64, null=True, blank=True)
    address4 = models.CharField(max_length=64, null=True, blank=True)
    address5 = models.CharField(max_length=64, null=True, blank=True)
    postcode = models.CharField(max_length=16, null=True, blank=True)

    open_date = models.DateTimeField(null=True, blank=True)
    close_date = models.DateTimeField(null=True, blank=True)

class Hospital(models.Model):
    slug = AutoSlugField(populate_from='name')
    code = models.CharField(max_length=10, null=False, blank=False)
    name = models.CharField(max_length=100, null=False, blank=False)
    it_code  = models.CharField(max_length=32, null=True, blank=True)
    sha_code = models.CharField(max_length=32, null=True, blank=True)
    address1 = models.CharField(max_length=64, null=False, blank=False)
    address2 = models.CharField(max_length=64, null=False, blank=False)
    address3 = models.CharField(max_length=64, null=True, blank=True)
    address4 = models.CharField(max_length=64, null=True, blank=True)
    address5 = models.CharField(max_length=64, null=True, blank=True)
    postcode = models.CharField(max_length=16, null=True, blank=True)

    open_date = models.DateTimeField(null=True, blank=True)
    close_date = models.DateTimeField(null=True, blank=True)

