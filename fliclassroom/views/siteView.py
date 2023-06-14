from   django.shortcuts                     import render
from   rest_framework.decorators            import api_view
from   django.views.decorators.csrf         import csrf_exempt
from   django.contrib.auth.models           import User
from   django.contrib.auth                  import authenticate
from   django.http                          import JsonResponse
from   django.core                          import serializers
from   backend                              import models
from   django.db.models                     import Q
import datetime
from   django.views.decorators.clickjacking import xframe_options_exempt
from   django.http                          import HttpResponse
import os
from   django.conf                          import settings
from   django.core.mail                     import EmailMessage
from   django.template.loader               import render_to_string
import base64

def inicio(request):
   fecha=datetime.datetime.now()
   return render(request, 'inicio.html', {"titulo":"Inicio", "fecha":fecha})

def noticias(request,anio=0,mes=0):
   if anio==0: anio=datetime.datetime.now().year
   if mes ==0: mes=datetime.datetime.now().month
   fecha=datetime.datetime.now()
   return render(request, 'noticias.html', {"titulo":"Noticias", "fecha":fecha,"anio":anio,"mes":mes})

def acercaDe(request):
   return render(request, 'acercaDe.html', {"titulo":"Acerca de..."})


def estado(request):
   listado = models.Estado.objects.all

   return render(request, 'estado.html', {"titulo":"Estado", "listado":listado})

def estados(request, id=''):
   listado = models.Estado.objects.all().filter(Q(est_estado=models.EEstado.ACTIVO))
   if id!='':
      listado = listado.filter(Q(est_id=id))

   data = []
   for lis in listado:
      data.append(lis.toJson())

   return JsonResponse(data, safe=False)


def version(request):
   listado = models.Version.objects.all

   return render(request, 'version.html', {"titulo":"Versión", "listado":listado})

def versiones(request, id=''):
   listado = models.Version.objects.all().filter(Q(ver_estado=models.EEstado.ACTIVO))
   if id!='':
      listado = listado.filter(Q(ver_id=id))

   data = []
   for lis in listado:
      data.append(lis.toJson())

   return JsonResponse(data, safe=False)


def orden(request):
   listado = models.Orden.objects.all

   return render(request, 'orden.html', {"titulo":"Orden", "listado":listado})

def ordenes(request, id=''):
   listado = models.Orden.objects.all()
   data = []
   for lis in listado:
      data.append(lis.toJson())

   return JsonResponse(data, safe=False)


def proceso(request):
   listado = models.Proceso.objects.all

   return render(request, 'proceso.html', {"titulo":"Proceso", "listado":listado})

def procesos(request, id=''):
   listado = models.Proceso.objects.all().filter(Q(pro_estado=models.EEstado.ACTIVO)).order_by('-pro_posicion')
   data = []
   for lis in listado:
      data.append(lis.toJson())

   return JsonResponse(data, safe=False)

def palabra(request, proceso='', tipo=''):
   listado = models.Palabra.objects.all()
   if proceso!='':
      if len(proceso) > 1:
         proceso=models.Proceso.objects.filter(Q(pro_nombre=proceso))
         if len(proceso) > 0:
            proceso = proceso[0].pro_id
         else:
            proceso = '0'
      listado = listado.filter(Q(pal_fkproceso=proceso))
   if tipo!='':
      if len(tipo) > 1:
         try:
            tipo=models.EPalabra[tipo.upper()]
         except:
            pass
      listado = listado.filter(pal_tipo=tipo)
   listado = listado.order_by('pal_fkproceso', 'pal_tipo')

   return render(request, 'palabra.html', {"titulo":"Palabra", "listado":listado})

def palabras(request, proceso='', tipo=''):
   listado = models.Palabra.objects.all().filter(Q(pal_estado=models.EEstado.ACTIVO))
   if proceso!='':
      if len(proceso) > 1:
         proceso=models.Proceso.objects.filter(Q(pro_nombre=proceso))
         if len(proceso) > 0:
            proceso = proceso[0].pro_id
         else:
            proceso = '0'
      listado = listado.filter(Q(pal_fkproceso=proceso))
   if tipo!='':
      if len(tipo) > 1:
         try:
            tipo=models.EPalabra[tipo.upper()]
         except:
            pass
      listado = listado.filter(pal_tipo=tipo)
   data = []
   for lis in listado:
      data.append(lis.toJson())

   return JsonResponse(data, safe=False)


