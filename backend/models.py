from django.db                  import models
from django.db.models           import Q
from django.contrib.auth.models import User
from django.utils.crypto        import get_random_string
from datetime                   import datetime
import uuid
import os
from django.core.files.storage  import default_storage
from django.conf                import settings

capitalizeFirstChar = lambda s: s[:1].upper() + s[1:]

# Create your models here.
class Fail(models.Model):
   ip      =models.CharField    ("IP"      , max_length=15, primary_key=True, unique=True)
   user    =models.CharField    ("User"    , max_length=150)
   date    =models.DateTimeField("Date"    , auto_now=True)
   attempts=models.IntegerField ("Attempts")

   class Meta:
      db_table = "auth_fail"

   @classmethod
   def create(cls, ip, user):
      fail = cls(ip=ip, user=user, attempts=1)
      fail.save()
      return fail

class Token(models.Model):
   id      =models.BigAutoField ("Id"      , primary_key=True)
   username=models.CharField    ("Username", max_length=150)
   roles   =models.CharField    ("Roles"   , max_length=50)
   ip      =models.CharField    ("IP"      , max_length=15)
   token   =models.CharField    ("Token"   , max_length=255)
   date    =models.DateTimeField("Date"    , auto_now=True)
   active  =models.BooleanField ("Active")

   class Meta:
      db_table = "auth_token"

   def logout(self):
      self.active = 0
      self.save()

   @classmethod
   def create(cls, username, roles, ip):
      token = cls(username=username, roles=roles, ip=ip, token='Bearer '+get_random_string(length=240), active=1)
      token.save()
      return token

   def update(self, hrs):
      if hrs: self.token  = 'Bearer '+get_random_string(length=240)
      self.active = 1
      self.save()
      return self

class Recover(models.Model):
   id      =models.BigAutoField ("Id"      , primary_key=True)
   username=models.CharField    ("Username", max_length=150)
   ip      =models.CharField    ("IP"      , max_length=15)
   code    =models.CharField    ("Code"    , max_length=64)
   date    =models.DateTimeField("Date"    , auto_now=True)
   active  =models.BooleanField ("Active")

   class Meta:
      db_table = "auth_recover"

   @classmethod
   def create(cls, username, ip):
      recover  = None
      code     = get_random_string(length=64)
      recovers = Recover.objects.filter(username=username)
      if len(recovers)==0:
         recover = cls(username=username, ip=ip, code=code, active=EEstado.ACTIVO)
      else:
         recover = Recover.objects.get(username=username)
         recover.ip   = ip
         recover.code = code
      recover.save()

      return recover


class ERoles(models.TextChoices):
   CREADOR      = 'Creador'      # 1, _('Creador')
   COLABORADOR  = 'Colaborador'  # 2, _('Colaborador')
   PARTICIPANTE = 'Participante' # 3, _('Participante')
   OTRO         = 'Otro'         # 4, _('Otro')

class EEstado(models.TextChoices):
   ACTIVO    = 1 #, _('Activo')
   INACTIVO  = 0 #, _('Inactivo')
   INICIADA  = 2 #, _('Iniciada')
   PROGRAMADA= 3 #, _('Programada')
   CALIFICADA= 4 #, _('Calificada')
   ENTREGADA = 5 #, _('Entregada')

class Estado(models.Model):
   est_id          =models.AutoField    ("Id"          , primary_key=True, unique=True)
   est_nombre      =models.CharField    ("Nombre"      , max_length=30)
   est_descripcion =models.CharField    ("Descripción" , max_length=100)
   est_tipo        =models.CharField    ("Tipo"        , max_length=20)
   est_estado      =models.IntegerField ("Estado"      )
   est_creacion    =models.DateTimeField("Creación"    , auto_now_add=True)
   est_modificacion=models.DateTimeField("Modificación", auto_now=True)
   est_creador     =models.IntegerField ("Creador"     )
   est_modificador =models.IntegerField ("Modificador" )

   @staticmethod
   def nombre(est):
      return Estado.objects.get(est_id=est).est_nombre

   def estado(self):
      return Estado.nombre(self.est_estado)

   def toJson(self):
      return {"id": self.est_id, "nombre": self.est_nombre, "descripcion": self.est_descripcion, "tipo": self.est_tipo}

   def __str__(self):
      return 'ESTADO :: Id: %d, Nombre: %s, Descripción: %s, Tipo: %s, Estado: %d' % (self.est_id, self.est_nombre, self.est_descripcion, self.est_tipo, self.est_estado)


class Version(models.Model):
   ver_id          =models.AutoField    ("Id"          , primary_key=True)
   ver_nombre      =models.CharField    ("Nombre"      , max_length=30)
   ver_descripcion =models.CharField    ("Descripción" , max_length=255)
   ver_anio        =models.IntegerField ("Año"         )
   ver_estado      =models.IntegerField ("Estado"      )
   ver_creacion    =models.DateTimeField("Creación"    , auto_now_add=True)
   ver_modificacion=models.DateTimeField("Modificación", auto_now=True)
   ver_creador     =models.IntegerField ("Creador"     )
   ver_modificador =models.IntegerField ("Modificador" )

   def estado(self):
      return Estado.nombre(self.ver_estado)

   def toJson(self):
      return {"id": self.ver_id, "nombre": self.ver_nombre, "descripcion": self.ver_descripcion, "anio": self.ver_anio}

   def __str__(self):
      return 'VERSIÓN :: Id: %d, Nombre: %s, Descripción: %s, Año: %d, Estado: %d' % (self.ver_id, self.ver_nombre, self.ver_descripcion, self.ver_anio, self.ver_estado)

