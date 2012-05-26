from models import Hospital, SHA
from django.contrib.auth.models import User
from django.contrib import admin


class HospitalAdmin(admin.ModelAdmin):
    list_display = ('name', 'code', 'postcode')
    search_fields = ('name','code')

class SHAAdmin(admin.ModelAdmin):
    list_display = ('name', 'code', 'postcode')
    search_fields = ('name','code')

admin.site.register(Hospital, HospitalAdmin)
admin.site.register(SHA, SHAAdmin)