def construccion(request):
   fecha=datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
   return render(request, 'construccion.html', {"titulo":"En construcción", "fecha#":fecha})

@api_view(['POST']) #@csrf_exempt #@require_http_methods(["POST"]) #@csrf_exempt #@api_view(['POST']) #@csrf_exempt #@permission_classes([AllowAny, ])
def login(request):
   # user = User.objects.create_user('usuario@correo.com', 'usuario@correo.com', '12341234')
   # user.first_name = 'Usuario'
   # user.last_name = 'Usuario'
   # user.save()

   # u = User.objects.get(username='pina@correo.com')
   # u.set_password('12341234')
   # u.save()

   # print("W"*20, request.META, "W"*20)
   data = []
   if request.method=='POST' and request.data:
      data     = [{'status' : 400}]
      rdata    = request.data
      username = rdata['username'] if "username" in rdata                               else '*'
      password = rdata['password'] if "password" in rdata                               else '*'
      roles    = rdata['roles'   ] if "roles"    in rdata and rdata['roles']=='docente' else 'alumno'

      try:
         #addr = request.META.get('REMOTE_ADDR') #print('E'*10, addr,'E'*10, '')
         #real = request.META.get('HTTP_X_REAL_IP') #print('R'*10, real,'R'*10, '') #HTTP_X_REAL_IP funciona correctamente y también HTTP_X_FORWARDED_FOR
         #forw = request.META.get('HTTP_X_FORWARDED_FOR') #print('F'*10, forw,'F'*10, '')
         #print('W'*10, request.META, 'W'*10, '')

         addr = request.META.get('HTTP_X_REAL_IP')
         ip   = models.Fail.objects.get(ip=addr)    #print('Q'*10, ip, 'Q'*10, '')
         diff = datetime.datetime.now() - ip.date   #hrs  = divmod(diff.total_seconds(), 3600)[0]
         mins = divmod(diff.total_seconds(), 60)[0]
         if mins >= 1.0:
            ip.attempts = 1
         else:
            ip.attempts = ip.attempts + 1
         ip.save()
         data = [{'intentos' : ip.attempts}]
      except:
         ip = models.Fail.create(addr, username)

      if ip.attempts<=3 and username!='*' and password!='*':
         user = authenticate(username=username, password=password)
         if user is not None:
            user.last_login = datetime.datetime.now()
            user.save()
            ip.attempts = 0
            ip.save()
            token = models.Token.objects.filter(Q(username=username, ip=addr, roles=roles)).last()
            if token is not None:
               diff = datetime.datetime.now() - token.date
               hrs  = divmod(diff.total_seconds(), 3600)[0]
               token = token.update(hrs>=3)
            else:
               token = models.Token.create(username, roles, addr)
            data = [{'token' : token.token, 'username' : username, 'fullName': user.first_name + ' ' + user.last_name, 'roles': roles}]

   return JsonResponse(data, safe=False)

@api_view(['POST'])
def logout(request):
   data = [{'status' : 400}]
   if request.method=='POST' and request.data:
      rdata    = request.data
      username = rdata['username'] if "username" in rdata else '*'
      token    = rdata['token'   ] if "token"    in rdata else '*'

      try:
         #addr = request.META.get('REMOTE_ADDR')
         addr = request.META.get('HTTP_X_REAL_IP')
         ip   = models.Fail.objects.get(ip=addr)
         diff = datetime.datetime.now() - ip.date   #hrs = divmod(diff.total_seconds(), 3600)[0]
         mins = divmod(diff.total_seconds(), 60)[0]
         if mins >= 1.0:
            ip.attempts = 1
         else:
            ip.attempts = ip.attempts + 1
         ip.save()
         data = [{'intentos' : ip.attempts}]
      except:
         ip = models.Fail.create(addr, username)

      if ip.attempts<=3 and username!='*' and token!='*':
         token = models.Token.objects.filter(Q(username=username, token=token, ip=addr, active=1)).last()
         if token is not None:
            data = []
            token.logout()

   return JsonResponse(data, safe=False)