class Orden(models.Model):
   ord_id          =models.AutoField    ("Id"          , primary_key=True)
   ord_nombre      =models.CharField    ("Nombre"      , max_length=30)
   ord_descripcion =models.CharField    ("Descripción" , max_length=255)
   ord_fkversion   =models.ForeignKey   (Version       , to_field="ver_id", db_column="ord_fkversion", on_delete=models.PROTECT, verbose_name="Versión")
   ord_estado      =models.IntegerField ("Estado"      )
   ord_creacion    =models.DateTimeField("Creación"    , auto_now_add=True)
   ord_modificacion=models.DateTimeField("Modificación", auto_now=True)
   ord_creador     =models.IntegerField ("Creador"     )
   ord_modificador =models.IntegerField ("Modificador" )

   def estado(self):
      return Estado.nombre(self.ord_estado)

   def toJson(self):
      return {"id": self.ord_id, "nombre": self.ord_nombre, "descripcion": self.ord_descripcion, "version": self.ord_fkversion.ver_nombre}

   def __str__(self):
      return 'ORDEN :: Id: %d, Nombre: %s, Descripción: %s, Versión: %s' % (self.ord_id, self.ord_nombre, self.ord_descripcion, self.ord_fkversion.ver_nombre)

class Proceso(models.Model):
   pro_id          =models.BigAutoField ("Id"          , primary_key=True)
   pro_nombre      =models.CharField    ("Nombre"      , max_length=30)
   pro_descripcion =models.CharField    ("Descripción" , max_length=255)
   pro_description =models.CharField    ("Description" , max_length=255)
   pro_posicion    =models.IntegerField ("Posición"    )
   pro_color       =models.CharField    ("Color"       , max_length=10)
   pro_fkorden     =models.ForeignKey   (Orden         , to_field="ord_id", db_column= "pro_fkorden", on_delete=models.PROTECT, verbose_name="Orden")
   pro_estado      =models.IntegerField ("Estado"      )
   pro_creacion    =models.DateTimeField("Creación"    , auto_now_add=True)
   pro_modificacion=models.DateTimeField("Modificación", auto_now=True)
   pro_creador     =models.IntegerField ("Creador"     )
   pro_modificador =models.IntegerField ("Modificador" )

   def estado(self):
      return Estado.nombre(self.pro_estado)

   '''@staticmethod
   def inverso(color):
      rgb = int(color.replace('#', '0x'), 16)
      color = '#000000'
      if (150 < 0.2126 * ((rgb >> 16) & 0xff) + 0.7152 * ((rgb >>  8) & 0xff) + 0.0722 * ((rgb >>  0) & 0xff)):
         color = '#FFFFFF'
      return color  #color:%s; Proceso.inverso(self.pro_color)
   '''
   def claro(self):
      return 'background:%s33;' % (self.pro_color)

   def style(self):
      return 'background:%s;' % (self.pro_color)

   def toJson(self):
      return {"id": self.pro_id, "nombre": self.pro_nombre, "descripcion": self.pro_descripcion, "description": self.pro_description, "posicion": self.pro_posicion, "color": self.pro_color, "claro": self.claro(), "orden": self.pro_fkorden.ord_nombre}

   def __str__(self):
      return 'PROCESO :: Id: %s, Nombre: %s, Descripción: %s, Description: %s, Posición: %d, Color: %s, Orden: %s' % (self.pro_id, self.pro_nombre, self.pro_descripcion, self.pro_description, self.pro_posicion, self.pro_color, self.pro_fkorden.ord_nombre)

class EPalabra(models.TextChoices):
   VERBO     = 1 #, _('Verbo')
   ACCION    = 2 #, _('Acción')
   RESULTADO = 3 #, _('Resultado')
   PREGUNTA  = 4 #, _('Pregunta')

