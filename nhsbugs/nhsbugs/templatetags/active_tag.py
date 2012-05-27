import re
from django.template import Library

register = Library()

@register.simple_tag
def active(request, pattern):
    import re
    if pattern == request.path:
        return 'selected'
    return ''