@api_view(['POST'])
def register(request):
   data = []
   if request.method=='POST' and request.data:
      data     = [{'status' : 400}]
      rdata    = request.data
      username = rdata['username' ] if "username"  in rdata else '*'
      nombre   = rdata['nombre'   ] if "nombre"    in rdata else '*'
      apellidos= rdata['apellidos'] if "apellidos" in rdata else '*'
      password = rdata['password' ] if "password"  in rdata else '*'
      solicita = rdata['solicita' ] if "solicita"  in rdata else '*'
      confirma = rdata['confirma' ] if "confirma"  in rdata else '*'
      register = rdata['register' ] if "register"  in rdata else '*'

      try:
         #addr = request.META.get('REMOTE_ADDR')
         addr = request.META.get('HTTP_X_REAL_IP')
         ip   = models.Fail.objects.get(ip=addr)
         diff = datetime.datetime.now() - ip.date   #hrs = divmod(diff.total_seconds(), 3600)[0]
         mins = divmod(diff.total_seconds(), 60)[0]
         if mins >= 1.0:
            ip.attempts = 1
         else:
            ip.attempts = ip.attempts + 1
         ip.save()
         data = [{'intentos' : ip.attempts}]
      except:
         ip = models.Fail.create(addr, username)

      if ip.attempts<=3 and username!='*' and nombre!='*' and apellidos!='*' and password!='*' and (solicita!="*" or confirma!="*"):
         try:
            if solicita!="*" and solicita=="Solicita":
               users  = User.objects.filter(username=username)
               if len(users)==0:
                  register = models.Recover.create(username, addr)
                  if register is not None:
                     html_content = render_to_string('register.html', { 'register': register })
                     msg = EmailMessage('Confirmar registro', html_content, 'fliclassroom@outlook.com', [username])
                     msg.content_subtype = "html"
                     msg.send()
                     ip.attempts = 0
                     ip.save()
                     data = [{'status' : 'Confirma'}]
            if confirma!="*" and confirma=="Confirma" and register!="*" and len(register)==64 and password!="*" and len(password)>=8:
               register = models.Recover.objects.get(username=username, code=register)
               if register is not None:
                  data = [{'status' : 'Existe'}]
                  users = User.objects.filter(username=username)
                  if len(users)==0:
                     user = User.objects.create_user(username, username, password)
                     user.first_name = nombre
                     user.last_name  = apellidos
                     user.save()
                     ip.attempts = 0
                     ip.save()
                     data = [{'status' : 'Ok'}]
         except Exception as e: print(e)
   return JsonResponse(data, safe=False)

@api_view(['POST'])
def recover(request):
   data = []
   if request.method=='POST' and request.data:
      data     = [{'status' : 400}]
      rdata    = request.data
      username = rdata['username'] if "username"  in rdata else '*'
      solicita = rdata['solicita'] if "solicita"  in rdata else '*'
      confirma = rdata['confirma'] if "confirma"  in rdata else '*'
      recover  = rdata['recover' ] if "recover"   in rdata else '*'
      password = rdata['password'] if "password"  in rdata else '*'

      try:
         #addr = request.META.get('REMOTE_ADDR')
         addr = request.META.get('HTTP_X_REAL_IP')
         ip   = models.Fail.objects.get(ip=addr)
         diff = datetime.datetime.now() - ip.date   #hrs = divmod(diff.total_seconds(), 3600)[0]
         mins = divmod(diff.total_seconds(), 60)[0]
         if mins >= 1.0:
            ip.attempts = 1
         else:
            ip.attempts = ip.attempts + 1
         ip.save()
         data = [{'intentos' : ip.attempts}]
      except:
         ip = models.Fail.create(addr, username)

      if ip.attempts<=3 and username!='*' and (solicita!="*" or confirma!="*"):
         try:
            if solicita!="*" and solicita=="Solicita":
               user = User.objects.get(username=username)
               if user is not None:
                  recover = models.Recover.create(username, addr)
                  if recover is not None:
                     html_content = render_to_string('recover.html', { 'recover': recover })
                     msg = EmailMessage('Recuperar contraseña', html_content, 'fliclassroom@outlook.com', [user.email])
                     msg.content_subtype = "html"
                     msg.send()
                     ip.attempts = 0
                     ip.save()
                     data = [{'status' : 'Confirma'}]
            if confirma!="*" and confirma=="Confirma" and recover!="*" and len(recover)==64 and password!="*" and len(password)>=8:
               recover = models.Recover.objects.get(username=username, code=recover)
               if recover is not None:
                  user = User.objects.get(username=username)
                  user.set_password(password)
                  user.save()
                  recover.delete()
                  ip.attempts = 0
                  ip.save()
                  data = [{'status' : 'Ok'}]
         except Exception as e: print(e)
   return JsonResponse(data, safe=False)