class Palabra(models.Model):
   pal_id          =models.BigAutoField ("Id"          , primary_key=True)
   pal_nombre      =models.CharField    ("Nombre"      , max_length=255)
   pal_descripcion =models.CharField    ("Descripción" , max_length=255)
   pal_fkproceso   =models.ForeignKey   (Proceso       , to_field="pro_id", db_column="pal_fkproceso", on_delete=models.PROTECT, verbose_name="Proceso")
   pal_tipo        =models.CharField    ("Tipo"        , max_length=1, choices=EPalabra.choices, default=EPalabra.PREGUNTA)
   pal_estado      =models.IntegerField ("Estado"      )
   pal_creacion    =models.DateTimeField("Creación"    , auto_now_add=True)
   pal_modificacion=models.DateTimeField("Modificación", auto_now=True)
   pal_creador     =models.IntegerField ("Creador"     )
   pal_modificador =models.IntegerField ("Modificador" )

   def estado(self):
      return Estado.nombre(self.pal_estado)

   def tipo(self):
      tip = ''
      if   self.pal_tipo == 1: tip = 'Verbo'
      elif self.pal_tipo == 2: tip = 'Acción'
      elif self.pal_tipo == 3: tip = 'Respuesta'
      elif self.pal_tipo == 4: tip = 'Pregunta'
      return tip

   def style(self):
      return self.pal_fkproceso.claro()

   def toJson(self):
      return {"id": self.pal_id, "nombre": self.pal_nombre, "descripcion": self.pal_descripcion, "proceso": self.pal_fkproceso.pro_nombre, "tipo": self.tipo()}

   def __str__(self):
      return 'PALABRA :: Id: %d, Nombre: %s, Descripción: %s, Proceso: %s, Tipo: %s, Estado: %s' % (self.pal_id, self.pal_nombre, self.pal_descripcion, self.pal_fkproceso.pro_nombre, self.tipo(), self.estado())

class Aula(models.Model):
   aul_id          =models.BigAutoField ("Id"          , primary_key=True)
   aul_nombre      =models.CharField    ("Nombre"      , max_length=50)
   aul_descripcion =models.CharField    ("Descripción" , max_length=255)
   aul_clave       =models.CharField    ("Clave"       , max_length=10, unique=True)
   aul_estado      =models.IntegerField ("Estado"      )
   aul_creacion    =models.DateTimeField("Creación"    , auto_now_add=True)
   aul_modificacion=models.DateTimeField("Modificación", auto_now=True)
   aul_creador     =models.IntegerField ("Creador"     )
   aul_modificador =models.IntegerField ("Modificador" )

   @classmethod
   def create(cls, nueva, user):
      aula = cls(aul_nombre=capitalizeFirstChar(nueva['nombre']), aul_descripcion=capitalizeFirstChar(nueva['descripcion']), aul_clave=uuid.uuid4().hex[:8].upper(), aul_estado=int(nueva['estado']), aul_creador=user.id, aul_modificador=user.id)
      aula.save()
      Participante.create(aula, user)
      return aula

   @classmethod
   def salir(cls, sal, user):
      aula = Aula.objects.get(aul_id=sal['id'], aul_clave=sal['clave'])
      Participante.salir(aula, user)
      return aula

   @classmethod
   def subscribe(cls, subs, user):
      aula = Aula.objects.get(aul_id=subs['id'], aul_clave=subs['clave'])
      Participante.create(aula, user, ERoles.PARTICIPANTE)
      return aula

   @classmethod
   def update(cls, edita, user):
      aula = None
      try:
         aula          = Aula.objects.get(aul_id=edita['id'], aul_clave=edita['clave'])
         creador       = aula.creador()
         colaboradores = aula.colaboradores()
         if creador['usuario']=="(*)"+user.username or len(list(filter(lambda x: user.username in x['usuario'], colaboradores)))>0:
            aula.aul_nombre      =capitalizeFirstChar(edita['nombre'])
            aula.aul_descripcion =capitalizeFirstChar(edita['descripcion'])
            aula.aul_estado      =int(edita['estado'])
            aula.aul_modificador =user.id
            aula.save()
      except:
         pass
      return aula

   @staticmethod
   def userJson(index, user, glue=''):
      user = User.objects.get(id=user)
      user = {"index": index, "id": user.id, "usuario": glue+user.username, "nombre": user.first_name + " " + user.last_name}
      return user

   def creador(self):
      user = 0
      parts = Participante.objects.filter(par_fkaula=self.aul_id, par_roles=ERoles.CREADOR)
      if len(parts)>0:
         user = Aula.userJson(1, parts[0].par_fkusuario, '(*)')
      return user

   def colaboradores(self):
      users = []
      parts = Participante.objects.filter(Q(par_fkaula=self.aul_id, par_roles=ERoles.COLABORADOR))
      if len(parts)>0:
         index = 1
         for part in parts:
            users.append(Aula.userJson(index, part.par_fkusuario))
            index = index + 1
      return users

   def participantes(self):
      users = []
      parts = Participante.objects.filter(Q(par_fkaula=self.aul_id, par_roles=ERoles.PARTICIPANTE, par_estado=EEstado.ACTIVO))
      if len(parts)>0:
         index = 1
         for part in parts:
            users.append(Aula.userJson(index, part.par_fkusuario))
            index = index + 1
      return users

   def actividades(self):
      actvs = []
      actis = Actividad.objects.filter(Q(act_fkaula=self.aul_id))
      if len(actis)>0:
         index = 1
         for acti in actis:
            actvs.append({"index": index, "id": acti.act_id, "nombre": acti.act_nombre, "descripcion": acti.act_descripcion, "integrantes": acti.act_integrantes, "equipo": acti.equipo(), "inicio": acti.act_inicio.strftime("%G-%m-%d %X"), "fin": acti.act_fin.strftime("%G-%m-%d %X"), "estado": acti.estado()})
            index = index + 1
      return actvs

   def estado(self):
      return Estado.nombre(self.aul_estado)

   def toJson(self, user):
      username       = user.username
      creador        = self.creador()
      colaboradores  = self.colaboradores()
      participantes  = self.participantes()
      rol            = 'a:Creador' if username in creador['usuario'] else ('b:Colaborador' if len(list(filter(lambda x: username in x['usuario'], colaboradores)))>0 else ('c:Participante' if len(list(filter(lambda x: username in x['usuario'], participantes)))>0 else 'd:Otro'))
      creadores      = [creador] + colaboradores
      return {"id": self.aul_id, "clave": self.aul_clave, "nombre": self.aul_nombre, "descripcion": self.aul_descripcion, "creadores": creadores, "participantes": participantes, "rol" : rol, "actividades": self.actividades(), "estado": self.estado()}

   def __str__(self):
      return 'AULA :: Id: %d, Nombre: %s, Descripción: %s, Clave: %s, Estado: %s' % (self.aul_id, self.aul_nombre, self.aul_descripcion, self.aul_clave, self.estado())

