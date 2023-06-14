from django.contrib import admin
from backend.models import Estado, Version, Orden, Proceso

# Register your models here.
class EstadoAdmin(admin.ModelAdmin):
   list_display  =("est_nombre","est_descripcion","est_tipo","est_estado")
   search_fields =("est_nombre","est_descripcion","est_tipo","est_estado")
   list_filter   =("est_nombre","est_descripcion","est_tipo","est_estado")
   ordering      =("est_nombre","est_descripcion","est_tipo","est_estado")

class VersionAdmin(admin.ModelAdmin):
   list_display  =("ver_nombre","ver_descripcion","ver_anio","ver_estado")
   search_fields =("ver_nombre","ver_descripcion","ver_anio","ver_estado")
   list_filter   =("ver_nombre","ver_descripcion","ver_anio","ver_estado")
   ordering      =("ver_nombre","ver_descripcion","ver_anio","ver_estado")

class OrdenAdmin(admin.ModelAdmin):
   list_display  =("ord_nombre","ord_descripcion","ord_fkversion","ord_estado")
   search_fields =("ord_nombre","ord_descripcion","ord_fkversion","ord_estado")
   list_filter   =("ord_nombre","ord_descripcion","ord_fkversion","ord_estado")
   ordering      =("ord_nombre","ord_descripcion","ord_fkversion","ord_estado")

class ProcesoAdmin(admin.ModelAdmin):
   list_display  =("pro_nombre","pro_descripcion","pro_posicion","pro_color","pro_fkorden","pro_estado")
   search_fields =("pro_nombre","pro_descripcion","pro_posicion","pro_color","pro_fkorden","pro_estado")
   list_filter   =("pro_nombre","pro_descripcion","pro_posicion","pro_color","pro_fkorden","pro_estado")
   ordering      =("pro_nombre","pro_descripcion","pro_posicion","pro_color","pro_fkorden","pro_estado")

admin.site.register(Estado,EstadoAdmin)
admin.site.register(Version, VersionAdmin)
admin.site.register(Orden,OrdenAdmin)
admin.site.register(Proceso,ProcesoAdmin)