@api_view(['POST'])
def refresh(request):
   data = [{'status' : 400}]
   if request.method=='POST' and request.data:
      rdata    = request.data
      username = rdata['username'] if "username" in rdata else '*'
      token    = rdata['token'   ] if "token"    in rdata else '*'

      try:
         #addr = request.META.get('REMOTE_ADDR')
         addr = request.META.get('HTTP_X_REAL_IP')
         ip   = models.Fail.objects.get(ip=addr)
         diff = datetime.datetime.now() - ip.date   #hrs = divmod(diff.total_seconds(), 3600)[0]
         mins = divmod(diff.total_seconds(), 60)[0]
         if mins >= 1.0:
            ip.attempts = 1
         else:
            ip.attempts = ip.attempts + 1
         ip.save()
         data = [{'intentos' : ip.attempts}]
      except:
         ip = models.Fail.create(addr, username)

      if ip.attempts<=3 and username!='*' and token!='*':
         token = models.Token.objects.filter(Q(username=username, token=token, ip=addr, active=1)).last()
         if token is not None:
            user = User.objects.get(username=username)
            data = [{'token' : token.token, 'username' : username, 'fullName': user.first_name + ' ' + user.last_name, 'roles': token.roles}]

   return JsonResponse(data, safe=False)

""" @api_view(['POST'])
def user(request):
   data: [{'status': 400}]
   if request.data:
      data    = request.data
      headers = request.headers
      print("2"*20, data, "3"*20, headers, "4"*20)

   return JsonResponse(data, safe=False) """


@api_view(['POST'])
def aulas(request):
   data = [{'status' : 400}]
   if request.method=='POST' and request.data:
      rdata     = request.data
      username  = rdata['username' ] if "username"  in rdata else '*'
      token     = rdata['token'    ] if "token"     in rdata else '*'
      aula      = rdata['aula'     ] if "aula"      in rdata else '*'
      nueva     = rdata['nueva'    ] if "nueva"     in rdata else '*'
      edita     = rdata['edita'    ] if "edita"     in rdata else '*'
      salir     = rdata['salir'    ] if "salir"     in rdata else '*'
      subscribe = rdata['subscribe'] if "subscribe" in rdata else '*'

      if username!='*' and token!='*':
         #addr  = request.META.get('REMOTE_ADDR')
         addr  = request.META.get('HTTP_X_REAL_IP')
         token = models.Token.objects.filter(Q(username=username, token=token, ip=addr, active=1)).last()
         if token is not None:
            data  = []
            user  = User.objects.get(username=username)

            #Cuando es nueva aula
            if nueva!='*' and "nombre" in nueva and "descripcion" in nueva and "proceso" in nueva and "estado" in nueva:
               nueva = models.Aula.create(nueva, user)

            #Cuando edita un aula
            if edita!='*' and "nombre" in edita and "descripcion" in edita and "estado" in edita:
               edita = models.Aula.update(edita, user)

            #Cuando salir un aula
            if salir!='*' and "id" in salir and "clave" in salir:
               salir = models.Aula.salir(salir, user)

            #Cuando subscribe un aula
            if subscribe!='*' and "id" in subscribe and "clave" in subscribe:
               subscribe = models.Aula.subscribe(subscribe, user)

            """ parts = models.Participante.objects.all().filter(Q(par_fkusuario=user.id, par_estado=models.EEstado.ACTIVO), Q(par_roles='Creador') | Q(par_roles='Colaborador') | Q(par_roles='Participante'))
            aulas = []
            for part in parts:
               aulas.append(part.par_fkaula.aul_id)
            if len(aulas)>0:
               """
            if aula!="*":
               listado = models.Aula.objects.all().filter(Q(aul_id=aula))
            else:
               listado = models.Aula.objects.all().filter(Q(aul_estado=models.EEstado.ACTIVO)) #.filter(Q(aul_id__in=aulas))
            for lis in listado:
               data.append(lis.toJson(user))

   return JsonResponse(data, safe=False)