class Recurso(models.Model):
   rec_id          =models.BigAutoField ("Id"          , primary_key=True)
   rec_nombre      =models.CharField    ("Nombre"      , max_length=30)
   rec_descripcion =models.CharField    ("Descripción" , max_length=255)
   rec_ruta        =models.CharField    ("Ruta"        , max_length=255)
   rec_publico     =models.IntegerField ("Público"     )
   rec_estado      =models.IntegerField ("Estado"      )
   rec_creacion    =models.DateTimeField("Creación"    , auto_now_add=True)
   rec_modificacion=models.DateTimeField("Modificación", auto_now=True)
   rec_creador     =models.IntegerField ("Creador"     )
   rec_modificador =models.IntegerField ("Modificador" )

   @classmethod
   def create(cls, nuevo, user):
      #unique_file_name = Recurso.get_unique_file_name(nuevo['file'].name)
      unique_file_name = nuevo['file'].name
      recurso = cls(rec_nombre=capitalizeFirstChar(nuevo['nombre']), rec_descripcion=capitalizeFirstChar(nuevo['descripcion']), rec_ruta=unique_file_name, rec_publico=int(nuevo['publico']), rec_estado=int(nuevo['estado']), rec_creador=user.id, rec_modificador=user.id)
      recurso.save()

      unique_file_name = "R" + str(recurso.rec_id) + "_" + unique_file_name
      recurso.arc_ruta = unique_file_name
      recurso.save()
      full_path        = os.path.join('recurso/', unique_file_name)
      default_storage.save(full_path, nuevo['file'])

      return recurso

   @classmethod
   def get_unique_file_name(cls, filename):
      ext      = filename.split('.')[-1]
      filename = "%s.%s" % (uuid.uuid4(), ext)
      return filename

   """ @classmethod
   def galeria(cls, user):
      modelos = Recurso.objects.all().filter(Q(rec_estado=EEstado.ACTIVO), Q(rec_publico=1) | Q(rec_creador=user) | Q(rec_modificador=user))
      recursos = []
      for modelo in modelos:
         recursos.append({"nombre": modelo.rec_nombre, "descripcion": modelo.rec_descripcion, "ruta": modelo.rec_ruta})
      return recursos """

   def ruta(self):
      return settings.HOST_MEDIA+'recurso/'+"R" + str(self.rec_id) + "_" + self.rec_ruta

   def toJson(self):
      return {"id": self.rec_id, "nombre": self.rec_nombre, "descripcion": self.rec_descripcion, "publico": self.rec_publico, "ruta": self.ruta()}

   def __str__(self):
      return 'RECURSO :: Id: %d, Nombre: %s, Descripción: %s, Público: %d, Ruta: %s' % (self.rec_id, self.rec_nombre, self.rec_descripcion, self.rec_publico, self.ruta())

