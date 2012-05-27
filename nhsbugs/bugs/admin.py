from models import Bug
from django.contrib.auth.models import User
from django.contrib import admin

class BugAdmin(admin.ModelAdmin):
    list_display = ('short_title', 'reporter', 'update_date', 'status', 'hospital_name')
    search_fields = ('title','description')

    def short_title(self, obj):
        return obj.title[0:40]

    def hospital_name(self, obj):
        return obj.hospital.name

admin.site.register(Bug, BugAdmin)