@api_view(['POST'])
def actividades(request):
   data = [{'status' : 400}]
   if request.method=='POST' and request.data:
      rdata       = request.data
      username    = rdata['username'    ] if "username"    in rdata  else '*'
      token       = rdata['token'       ] if "token"       in rdata  else '*'
      aula        = rdata['aula'        ] if "aula"        in rdata  else '*'
      nueva       = rdata['nueva'       ] if "nueva"       in rdata  else '*'
      edita       = rdata['edita'       ] if "edita"       in rdata  else '*'
      actividad   = rdata['actividad'   ] if "actividad"   in rdata  else '*'
      miembro     = rdata['miembro'     ] if "miembro"     in rdata  else '*'
      miembroEdit = rdata['miembroEdit' ] if "miembroEdit" in rdata  else '*'
      recurso     = rdata['recurso'     ] if "recurso"     in rdata  else '*'
      instrumento = rdata['instrumento' ] if "instrumento" in rdata  else '*'
      galeria     = rdata['galeria'     ] if "galeria"     in rdata  else '*'
      galeriaInst = rdata['galeriaInst' ] if "galeriaInst" in rdata  else '*'
      evidencia   = rdata['evidencia'   ] if "evidencia"   in rdata  else '*'

      if username!='*' and token!='*' and aula!='*':
         #addr  = request.META.get('REMOTE_ADDR')
         addr  = request.META.get('HTTP_X_REAL_IP')
         token = models.Token.objects.filter(Q(username=username, token=token, ip=addr, active=1)).last()
         if token is not None:
            data  = []
            user  = User.objects.get(username=username)