class Archivo(models.Model):
   arc_id          =models.BigAutoField ("Id"          , primary_key=True)
   arc_nombre      =models.CharField    ("Nombre"      , max_length=30)
   arc_descripcion =models.CharField    ("Descripción" , max_length=255)
   arc_tipo        =models.CharField    ("Tipo"        , max_length=1)
   arc_ruta        =models.CharField    ("Ruta"        , max_length=100)
   arc_estado      =models.IntegerField ("Estado"      )
   arc_creacion    =models.DateTimeField("Creación"    , auto_now_add=True)
   arc_modificacion=models.DateTimeField("Modificación", auto_now=True)
   arc_creador     =models.IntegerField ("Creador"     )
   arc_modificador =models.IntegerField ("Modificador" )

   @classmethod
   def create(cls, nuevo, user, folder):
      unique_file_name = Archivo.get_unique_file_name(nuevo['file'].name)
      #unique_file_name = nuevo['file'].name
      tipo             = "I" if folder=='instrumento' else "E" if folder=='evidencia' else 'A'
      archivo          = cls(arc_nombre=capitalizeFirstChar(nuevo['nombre']), arc_descripcion=capitalizeFirstChar(nuevo['descripcion']), arc_tipo=tipo, arc_ruta=unique_file_name, arc_estado=int(nuevo['estado']), arc_creador=user.id, arc_modificador=user.id)
      archivo.save()

      unique_file_name = tipo + f'{archivo.arc_id:08}' + "_" + unique_file_name
      archivo.arc_ruta = unique_file_name
      archivo.save()
      full_path        = os.path.join(folder+'/', unique_file_name)

      default_storage.save(full_path, nuevo['file'])

      return archivo

   @classmethod
   def get_unique_file_name(cls, filename):
      ext      = filename.split('.')[-1]
      filename = "%s.%s" % (uuid.uuid4(), ext)
      return filename

   def ruta(self):
      return settings.HOST_PDF+get_random_string(length=10)+'&p='+self.arc_ruta+'&f='+get_random_string(length=9)+self.arc_tipo+'&d='+get_random_string(length=10)

   def toJson(self):
      return {"id": self.arc_id, "nombre": self.arc_nombre, "descripcion": self.arc_tipo, "tipo": self.arc_tipo, "ruta": self.ruta()}

   def __str__(self):
      return 'ARCHIVO :: Id: %d, Nombre: %s, Descripción: %s, Tipo: %s, Ruta: %s' % (self.arc_id, self.arc_nombre, self.arc_descripcion, self.arc_tipo, self.ruta())

class Participante(models.Model):
   par_id          =models.BigAutoField ("Id"          , primary_key=True)
   par_fkaula      =models.ForeignKey   (Aula          , to_field="aul_id", db_column="par_fkaula", on_delete=models.PROTECT, verbose_name="Aula")
   par_fkusuario   =models.IntegerField ("Usuario"     )
   par_roles       =models.CharField    ("Roles"       , max_length=20)
   par_estado      =models.IntegerField ("Estado"      )
   par_creacion    =models.DateTimeField("Creación"    , auto_now_add=True)
   par_modificacion=models.DateTimeField("Modificación", auto_now=True)
   par_creador     =models.IntegerField ("Creador"     )
   par_modificador =models.IntegerField ("Modificador" )

   @classmethod
   def create(cls, aula, user, rol=ERoles.CREADOR):
      participante = cls(par_fkaula=aula, par_fkusuario=user.id, par_roles=rol, par_estado=EEstado.ACTIVO, par_creador=user.id, par_modificador=user.id)
      participante.save()
      return participante

   @classmethod
   def salir(cls, aula, user):
      participante = None
      try:
         participante = Participante.objects.get(par_fkaula=aula, par_fkusuario=user.id, par_roles=ERoles.PARTICIPANTE, par_estado=EEstado.ACTIVO)
         if participante is not None:
            participante.par_estado     =EEstado.INACTIVO
            participante.par_modificador=user.id
            participante.save()
      except:
         pass
      return participante

   def estado(self):
      return Estado.nombre(self.par_estado)

   def usuario(self):
      u = User.objects.get(id=self.par_fkusuario)
      return u.username

   def toJson(self):
      return {"id": self.par_id, "aula": self.par_fkaula.aul_nombre, "usuario": self.par_fkusuario, "roles": self.par_roles, "estado": self.estado()}

   def __str__(self):
      return 'PARTICIPANTE :: Id: %d, Aula: %s, Usuario: %d, Roles: %s, Proceso: %s, Estado: %s' % (self.par_id, self.par_fkaula.aul_nombre, self.par_fkusuario, self.par_roles, self.estado())

