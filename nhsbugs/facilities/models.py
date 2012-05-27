from django.db import models
from autoslug import AutoSlugField

class ResponsibleContact(models.Model):
    name = models.CharField(max_length=64, null=False, blank=False)
    jobtitle = models.CharField(max_length=100, null=True, blank=True)
    email = models.EmailField(max_length=100, null=False, blank=False)

    def __unicode__(self):
        return self.name

class Estate(models.Model):

    slug = AutoSlugField(populate_from='name', unique=True)
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

    lat = models.CharField(max_length=16, null=True, blank=True)
    lng = models.CharField(max_length=16, null=True, blank=True)

    open_date = models.DateTimeField(null=True, blank=True)
    close_date = models.DateTimeField(null=True, blank=True)

    class Meta:
        abstract = True


class SHA(Estate):

    responsible = models.ForeignKey( ResponsibleContact, null=True )

    def __unicode__(self):
        return self.name

class GPSurgery(Estate):

    responsible = models.ForeignKey( ResponsibleContact, null=True )

    def __unicode__(self):
        return self.name

class Hospital(Estate):

    responsible = models.ForeignKey( ResponsibleContact, null=True )

    def __unicode__(self):
        return self.name