#ok
            #Cuando es nueva actividad
            if nueva!='*' and "nombre" in nueva and "descripcion" in nueva and "inicio" in nueva and "fin" in nueva and "integrantes" in nueva and "puntaje" in nueva and "estado" in nueva:
               nueva = models.Actividad.create(aula, nueva, user)

            #Cuando edita una actividad
            if edita!='*' and "nombre" in edita and "descripcion" in edita and "inicio" in edita and "fin" in edita and "integrantes" in edita and "puntaje" in edita and "estado" in edita:
               edita = models.Actividad.update(aula, edita, user)

            #Cuando es un nuevo miembro
            if miembro!='*' and actividad!='*' and "usuario" in rdata and "rol" in rdata:
               miembro = models.Integrante.create(actividad, rdata['usuario'], rdata['rol'], user)

            #Cuando edita un miembro
            if miembroEdit!='*' and actividad!='*' and "usuario" in rdata and "id" in rdata:
               miembroEdit = models.Integrante.delete(actividad, rdata['usuario'], rdata['id'], user)

            #Cuando edita un recurso
            if recurso!='*' and actividad!='*' and "nombre" in rdata and "descripcion" in rdata and "publico" in rdata and "file" in rdata and "estado" in rdata:
               recurso = {"nombre": rdata['nombre'], "descripcion": rdata['descripcion'], "publico": rdata['publico'], "file": rdata['file'], "estado": rdata['estado']}
               recurso = models.Recurso.create(recurso, user)
               recurso = models.Actividad.recurso(aula, actividad, recurso, user)

            #Cuando edita un instrumento
            if instrumento!='*' and actividad!='*' and "nombre" in rdata and "descripcion" in rdata and "file" in rdata and "estado" in rdata:
               instrumento = {"nombre": rdata['nombre'], "descripcion": rdata['descripcion'], "file": rdata['file'], "estado": rdata['estado']}
               instrumento = models.Archivo.create(instrumento, user, 'instrumento')
               instrumento = models.Actividad.instrumento(aula, actividad, instrumento, user)

            #Cuando es la galeria de recursos
            if galeria!='*' and actividad!='*' and "galeriaId" in rdata:
               try:
                  recurso = models.Recurso.objects.get(rec_id=int(rdata['galeriaId']))
                  if recurso is not None:
                     actividad = models.Actividad.objects.get(act_id=actividad)
                     if actividad is not None:
                        actividad.act_fkrecurso   = recurso
                        actividad.act_modificador = user.id
                        actividad.save()
               except:
                  pass

            #Cuando es la galeria de instrumentos
            if galeriaInst!='*' and actividad!='*' and "galeriaId" in rdata:
               try:
                  instrumento = models.Archivo.objects.get(arc_id=int(rdata['galeriaId']))
                  if instrumento is not None:
                     actividad = models.Actividad.objects.get(act_id=actividad)
                     if actividad is not None:
                        actividad.act_fkinstrumento= instrumento
                        actividad.act_modificador  = user.id
                        actividad.save()
               except:
                  pass

            #Cuando es nueva evidencia
            if evidencia!='*' and actividad!='*' and "accion" in rdata  and "nombre" in rdata and "descripcion" in rdata and "file" in rdata and "estado" in rdata and "usuario" in rdata and "calificacion" in rdata:
               evidencia = {"accion": rdata['accion'], "id": rdata['id'], "nombre": rdata['nombre'], "descripcion": rdata['descripcion'], "file": rdata['file'], "estado": rdata['estado'], "usuario": rdata['usuario'], "calificacion": rdata['calificacion']}
               evidencia = models.Actividad.evidencia(aula, actividad, evidencia, user)

            parts = models.Participante.objects.all().filter(Q(par_fkusuario=user.id, par_estado=models.EEstado.ACTIVO), Q(par_roles='Creador') | Q(par_roles='Colaborador') | Q(par_roles='Participante'))
            aulas = []
            for part in parts:
               aulas.append(part.par_fkaula.aul_id)
            aula = int(rdata['aula'])
            if len(aulas)>0 and aula in aulas:
               listado = models.Actividad.objects.all().filter(Q(act_fkaula=aula))
               for lis in listado:
                  data.append(lis.toJson(user))

   return JsonResponse(data, safe=False)

@api_view(['POST'])
def recursos(request):
   data = [{'status' : 400}]
   if request.method=='POST' and request.data:
      rdata    = request.data
      username = rdata['username'] if "username" in rdata else '*'
      token    = rdata['token'   ] if "token"    in rdata else '*'
      nuevo    = rdata['nuevo'   ] if "nuevo"    in rdata else '*'
      edita    = rdata['edita'   ] if "edita"    in rdata else '*'
      galeria  = rdata['galeria' ] if "galeria"  in rdata else '*'

      if username!='*' and token!='*':
         #addr  = request.META.get('REMOTE_ADDR')
         addr  = request.META.get('HTTP_X_REAL_IP')
         token = models.Token.objects.filter(Q(username=username, token=token, ip=addr, active=1)).last()
         if token is not None:
            data  = []
            user  = User.objects.get(username=username)

            #Cuando es nuevo recurso
            if nuevo!='*' and "nombre" in nuevo and "descripcion" in nuevo and "ruta" in nuevo and "publico" in nuevo and "estado" in nuevo:
               recurso = models.Recurso.create(nuevo, user)

            """ #Cuando edita un recurso ?????
            if edita!='*' and "nombre" in edita and "descripcion" in edita and "ruta" in edita and "publico" in edita and "estado" in edita:
               recurso = models.Recurso.update(edita, user) """

            #Cuando es la galería
            if galeria!='*':
               recursos = models.Recurso.objects.all().filter(Q(rec_estado=models.EEstado.ACTIVO), Q(rec_publico=1) | Q(rec_creador=user.id) | Q(rec_modificador=user.id))
               data = []
               for recurso in recursos:
                  data.append(recurso.toJson())
               return JsonResponse(data, safe=False)
               # recursos = models.Recurso.galeria(user)
               # return render(request,'recurso.html',{"recursos":recursos, 'media_url':settings.MEDIA_URL})

            parts = models.Participante.objects.all().filter(Q(par_fkusuario=user.id, par_estado=models.EEstado.ACTIVO), Q(par_roles='Creador') | Q(par_roles='Colaborador') | Q(par_roles='Participante'))
            aulas = []
            for part in parts:
               aulas.append(part.par_fkaula.aul_id)
            aula = int(rdata['aula'])
            if len(aulas)>0 and aula in aulas:
               listado = models.Actividad.objects.all().filter(Q(act_fkaula=aula))
               for lis in listado:
                  data.append(lis.toJson())

   return JsonResponse(data, safe=False)

