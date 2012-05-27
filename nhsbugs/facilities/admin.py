from models import Hospital, SHA, ResponsibleContact
from django.contrib.auth.models import User
from django.contrib import admin


class HospitalAdmin(admin.ModelAdmin):
    list_display = ('name', 'slug', 'code', 'postcode')
    search_fields = ('name','code')

class SHAAdmin(admin.ModelAdmin):
    list_display = ('name', 'slug', 'code', 'postcode')
    search_fields = ('name','code')

class ResponsibleContactAdmin(admin.ModelAdmin):
    list_display = ('name', 'jobtitle', 'email', 'hospital_name')
    search_fields = ('name','email')

    def hospital_name(self, obj):
        return obj.hospital.name

admin.site.register(Hospital, HospitalAdmin)
admin.site.register(SHA, SHAAdmin)
admin.site.register(ResponsibleContact, ResponsibleContactAdmin)