class Actividad(models.Model):
   act_id           =models.BigAutoField ("Id"          , primary_key=True)
   act_nombre       =models.CharField    ("Nombre"      , max_length=50)
   act_descripcion  =models.CharField    ("Descripción" , max_length=255)
   act_inicio       =models.DateTimeField("Inicio")
   act_fin          =models.DateTimeField("Fin")
   act_integrantes  =models.IntegerField ("Integrantes" )
   act_puntaje      =models.IntegerField ("Puntaje"     )
   act_fkaula       =models.ForeignKey   (Aula          , to_field="aul_id", db_column="act_fkaula"       , on_delete=models.PROTECT, verbose_name="Aula")
   act_fkproceso    =models.ForeignKey   (Proceso       , to_field="pro_id", db_column="act_fkproceso"    , on_delete=models.PROTECT, verbose_name="Proceso")
   act_fkrecurso    =models.ForeignKey   (Recurso       , to_field="rec_id", db_column="act_fkrecurso"    , on_delete=models.PROTECT, verbose_name="Recurso")
   act_fkinstrumento=models.ForeignKey   (Archivo       , to_field="arc_id", db_column="act_fkinstrumento", on_delete=models.PROTECT, verbose_name="Instrumento")
   act_estado       =models.IntegerField ("Estado"      )
   act_creacion     =models.DateTimeField("Creación"    , auto_now_add=True)
   act_modificacion =models.DateTimeField("Modificación", auto_now=True)
   act_creador      =models.IntegerField ("Creador"     )
   act_modificador  =models.IntegerField ("Modificador" )

   @classmethod
   def create(cls, aula, nueva, user):
      actividad = None
      try:
         aula          = Aula.objects.get(aul_id=int(aula))
         creador       = aula.creador()
         colaboradores = aula.colaboradores()
         if creador['usuario']=="(*)"+user.username or len(list(filter(lambda x: user.username in x['usuario'], colaboradores)))>0:
            proceso     = Proceso.objects.get(pro_id=int(nueva['proceso']))
            recurso     = Recurso.objects.get(rec_id=0)
            instrumento = Archivo.objects.get(arc_id=0)
            actividad   = cls(act_nombre=capitalizeFirstChar(nueva['nombre']), act_descripcion=capitalizeFirstChar(nueva['descripcion']), act_inicio=nueva['inicio'], act_fin=nueva['fin'], act_puntaje=nueva['puntaje'], act_integrantes=nueva['integrantes'], act_fkaula=aula, act_fkproceso=proceso, act_fkrecurso=recurso, act_fkinstrumento=instrumento, act_estado=int(nueva['estado']), act_creador=user.id, act_modificador=user.id)
            actividad.save()
      except:
         pass
      return actividad

   @classmethod
   def update(cls, aula, edita, user):
      actividad = None
      try:
         aula          = Aula.objects.get(aul_id=aula)
         creador       = aula.creador()
         colaboradores = aula.colaboradores()
         if creador['usuario']=="(*)"+user.username or len(list(filter(lambda x: user.username in x['usuario'], colaboradores)))>0:
            actividad = Actividad.objects.get(act_id=int(edita['id']))
            if actividad is not None:
               #if len(false)==0:
               actividad.act_fkproceso  =Proceso.objects.get(pro_id=int(edita['proceso']))
               actividad.act_nombre     =capitalizeFirstChar(edita['nombre'])
               actividad.act_descripcion=capitalizeFirstChar(edita['descripcion'])
               actividad.act_inicio     =edita['inicio']
               actividad.act_fin        =edita['fin']
               actividad.act_puntaje    =edita['puntaje']
               actividad.act_integrantes=edita['integrantes']
               actividad.act_estado     =int(edita['estado'])
               actividad.act_modificador=user.id
               actividad.save()
      except:
         pass
      return actividad

   @classmethod
   def recurso(cls, aula, acti, recurso, user):
      actividad = None
      try:
         aula          = Aula.objects.get(aul_id=aula)
         creador       = aula.creador()
         colaboradores = aula.colaboradores()
         if creador['usuario']=="(*)"+user.username or len(list(filter(lambda x: user.username in x['usuario'], colaboradores)))>0:
            actividad = Actividad.objects.get(act_id=int(acti))
            if actividad is not None:
               actividad.act_fkrecurso   =recurso
               actividad.act_modificador =user.id
               actividad.save()
      except Exception as e: print(e)
         #pass
      return actividad

   @classmethod
   def instrumento(cls, aula, acti, instrumento, user):
      actividad = None
      try:
         aula          = Aula.objects.get(aul_id=aula)
         creador       = aula.creador()
         colaboradores = aula.colaboradores()
         if creador['usuario']=="(*)"+user.username or len(list(filter(lambda x: user.username in x['usuario'], colaboradores)))>0:
            actividad = Actividad.objects.get(act_id=int(acti))
            if actividad is not None:
               actividad.act_fkinstrumento=instrumento
               actividad.act_modificador  =user.id
               actividad.save()
      except Exception as e: print(e)
         #pass
      return actividad

   @classmethod
   def evidencia(cls, aula, acti, evid, user):
      evidencia = None
      try:
         aula          = Aula.objects.get(aul_id=aula)
         creador       = aula.creador()
         colaboradores = aula.colaboradores()
         participantes = aula.participantes()
         todos         = [creador] + colaboradores + participantes
         if len(list(filter(lambda x: user.username in x['usuario'], todos)))>0:
            actividad = Actividad.objects.get(act_id=int(acti))
            if actividad is not None:
               if evid['accion'] == 'nuevo':
                  evidencia = Evidencia.create(evid, actividad, user)
               else:
                  evidencia = Evidencia.update(evid, user, creador)

      except Exception as e: print(e)
         #pass
      return evidencia

   @staticmethod
   def userJson(index, user, rol, acti, ident):
      user = User.objects.get(id=user)
      user = {"index": index, "usuario": user.username, "nombre": user.first_name + " " + user.last_name, "rol": rol, "acti": acti, "id": ident}
      return user

   def equipo(self):
      users = []
      index = 1
      itgrs = Integrante.objects.filter(Q(int_fkactividad=self.act_id, int_estado=EEstado.ACTIVO))
      if len(itgrs)>0:
         for itgr in itgrs:
            users.append(Actividad.userJson(index, itgr.int_fkmiembro, itgr.int_roles, self.act_id, itgr.int_id))
            index = index + 1
      return users

   def evidencias(self, user):
      evidencias    = []
      creador       = self.act_fkaula.creador()
      colaboradores = self.act_fkaula.colaboradores()
      creadores     = [creador] + colaboradores
      evis          = Evidencia.objects.filter(Q(evi_fkusuario=user, evi_fkactividad=self.act_id))
      if len(list(filter(lambda x: user == x['id'], creadores)))>0:
         evis       = Evidencia.objects.filter(Q(evi_fkactividad=self.act_id))

      if len(evis)>0:
         index = 1
         for evi in evis:
            evidencias.append({"index": index, "evidencia": evi.toJson()})
            index = index + 1
      return evidencias

   def style(self):
      return self.act_fkproceso.claro()

   def estado(self):
      return Estado.nombre(self.act_estado)

   def toJson(self, user=None):
      evidencias = []
      equipo     = []
      puntaje    = str(self.act_puntaje)
      if user is not None:
         evidencias   = self.evidencias(user.id)
         equipo       = self.equipo()
         calificacion = 0
         for evi in evidencias:
            if evi['evidencia']['estado'] == Estado.nombre(EEstado.CALIFICADA):
               calificacion = calificacion + evi['evidencia']['calificacion']
         if calificacion>self.act_puntaje: calificacion=self.act_puntaje
         puntaje = (str(calificacion) + "/" if self.act_fkaula.creador() == user.username else "") + puntaje
      return {"id": self.act_id, "nombre": self.act_nombre, "descripcion": self.act_descripcion, "inicio": self.act_inicio.strftime("%G-%m-%d %X"), "fin": self.act_fin.strftime("%G-%m-%d %X"), "integrantes": self.act_integrantes, "equipo": equipo, "puntaje": puntaje, "aula": self.act_fkaula.aul_nombre, "proceso": self.act_fkproceso.pro_nombre, "color": self.act_fkproceso.pro_nombre+'Claro', "recurso": self.act_fkrecurso.toJson(), "instrumento": self.act_fkinstrumento.toJson(), "evidencias": evidencias, "estado": self.estado()}

   def __str__(self):
      return 'ACTIVIDAD :: Id: %d, Nombre: %s, Descripción: %s, Inicio: %s, Fin: %s, Integrantes: %d, Puntaje: %d, Aula: %s, Proceso: %s, Color: %s, Recurso: %s, Instrumento: %s, Estado: %s' % (self.act_id, self.act_nombre, self.act_descripcion, self.act_inicio.strftime("%G-%m-%d %X"), self.act_fin.strftime("%G-%m-%d %X"), self.act_integrantes, self.act_puntaje, self.act_fkaula.aul_nombre, self.act_fkproceso.pro_nombre, self.act_fkproceso.claro(), self.act_fkrecurso.rec_nombre, self.act_fkinstrumento.arc_nombre, self.estado())

