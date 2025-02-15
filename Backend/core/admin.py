from django.contrib import admin
from .models import *

admin.site.register(CustomUser)
admin.site.register(Book)
admin.site.register(Category)
admin.site.register(Author)
admin.site.register(Purchase)
admin.site.register(Busket)
admin.site.register(History)