"""fliclassroom URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib              import admin
from django.urls                 import path
from fliclassroom.views.siteView import *
from django.conf                 import settings
from django.conf.urls.static     import static

urlpatterns = [
    path(''                                     , inicio),
    path('inicio/'                              , inicio),
    path('noticias/'                            , noticias),
    path('noticias/<int:anio>/<int:mes>'        , noticias),
    path('acercade/'                            , acercaDe),


    path('estado/'                             , estado),
    path('version/'                            , version),
    path('orden/'                              , orden),
    path('proceso/'                            , proceso),
    path('palabra/'                            , palabra),
    path('palabra/<str:proceso>'               , palabra),
    path('palabra/<str:proceso>/<str:tipo>'    , palabra),
    path('aula/'                               , construccion),
    path('actividad/'                          , construccion),
    # path('galeria/'                            , galeria),
    path('pdf/'                                , pdf),

    path('api/estado/'                         , estados),
    path('api/estado/<int:id>'                 , estados),
    path('api/version/'                        , versiones),
    path('api/version/<int:id>'                , versiones),
    path('api/orden/'                          , ordenes),
    path('api/orden/<int:id>'                  , ordenes),
    path('api/proceso/'                        , procesos),
    path('api/proceso/<int:id>'                , procesos),
    path('api/palabra/'                        , palabras),
    path('api/palabra/<str:proceso>'           , palabras),
    path('api/palabra/<str:proceso>/<str:tipo>', palabras),
    path('api/aula/'                           , aulas),
    path('api/actividad/'                      , actividades),
    path('api/recurso/'                        , recursos),
    path('api/instrumento/'                    , instrumentos),

    path('api/auth/login'                      , login),
    path('api/auth/logout'                     , logout),
    path('api/auth/register'                   , register),
    path('api/auth/recover'                    , recover),
    path('api/auth/refresh'                    , refresh),
    #path('api/auth/user'                       , user),

    #path('rest/'                               , include('rest_framework.urls'))

    path('admin/'                              , admin.site.urls),
]+static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)