class Integrante(models.Model):
   int_id          =models.BigAutoField ("Id"          , primary_key=True)
   int_fkactividad =models.ForeignKey   (Actividad     , to_field="act_id", db_column="int_fkactividad", on_delete=models.PROTECT, verbose_name="Actividad")
   int_fkusuario   =models.IntegerField ("Usuario"     )
   int_fkmiembro   =models.IntegerField ("Miembro"     )
   int_roles       =models.CharField    ("Roles"       , max_length=20)
   int_estado      =models.IntegerField ("Estado"      )
   int_creacion    =models.DateTimeField("Creación"    , auto_now_add=True)
   int_modificacion=models.DateTimeField("Modificación", auto_now=True)
   int_creador     =models.IntegerField ("Creador"     )
   int_modificador =models.IntegerField ("Modificador" )

   @classmethod
   def create(cls, acti, usuario, roles, user):
      integrante = None
      try:
         actividad = Actividad.objects.get(act_id=int(acti))
         usuario   = User.objects.get(username=usuario)
         if actividad is not None and usuario is not None:
            integrante = cls(int_fkactividad=actividad, int_fkusuario=user.id, int_fkmiembro=usuario.id, int_roles=roles, int_estado=EEstado.ACTIVO, int_creador=user.id, int_modificador=user.id)
            integrante.save()
      except Exception as e: print(e)
         #pass
      return integrante

   @classmethod
   def delete(cls, acti, usuario, ident, user):
      integrante = None
      try:
         actividad = Actividad.objects.get(act_id=int(acti))
         usuario   = User.objects.get(username=usuario)
         if actividad is not None and usuario is not None:
            integrante = Integrante.objects.get(int_fkactividad=actividad, int_fkusuario=user.id, int_fkmiembro=usuario.id, int_id=ident)
            if integrante is not None:
               integrante.int_estado     =EEstado.INACTIVO
               integrante.int_modificador=user.id
               integrante.save()
      except Exception as e: print(e)
         #pass
      return integrante

   def estado(self):
      return Estado.nombre(self.int_estado)

   def toJson(self):
      return {"id": self.int_id, "actividad": self.int_fkactividad.act_nombre, "usuario": self.int_fkusuario, "roles": self.int_roles, "estado": self.estado()}

   def __str__(self):
      return 'INTEGRANTE :: Id: %d, Actividad: %s, Usuario: %d, Roles: %s, Estado: %s' % (self.int_id, self.int_fkactividad.act_nombre, self.int_fkusuario, self.int_roles, self.estado())