@api_view(['POST'])
def instrumentos(request):
   data = [{'status' : 400}]
   if request.method=='POST' and request.data:
      rdata    = request.data
      username = rdata['username'] if "username" in rdata else '*'
      token    = rdata['token'   ] if "token"    in rdata else '*'
      nuevo    = rdata['nuevo'   ] if "nuevo"    in rdata else '*'
      edita    = rdata['edita'   ] if "edita"    in rdata else '*'
      galeria  = rdata['galeria' ] if "galeria"  in rdata else '*'

      if username!='*' and token!='*':
         #addr  = request.META.get('REMOTE_ADDR')
         addr  = request.META.get('HTTP_X_REAL_IP')
         token = models.Token.objects.filter(Q(username=username, token=token, ip=addr, active=1)).last()
         if token is not None:
            data  = []
            user  = User.objects.get(username=username)

            #Cuando es nuevo instrumento
            if nuevo!='*' and "nombre" in nuevo and "descripcion" in nuevo and "ruta" in nuevo and "estado" in nuevo:
               instrumento = models.Archivo.create(nuevo, user, 'instrumento')

            """ #Cuando edita un instrumento  ?????
            if edita!='*' and "nombre" in edita and "descripcion" in edita and "ruta" in edita and "estado" in edita:
               instrumento = models.Archivo.update(edita, user) """

            #Cuando es la galería
            if galeria!='*':
               instrumentos = models.Archivo.objects.all().filter(Q(arc_estado=models.EEstado.ACTIVO), Q(arc_creador=user.id) | Q(arc_modificador=user.id))
               data = []
               for instrumento in instrumentos:
                  data.append(instrumento.toJson())
               return JsonResponse(data, safe=False)

            parts = models.Participante.objects.all().filter(Q(par_fkusuario=user.id, par_estado=models.EEstado.ACTIVO), Q(par_roles='Creador') | Q(par_roles='Colaborador') | Q(par_roles='Participante'))
            aulas = []
            for part in parts:
               aulas.append(part.par_fkaula.aul_id)
            aula = int(rdata['aula'])
            if len(aulas)>0 and aula in aulas:
               listado = models.Actividad.objects.all().filter(Q(act_fkaula=aula))
               for lis in listado:
                  data.append(lis.toJson())

   return JsonResponse(data, safe=False)

""" def galeria(request):
   user = 3
   listado = models.Recurso.galeria(user)
   return render(request,'recurso.html',{"titulo":"Recursos", "listado":listado, 'media_url':settings.MEDIA_URL}) """

@xframe_options_exempt
def pdf(request):
   if request.method=='GET' and request:
      name     = request.GET.get('p', "")
      tipo     = request.GET.get('f', "A")[-1]
      folder   = 'instrumento' if tipo =='I' else 'evidencia' if tipo =='E' else 'archivo'
      filename = settings.MEDIA_ROOT+'/'+folder+'/'+name
      if os.path.isfile(filename):
         with open(filename, 'rb') as pdf:
            response = HttpResponse(pdf.read(), content_type='application/pdf')
            response['Content-Disposition'] = 'inline;filename='+name
            return response
         pdf.closed
      else:
         return HttpResponse("Error", content_type='application/pdf')
   else:
      return HttpResponse("Error", content_type='application/pdf')