class Evidencia(models.Model):
   evi_id            =models.BigAutoField ("Id"          , primary_key=True)
   evi_nombre        =models.CharField    ("Nombre"      , max_length=50)
   evi_descripcion   =models.CharField    ("Descripción" , max_length=255)
   evi_calificacion  =models.IntegerField ("Calificación")
   evi_fkusuario     =models.IntegerField ("Usuario")
   evi_fkactividad   =models.ForeignKey   (Actividad     , to_field="act_id", db_column="evi_fkactividad"   , on_delete=models.PROTECT, verbose_name="Actividad")
   evi_fkarchivo     =models.ForeignKey   (Archivo       , to_field="arc_id", db_column="evi_fkarchivo"     , on_delete=models.PROTECT, verbose_name="Archivo")
   evi_estado        =models.IntegerField ("Estado"      )
   evi_entregada     =models.DateTimeField("Entregada"   , null=True)
   evi_calificada    =models.DateTimeField("Calificada"  , null=True)
   evi_creacion      =models.DateTimeField("Creación"    , auto_now_add=True)
   evi_modificacion  =models.DateTimeField("Modificación", auto_now=True)
   evi_creador       =models.IntegerField ("Creador"     )
   evi_modificador   =models.IntegerField ("Modificador" )

   @classmethod
   def create(cls, nuevo, actividad, user):
      archivo   = Archivo.create(nuevo, user, 'evidencia')
      evidencia = cls(evi_nombre=nuevo['nombre'], evi_descripcion=nuevo['descripcion'], evi_fkusuario=user.id, evi_fkactividad=actividad, evi_fkarchivo=archivo, evi_estado=int(nuevo['estado']), evi_creador=user.id, evi_modificador=user.id)
      evidencia.save()
      return evidencia

   @classmethod
   def update(cls, evid, user, creador):
      #evidencia = cls(evi_nombre=nuevo['nombre'], evi_descripcion=nuevo['descripcion'], evi_fkusuario=user.id, evi_fkactividad=actividad, evi_fkarchivo=archivo, evi_estado=int(nuevo['estado']), evi_creador=user.id, evi_modificador=user.id)
      archivo = "*"
      if evid['file']!='undefined': #archivo = Archivo.objects.get(evid, user, 'evidencia')
         archivo = Archivo.create(evid, user, 'evidencia')
      if creador['id'] == user.id:
         evidencia  = Evidencia.objects.get(evi_id=evid['id'])
      else:
         evidencia  = Evidencia.objects.get(evi_id=evid['id'], evi_fkusuario=user.id)

      if evidencia is not None:
         evidencia.evi_nombre        = evid['nombre']
         evidencia.evi_descripcion   = evid['descripcion']
         if archivo!="*":
            evidencia.evi_fkarchivo  = archivo
         evidencia.evi_estado        = int(evid['estado'])

         if evidencia.evi_estado==int(EEstado.ENTREGADA.value):
            evidencia.evi_entregada  = datetime.now()
            evidencia.evi_calificada = None
         elif evidencia.evi_estado==int(EEstado.CALIFICADA.value):
            evidencia.evi_calificacion = evid['calificacion']
            evidencia.evi_calificada   = datetime.now()
         else:
            evidencia.evi_entregada   = None
            evidencia.evi_calificada  = None
         evidencia.save()
      return evidencia

   def estado(self):
      return Estado.nombre(self.evi_estado)

   def equipo(self):
      users = []
      index = 1
      itgrs = Integrante.objects.filter(Q(int_fkactividad=self.evi_fkactividad, int_estado=EEstado.ACTIVO))
      if len(itgrs)>0:
         for itgr in itgrs:
            users.append(Actividad.userJson(index, itgr.int_fkmiembro, itgr.int_roles, self.evi_fkactividad.act_id, itgr.int_id))
            index = index + 1
      return users

   def toJson(self):
      usuario = User.objects.get(id=self.evi_fkusuario)
      usuario = {"id": usuario.id, "usuario": usuario.username, "nombre": usuario.first_name + " " + usuario.last_name}
      return {"id": self.evi_id, "usuario" : usuario, "equipo" : self.equipo(),  "nombre": self.evi_nombre, "descripcion": self.evi_descripcion, "calificacion": self.evi_calificacion, "puntaje":  self.evi_fkactividad.act_puntaje, "actividad": self.evi_fkactividad.act_id, "archivo": self.evi_fkarchivo.toJson(), "estado": self.estado(), "entregada": self.evi_entregada.strftime("%G-%m-%d %X") if self.evi_entregada is not None else '', "calificada": self.evi_calificada.strftime("%G-%m-%d %X") if self.evi_calificada is not None else ''}

   def __str__(self):
      return 'EVIDENCIA :: Id: %d, Calificación: %d, Usuario: %d, Actividad: %d, Archivo: %s, Estado: %s' % (self.evi_id, self.evi_calificacion, self.evi_fkusuario, self.evi_fkactividad.act_id, self.evi_fkarchivo.toJson(), self.estado())