/*
Navicat SQLite Data Transfer

Source Server         : FLICLASS SERVER
Source Server Version : 30714
Source Host           : :0

Target Server Type    : SQLite
Target Server Version : 30714
File Encoding         : 65001

Date: 2023-01-03 01:48:21
*/

PRAGMA foreign_keys = OFF;

-- ----------------------------
-- Table structure for auth_fail
-- ----------------------------
DROP TABLE IF EXISTS "main"."auth_fail";
CREATE TABLE "auth_fail" (
"ip"  varchar(15) NOT NULL,
"user"  varchar(150) NOT NULL,
"date"  timestamp NOT NULL,
"attempts"  integer NOT NULL,
PRIMARY KEY ("ip" ASC)
);

-- ----------------------------
-- Records of auth_fail
-- ----------------------------
INSERT INTO "main"."auth_fail" VALUES ('10.81.234.2', 'soloactivoscofreclan@gmail.com', '2023-01-03 01:28:46.359961', 0);
INSERT INTO "main"."auth_fail" VALUES ('10.81.234.3', 'jonathandelacruzalvarez@gmail.com', '2022-12-29 20:24:05.575946', 1);

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS "main"."auth_group";
CREATE TABLE "auth_group" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(150) NOT NULL UNIQUE);

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS "main"."auth_group_permissions";
CREATE TABLE "auth_group_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS "main"."auth_permission";
CREATE TABLE "auth_permission" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "codename" varchar(100) NOT NULL, "name" varchar(255) NOT NULL);

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO "main"."auth_permission" VALUES (1, 1, 'add_logentry', 'Can add log entry');
INSERT INTO "main"."auth_permission" VALUES (2, 1, 'change_logentry', 'Can change log entry');
INSERT INTO "main"."auth_permission" VALUES (3, 1, 'delete_logentry', 'Can delete log entry');
INSERT INTO "main"."auth_permission" VALUES (4, 1, 'view_logentry', 'Can view log entry');
INSERT INTO "main"."auth_permission" VALUES (5, 2, 'add_permission', 'Can add permission');
INSERT INTO "main"."auth_permission" VALUES (6, 2, 'change_permission', 'Can change permission');
INSERT INTO "main"."auth_permission" VALUES (7, 2, 'delete_permission', 'Can delete permission');
INSERT INTO "main"."auth_permission" VALUES (8, 2, 'view_permission', 'Can view permission');
INSERT INTO "main"."auth_permission" VALUES (9, 3, 'add_group', 'Can add group');
INSERT INTO "main"."auth_permission" VALUES (10, 3, 'change_group', 'Can change group');
INSERT INTO "main"."auth_permission" VALUES (11, 3, 'delete_group', 'Can delete group');
INSERT INTO "main"."auth_permission" VALUES (12, 3, 'view_group', 'Can view group');
INSERT INTO "main"."auth_permission" VALUES (13, 4, 'add_user', 'Can add user');
INSERT INTO "main"."auth_permission" VALUES (14, 4, 'change_user', 'Can change user');
INSERT INTO "main"."auth_permission" VALUES (15, 4, 'delete_user', 'Can delete user');
INSERT INTO "main"."auth_permission" VALUES (16, 4, 'view_user', 'Can view user');
INSERT INTO "main"."auth_permission" VALUES (17, 5, 'add_contenttype', 'Can add content type');
INSERT INTO "main"."auth_permission" VALUES (18, 5, 'change_contenttype', 'Can change content type');
INSERT INTO "main"."auth_permission" VALUES (19, 5, 'delete_contenttype', 'Can delete content type');
INSERT INTO "main"."auth_permission" VALUES (20, 5, 'view_contenttype', 'Can view content type');
INSERT INTO "main"."auth_permission" VALUES (21, 6, 'add_session', 'Can add session');
INSERT INTO "main"."auth_permission" VALUES (22, 6, 'change_session', 'Can change session');
INSERT INTO "main"."auth_permission" VALUES (23, 6, 'delete_session', 'Can delete session');
INSERT INTO "main"."auth_permission" VALUES (24, 6, 'view_session', 'Can view session');
INSERT INTO "main"."auth_permission" VALUES (25, 7, 'add_otra', 'Can add otra');
INSERT INTO "main"."auth_permission" VALUES (26, 7, 'change_otra', 'Can change otra');
INSERT INTO "main"."auth_permission" VALUES (27, 7, 'delete_otra', 'Can delete otra');
INSERT INTO "main"."auth_permission" VALUES (28, 7, 'view_otra', 'Can view otra');
INSERT INTO "main"."auth_permission" VALUES (29, 8, 'add_producto', 'Can add producto');
INSERT INTO "main"."auth_permission" VALUES (30, 8, 'change_producto', 'Can change producto');
INSERT INTO "main"."auth_permission" VALUES (31, 8, 'delete_producto', 'Can delete producto');
INSERT INTO "main"."auth_permission" VALUES (32, 8, 'view_producto', 'Can view producto');
INSERT INTO "main"."auth_permission" VALUES (33, 7, 'add_cliente', 'Can add cliente');
INSERT INTO "main"."auth_permission" VALUES (34, 7, 'change_cliente', 'Can change cliente');
INSERT INTO "main"."auth_permission" VALUES (35, 7, 'delete_cliente', 'Can delete cliente');
INSERT INTO "main"."auth_permission" VALUES (36, 7, 'view_cliente', 'Can view cliente');
INSERT INTO "main"."auth_permission" VALUES (37, 9, 'add_pedido', 'Can add pedido');
INSERT INTO "main"."auth_permission" VALUES (38, 9, 'change_pedido', 'Can change pedido');
INSERT INTO "main"."auth_permission" VALUES (39, 9, 'delete_pedido', 'Can delete pedido');
INSERT INTO "main"."auth_permission" VALUES (40, 9, 'view_pedido', 'Can view pedido');
INSERT INTO "main"."auth_permission" VALUES (41, 10, 'add_estado', 'Can add estado');
INSERT INTO "main"."auth_permission" VALUES (42, 10, 'change_estado', 'Can change estado');
INSERT INTO "main"."auth_permission" VALUES (43, 10, 'delete_estado', 'Can delete estado');
INSERT INTO "main"."auth_permission" VALUES (44, 10, 'view_estado', 'Can view estado');
INSERT INTO "main"."auth_permission" VALUES (45, 11, 'add_version', 'Can add version');
INSERT INTO "main"."auth_permission" VALUES (46, 11, 'change_version', 'Can change version');
INSERT INTO "main"."auth_permission" VALUES (47, 11, 'delete_version', 'Can delete version');
INSERT INTO "main"."auth_permission" VALUES (48, 11, 'view_version', 'Can view version');
INSERT INTO "main"."auth_permission" VALUES (49, 12, 'add_orden', 'Can add orden');
INSERT INTO "main"."auth_permission" VALUES (50, 12, 'change_orden', 'Can change orden');
INSERT INTO "main"."auth_permission" VALUES (51, 12, 'delete_orden', 'Can delete orden');
INSERT INTO "main"."auth_permission" VALUES (52, 12, 'view_orden', 'Can view orden');
INSERT INTO "main"."auth_permission" VALUES (53, 13, 'add_proceso', 'Can add proceso');
INSERT INTO "main"."auth_permission" VALUES (54, 13, 'change_proceso', 'Can change proceso');
INSERT INTO "main"."auth_permission" VALUES (55, 13, 'delete_proceso', 'Can delete proceso');
INSERT INTO "main"."auth_permission" VALUES (56, 13, 'view_proceso', 'Can view proceso');
INSERT INTO "main"."auth_permission" VALUES (57, 14, 'add_palabra', 'Can add palabra');
INSERT INTO "main"."auth_permission" VALUES (58, 14, 'change_palabra', 'Can change palabra');
INSERT INTO "main"."auth_permission" VALUES (59, 14, 'delete_palabra', 'Can delete palabra');
INSERT INTO "main"."auth_permission" VALUES (60, 14, 'view_palabra', 'Can view palabra');

-- ----------------------------
-- Table structure for auth_recover
-- ----------------------------
DROP TABLE IF EXISTS "main"."auth_recover";
CREATE TABLE "auth_recover" (
"id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"username"  varchar(150) NOT NULL,
"ip"  varchar(15) NOT NULL,
"code"  varchar(64) NOT NULL,
"date"  timestamp NOT NULL,
"active"  bool NOT NULL
);

-- ----------------------------
-- Records of auth_recover
-- ----------------------------
INSERT INTO "main"."auth_recover" VALUES (2, 'escaladores@correo.com', '10.81.234.2', 'Xc5Xwr6YCCaUfTfI9bOKyoSy0iYi0seFXxy0ZZ8ZX0jjhJFNLNIeuQqqarTb53LO', '2022-12-29 17:23:16.464523', 1);
INSERT INTO "main"."auth_recover" VALUES (4, 'jonathandelacruzalvarez1@gmail.com', '10.81.234.3', 'mOGfv5AjDEV5H1a8qX8tKWdHgpRkIoCbt3Ux5OZhbIiMVpMoBa9vYzdhU9sLiXOu', '2022-12-29 17:05:05.099705', 1);
INSERT INTO "main"."auth_recover" VALUES (7, 'soloacti@gmail.com', '10.81.234.2', 'QdnDxyMddLftOq0WrQoe16Ed3hv5XrEr5rMgZdMBYWFIMn55K1Bs9OKv9CRfMETv', '2022-12-29 17:17:48.874559', 1);
INSERT INTO "main"."auth_recover" VALUES (8, 'fff@ddd.com', '10.81.234.2', 'vODGfSCdafNRtGdukloQOO6jXhnB7DRZDLjCFv7bPgmBvSXEJID3PYZwpPni8CXX', '2022-12-29 17:24:02.389732', 1);
INSERT INTO "main"."auth_recover" VALUES (9, '1234qwer@dddd.com', '10.81.234.2', '3T7WSLZtydNmFErB02ILo4SVQeoI2xofVhJXSan1JhR1wtffdreCRDHmrA768K3r', '2022-12-29 17:26:32.261526', 1);

-- ----------------------------
-- Table structure for auth_token
-- ----------------------------
DROP TABLE IF EXISTS "main"."auth_token";
CREATE TABLE "auth_token" (
"id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"username"  varchar(150) NOT NULL,
"roles"  varchar(50) NOT NULL,
"ip"  varchar(15) NOT NULL,
"token"  varchar(255) NOT NULL,
"date"  timestamp NOT NULL,
"active"  bool NOT NULL
);

-- ----------------------------
-- Records of auth_token
-- ----------------------------
INSERT INTO "main"."auth_token" VALUES (1, 'escaladores@correo.com', 'alumno', '10.81.234.2', 'Bearer XdVtiTviB8jhfi3oMSIl6DguNKngFJJQVxrJLE1NmCuIHKD7Wx2O4G9Ewyc0hsA4tjajk8mNJVDGPLAcB6t4pqg99fGNbf61sY5CtNa5IIAQWFqlgHSQ3BQcJNcBmX9kNk7WaG2mytOUybJs3swMf2VkqDbRtowsslVIstHpTXbBKxibRjs4tEhw7xaNKfEDTvfb1lHg8QgXgxspUgoVsSdQDNxQx9wNKDIHwRuMSIm2P9RJ', '2022-12-29 19:36:27.424457', 1);
INSERT INTO "main"."auth_token" VALUES (2, 'soloactivoscofreclan@gmail.com', 'alumno', '10.81.234.2', 'Bearer CDxyQnUPI4jmGpw3ubrEb8O1C4vzqUzNc0NBf87Fd6F1xwGLQD0t1TUnuKmRMnjxkORnXBDjoNkwFjUFtlQLsRWAwuY9sq7EpwoUYPpKHc0RopbheKK7aAAgMEOr0x3qGvQW903izROxx1JjiMvXLjjq1a5GsRwYpZVwZ3Bi3ydOS23rPyKQnC7MUy9t6WRT47aMCf3kw9LjGUv6JL2MTPvKDhhdUHBYG9vd6gZ9cUtaZ1jj', '2023-01-03 01:28:34.776191', 0);
INSERT INTO "main"."auth_token" VALUES (3, 'jonathandelacruzalvarez@gmail.com', 'alumno', '10.81.234.3', 'Bearer N6WHLQeE4ggug4PpEW6UQhTGGa7ZxSrqiFmxUUSsUyEJ2zUr7eLxcYolW66BH4yjhDadkc0CuJRhmRpWwum3Wx8CqGsisccFDQw4hDBgTs272XfBdrm3ORAYqDrgblLA4zBtGjkgSt2gGNa1ZjkzcCK0Lt3sOcAtxPJDAqisJLafsA2s4qbfEHXOKKFN7EG9qLS8NDZ8RZUlnsuu5mPyQ6p4wRs5fVQbGYKcUTGFHzUEZL8B', '2022-12-29 20:24:05.601813', 0);
INSERT INTO "main"."auth_token" VALUES (4, 'pina@correo.com', 'alumno', '10.81.234.2', 'Bearer A9MJ6MIls82AqI1ruX7ISC3s4o1ZytEpW1jgAdEI4DRUKKr3vm9oDI2Ju0JUF27reI6pesbXPJIhWWBOC0yOevbQuvg7Jr1Y0rIaneEBRbidJppNITu03AvXo24BM8r6CAh3m5bNpnM64kGU59rf2lQKgGrSz9pzg5aXvFswoRMkNI6wjPOug0iFRD9nF59bZRNE2cPlYQVs7ceVZ4tBYD0HdgAypYHVtLRfwv0sw4MlYGop', '2022-12-29 16:35:49.676168', 0);
INSERT INTO "main"."auth_token" VALUES (5, 'matali@correo.com', 'alumno', '10.81.234.2', 'Bearer x9lDi8wae3TM8mHJCLDYMr5klTgKNXTgWmNc82KjaibZkDMvCZBRIMfmRp1ABxdHVRB6EFAmeMpH3pJsAuuzPfadNGgHCRSwEtHHXRB3KGCkzesNstw3rWJu8j7sKp2CU2MNXq9mAVlbzpXUcNAUkwhldGO19k4Fe45zsFVQ26CUJ9f6RkkCIIttNW36adYHVaze1ten0sXf7UVN8zXWa86cb35jDCaaMi4a4uhHGdJd9YnH', '2022-12-31 17:50:14.655778', 0);
INSERT INTO "main"."auth_token" VALUES (6, 'correo@correo.com', 'alumno', '10.81.234.2', 'Bearer FEll7180fQIlxszYprRWwgx9xM9bdQO6K2lQ8pJnGgbgvjjbEoOfJ5iVPkVxSKvlm8pj5a0ycxN7czYkhJ6caaB3XMPJOiEwoj1OoVzgPtWq888YX8mAwVTmnUtE7GR76rtCzraMmGB5Hu0f3HtLPuD9sxY5k7YFzHoSfjZ6zGlXlkdvrcf2RfWYwK7s2UCQNFSCkMdiP4rfKXFO6HUooTnr8RZbEuwK8qp6KdQOjISYPEqZ', '2022-12-31 17:51:05.620829', 0);
INSERT INTO "main"."auth_token" VALUES (7, 'jajm@correo.com', 'alumno', '10.81.234.2', 'Bearer FtYrXE3dyAqbKaVuP5t8NDyrEkf06duXZQiZYVJS9sBQofh1Sy3PTjm8Fjho5GoE94Es0dTLnAhZtqpszU81QO3g3qcby67Ai4rn6228KKzWG8Bb41KWYj53HUZa7RgnbEAcmZGZRnuoc9bQuvFxB38n9gS5ApEdInCdCsCz4k4ZujHe561GtUNEHaCEpYPaIw6YvUA2gbDd2JMAdVZI7v3YVPey1wcf9zLuq7ZxrjFCbd2v', '2023-01-03 01:28:46.375828', 1);

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS "main"."auth_user";
CREATE TABLE "auth_user" (
"id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"password"  varchar(128) NOT NULL,
"last_login"  datetime,
"is_superuser"  bool NOT NULL,
"username"  varchar(150) NOT NULL,
"first_name"  varchar(150) NOT NULL,
"last_name"  varchar(150) NOT NULL,
"email"  varchar(254) NOT NULL,
"is_staff"  bool NOT NULL,
"is_active"  bool NOT NULL,
"date_joined"  datetime NOT NULL,
UNIQUE ("username" ASC)
);

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO "main"."auth_user" VALUES (1, 'pbkdf2_sha256$260000$SECrx35D9JW5A2gjPa7qXb$SIOSxx9Elwe0IZcUoI7RzUrcBLo03NBeV8/QUokhn1E=', '2023-01-03 01:28:46.329118', 1, 'jajm@correo.com', 'José Ángel', 'J.A.', 'ja@mail.com', 1, 1, '2020-10-03 09:27:04.014731');
INSERT INTO "main"."auth_user" VALUES (2, 'pbkdf2_sha256$260000$gBkZt44QcZ8LFaq1qNfQOO$FATc6MAdNVwaAczYKTloGv9oNa0sb7DQGM3W6oKOqJ4=', '2020-10-03 10:52:17.845050', 0, 'jona@correo.com', 'Jonathan', 'Jona', 'jona@mail.com', 1, 1, '2020-10-03 09:33:48');
INSERT INTO "main"."auth_user" VALUES (3, 'pbkdf2_sha256$260000$Hp44LbZOARSL3wT1XgowHs$Msd8f/aE0R0mIlNxTIT7eBfsj8p0/dGEI6kquOs26+c=', '2022-12-29 19:36:27.375271', 0, 'escaladores@correo.com', 'Escaladores', 'Del Monte Everest', 'escaladores@correo.com', 0, 1, '2022-07-20 04:16:55.855015');
INSERT INTO "main"."auth_user" VALUES (4, 'pbkdf2_sha256$260000$yIn0WE88R7ZYI5DmTjUaRV$jH8EhG1j3HxGOiPcTEygyyFXGwZO8v/H27Y8iaE78Js=', '2022-12-29 16:08:12.214976', 0, 'pina@correo.com', 'Delfina', 'Gómez', 'pina@correo.com', 0, 1, '2022-08-04 04:05:29.535953');
INSERT INTO "main"."auth_user" VALUES (5, 'pbkdf2_sha256$260000$W0JIuFegle007UVEbCtiQF$tm7+dvzmzs3b3crtkiKVPFw+Xw77GrrpxSo5UkM/QX0=', '2022-12-31 17:50:08.126612', 0, 'matali@correo.com', 'Agua', 'De Matali', 'matali@correo.com', 0, 1, '2022-08-04 04:05:30.035948');
INSERT INTO "main"."auth_user" VALUES (6, 'pbkdf2_sha256$260000$HNPyF4C758h8HtbWKLNVCL$pQPpbBeHSjl+XcNToeq24swa2CoevB4iDeZayjM4CS4=', null, 0, 'limon@correo.com', 'Pedro', 'Limon', 'limon@correo.com', 0, 1, '2022-08-04 04:05:30.477969');
INSERT INTO "main"."auth_user" VALUES (7, 'pbkdf2_sha256$260000$oSX9YDtqGFb0Y4FfL6EKPD$+aYuZOS2roha48DfclkJXf2hNVHN/aE23qD5ULGU2B0=', null, 0, 'uva@correo.com', 'Ulises', 'Velóz Árias', 'uva@correo.com', 0, 1, '2022-08-04 04:05:30.909222');
INSERT INTO "main"."auth_user" VALUES (8, 'pbkdf2_sha256$260000$DAnlpaTpHRYzfRBwDasVsZ$z1rfrKQGivuaAqYXg4gFFW8UJV1k6HVc/p/2jI3WV2M=', '2022-12-31 17:50:53.437060', 0, 'correo@correo.com', 'Correo', 'Correo', 'correo@correo.com', 0, 1, '2022-12-28 22:34:27.841176');
INSERT INTO "main"."auth_user" VALUES (9, 'pbkdf2_sha256$260000$I0xnFmg9MIhtmvWOadeLel$cjmq/vn0DgCLOVNKQHxAZo537Fc1QESO26rclHYmdIQ=', '2022-12-29 13:03:51.334884', 0, 'jonathandelacruzalvarez@gmail.com', 'Jonathan', 'De La Cruz Alvarez', 'jonathandelacruzalvarez@gmail.com', 0, 1, '2022-12-29 00:31:10.520138');
INSERT INTO "main"."auth_user" VALUES (10, 'pbkdf2_sha256$260000$TSN21o0gqercIMJd4oHOPY$S3yljlPcDGOw7YhcwnfKr9t8eUpnCGXv+uXz69XtFfs=', '2023-01-03 00:58:44.000381', 0, 'soloactivoscofreclan@gmail.com', 'Solo', 'Activos', 'soloactivoscofreclan@gmail.com', 0, 1, '2022-12-29 05:22:09.745356');
INSERT INTO "main"."auth_user" VALUES (11, 'pbkdf2_sha256$260000$Wv0irXM5gdF2Qor5AV6iY8$HWcf+bN3Vrx8wBGTCS7IZpflavNiDjZbTXy0jCe3lGA=', '2022-12-29 18:58:38.104778', 0, 'jonathandelacruz@gmail.com', 'Jonathan', 'De La Cruz', 'jonathandelacruz@gmail.com', 0, 1, '2022-12-29 17:27:39.207355');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS "main"."auth_user_groups";
CREATE TABLE "auth_user_groups" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED);

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS "main"."auth_user_user_permissions";
CREATE TABLE "auth_user_user_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for backend_actividad
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_actividad";
CREATE TABLE "backend_actividad" (
"act_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"act_nombre"  varchar(50) NOT NULL,
"act_descripcion"  varchar(255) NOT NULL,
"act_inicio"  datetime NOT NULL,
"act_fin"  datetime NOT NULL,
"act_puntaje"  integer NOT NULL,
"act_integrantes"  integer NOT NULL,
"act_fkaula"  integer NOT NULL,
"act_fkproceso"  INTEGER NOT NULL,
"act_fkrecurso"  integer NOT NULL,
"act_fkinstrumento"  integer NOT NULL,
"act_estado"  integer NOT NULL,
"act_creacion"  timestamp NOT NULL,
"act_modificacion"  timestamp NOT NULL,
"act_creador"  integer NOT NULL,
"act_modificador"  integer NOT NULL,
CONSTRAINT "fkey0" FOREIGN KEY ("act_fkaula") REFERENCES "backend_aula" ("aul_id") DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT "fkey1" FOREIGN KEY ("act_fkproceso") REFERENCES "backend_proceso" ("pro_id"),
CONSTRAINT "fkey2" FOREIGN KEY ("act_fkrecurso") REFERENCES "backend_recurso" ("rec_id"),
FOREIGN KEY ("act_fkinstrumento") REFERENCES "backend_archivo" ("arc_id")
);

-- ----------------------------
-- Records of backend_actividad
-- ----------------------------
INSERT INTO "main"."backend_actividad" VALUES (1, 'Evaluación Diagnóstica', 'Descripción de la Evaluación Diagnóstica', '2022-07-09 10:00:00', '2022-07-31 11:00:00', 20, 3, 1, 1, 1, 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_actividad" VALUES (2, 'Expresión Oral', 'Descripción de Expresión Oral', '2022-07-09 10:00:00', '2022-07-31 12:00:00', 40, 3, 1, 2, 2, 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_actividad" VALUES (3, 'Expresión Escrita', 'Descripción de Expresión Escrita', '2022-07-09 10:00:00', '2022-07-31 13:00:00', 40, 2, 1, 3, 0, 0, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_actividad" VALUES (4, 'Redes Neuronales 1', 'Redes Neuronales 1', '2022-07-09 10:00:00', '2022-07-31 15:00:00', 10, 1, 2, 2, 5, 5, 1, '2022-07-09 22:00:00', '2022-09-04 00:51:59.969567', 0, 3);
INSERT INTO "main"."backend_actividad" VALUES (5, 'Redes Neuronales 2', 'Redes Neuronales 2', '2022-07-09 10:00:00', '2022-08-31 15:00:00', 10, 5, 2, 2, 2, 2, 1, '2022-07-09 22:00:00', '2022-08-08 21:36:13.375469', 0, 3);
INSERT INTO "main"."backend_actividad" VALUES (6, 'Redes Neuronales 3', 'Redes Neuronales 3', '2022-07-09 10:00:00', '2022-07-31 16:00:00', 20, 2, 2, 2, 0, 0, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_actividad" VALUES (7, 'Redes Neuronales 4', 'Redes Neuronales 4', '2022-08-01 10:00:00', '2022-08-31 12:00:00', 20, 2, 2, 2, 1, 2, 2, '2022-08-08 21:33:34.290333', '2022-08-08 21:37:15.652520', 3, 3);
INSERT INTO "main"."backend_actividad" VALUES (8, 'Redes Neuronales 5', 'Redes Neuronales 5', '2022-11-19 20:00:00', '2022-11-26 20:00:00', 20, 3, 2, 4, 5, 6, 1, '2022-11-20 02:18:10.593903', '2022-11-20 03:28:36.593615', 3, 3);
INSERT INTO "main"."backend_actividad" VALUES (9, 'Investiga sobre los lenguajes', 'Realizar un documento donde se describa la importancia de los lenguajes', '2022-11-18 22:00:00', '2022-11-26 22:00:00', 40, 1, 3, 2, 0, 0, 1, '2022-11-20 04:10:18.824803', '2022-11-20 04:10:39.077621', 3, 3);
INSERT INTO "main"."backend_actividad" VALUES (10, 'Escribe un código en un lenguaje', 'Escribe la suma de 2 números en un lenguaje', '2022-11-26 22:00:00', '2022-12-03 22:00:00', 60, 2, 3, 6, 0, 0, 1, '2022-11-20 04:11:57.885131', '2022-11-20 04:11:57.885166', 3, 3);

-- ----------------------------
-- Table structure for backend_archivo
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_archivo";
CREATE TABLE "backend_archivo" (
"arc_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"arc_nombre"  varchar(30) NOT NULL,
"arc_descripcion"  varchar(255) NOT NULL,
"arc_tipo"  varchar(1) NOT NULL,
"arc_ruta"  varchar(100) NOT NULL,
"arc_estado"  integer NOT NULL,
"arc_creacion"  timestamp NOT NULL,
"arc_modificacion"  timestamp NOT NULL,
"arc_creador"  integer NOT NULL,
"arc_modificador"  integer NOT NULL
);

-- ----------------------------
-- Records of backend_archivo
-- ----------------------------
INSERT INTO "main"."backend_archivo" VALUES (0, 'Sin Archivo', 'Sin Archivo', 'I', 'sinarchivo.pdf', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_archivo" VALUES (1, 'Archivo 1', 'Descripción de Archivo 1', 'I', 'archivo1.pdf', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_archivo" VALUES (2, 'Archivo 2', 'Descripción de Archivo 2', 'I', 'archivo2.pdf', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_archivo" VALUES (3, 'Instrumento1234567890', 'Instrumento12345678901234567890', 'I', 'archivo3.pdf', 1, '2022-09-03 23:32:21.300195', '2022-09-03 23:32:21.300195', 3, 3);
INSERT INTO "main"."backend_archivo" VALUES (4, 'Instrumento1234567890', 'Instrumento12345678901234567890', 'I', 'archivo4.pdf', 1, '2022-09-03 23:42:27.593737', '2022-09-03 23:42:27.593737', 3, 3);
INSERT INTO "main"."backend_archivo" VALUES (5, 'Instrumento1234567890', 'Instrumento12345678901234567890', 'I', 'I5_archivo5.pdf', 1, '2022-09-04 00:51:59.594569', '2022-09-04 00:51:59.796567', 3, 3);
INSERT INTO "main"."backend_archivo" VALUES (6, 'Instrumento1234567890', 'Instrumento12345678901234567890', 'I', 'I6_CALIFICACION.pdf', 1, '2022-11-20 02:19:48.512181', '2022-11-20 02:19:48.544408', 3, 3);
INSERT INTO "main"."backend_archivo" VALUES (7, 'Evidencia de la Evaluación Diagnóstica', 'Primera entrega de la Evaluación Diagnóstica', 'E', 'E7_archivo1.pdf', 0, '2023-01-01 04:35:21.075727', '2023-01-01 04:35:21.107122', 10, 10);
INSERT INTO "main"."backend_archivo" VALUES (8, 'Evaluación Diagnóstica', 'Entrega final de la Evaluación', 'E', 'E8_archivo2.pdf', 1, '2023-01-01 04:49:43.232055', '2023-01-01 04:49:43.264628', 10, 10);
INSERT INTO "main"."backend_archivo" VALUES (9, 'Evidencia FINAL de la Evaluación Diagnóstica', 'Última entrega de la Evaluación Diagnóstica', 'E', 'E00000009_5f3c3e98-837e-4ce0-b37c-9f79f03247a7.pdf', 1, '2023-01-01 06:35:58.438296', '2023-01-01 06:35:58.466916', 10, 10);

-- ----------------------------
-- Table structure for backend_aula
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_aula";
CREATE TABLE "backend_aula" (
"aul_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"aul_nombre"  varchar(50) NOT NULL,
"aul_descripcion"  varchar(255) NOT NULL,
"aul_clave"  varchar(10) NOT NULL,
"aul_estado"  integer NOT NULL,
"aul_creacion"  timestamp NOT NULL,
"aul_modificacion"  timestamp NOT NULL,
"aul_creador"  integer NOT NULL,
"aul_modificador"  integer NOT NULL
);

-- ----------------------------
-- Records of backend_aula
-- ----------------------------
INSERT INTO "main"."backend_aula" VALUES (1, 'Aula 1', 'Expresión Oral y Escrita', 'AulaA001', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_aula" VALUES (2, 'Aula 2', 'Redes Neuronales', 'AulaA002', 1, '2022-07-09 22:00:00', '2022-08-04 06:29:38.175708', 0, 3);
INSERT INTO "main"."backend_aula" VALUES (3, 'Aula 3', 'Algorítmos y programación', 'AulaA003', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_aula" VALUES (4, 'Aula 4', 'Matemáticas', 'AulaA004', 0, '2022-07-09 22:00:00', '2022-08-04 06:29:58.808446', 0, 3);
INSERT INTO "main"."backend_aula" VALUES (5, 'Aula 5', 'Programación Orientada a Objetos', 'AulaA005', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_aula" VALUES (6, 'Aula 6', 'Programando con PHP', 'AulaA006', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_aula" VALUES (7, 'Invertida', 'La descripción  de un aula invertida', 'DB1F085F', 1, '2022-08-04 01:20:05.486514', '2022-08-04 01:20:05.486514', 3, 3);
INSERT INTO "main"."backend_aula" VALUES (8, 'Laberinto', 'Descifrando el Laberinto  de las Cordilleras', '6A60FD50', 0, '2022-08-04 01:20:59.487192', '2022-08-04 06:29:48.062410', 3, 3);
INSERT INTO "main"."backend_aula" VALUES (9, 'Expresión', 'Evaluación Diagnóstica', '6E29AAC8', 1, '2022-08-04 07:16:23.340005', '2022-08-05 06:11:37.810580', 3, 3);

-- ----------------------------
-- Table structure for backend_estado
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_estado";
CREATE TABLE "backend_estado" (
"est_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"est_nombre"  varchar(30) NOT NULL,
"est_descripcion"  varchar(100) NOT NULL,
"est_tipo"  varchar(20) NOT NULL,
"est_estado"  integer NOT NULL,
"est_creacion"  timestamp NOT NULL,
"est_modificacion"  timestamp NOT NULL,
"est_creador"  integer NOT NULL,
"est_modificador"  integer NOT NULL
);

-- ----------------------------
-- Records of backend_estado
-- ----------------------------
INSERT INTO "main"."backend_estado" VALUES (0, 'Inactivo', 'Estado Inactivo usado en todas las tablas', 'Todas', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_estado" VALUES (1, 'Activo', 'Estado Activo usado en todas las tablas', 'Todas', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_estado" VALUES (2, 'Iniciada', ' Estado Iniciada usado en todas las tablas', 'Todas', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_estado" VALUES (3, 'Programada', 'Actividad Programada', 'Aula', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_estado" VALUES (4, 'Calificada', 'Actividad Calificada', 'Aula', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_estado" VALUES (5, 'Entregada', 'Estado Entregada en las Evidencias', 'Evidencia', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);

-- ----------------------------
-- Table structure for backend_evidencia
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_evidencia";
CREATE TABLE "backend_evidencia" (
"evi_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"evi_nombre"  varchar(50) NOT NULL,
"evi_descripcion"  varchar(255) NOT NULL,
"evi_calificacion"  integer,
"evi_fkusuario"  integer NOT NULL,
"evi_fkactividad"  integer NOT NULL,
"evi_fkarchivo"  integer NOT NULL,
"evi_estado"  integer NOT NULL,
"evi_entregada"  timestamp,
"evi_calificada"  timestamp,
"evi_creacion"  timestamp NOT NULL,
"evi_modificacion"  timestamp NOT NULL,
"evi_creador"  integer NOT NULL,
"evi_modificador"  integer NOT NULL,
CONSTRAINT "fkey0" FOREIGN KEY ("evi_fkactividad") REFERENCES "backend_actividad" ("act_id"),
CONSTRAINT "fkey1" FOREIGN KEY ("evi_fkarchivo") REFERENCES "backend_archivo" ("arc_id")
);

-- ----------------------------
-- Records of backend_evidencia
-- ----------------------------
INSERT INTO "main"."backend_evidencia" VALUES (1, 'Evidencia de la Evaluación Diagnóstica3', 'Primera entrega de la Evaluación Diagnóstica3', 8, 10, 1, 7, 0, null, null, '2022-07-09 22:00:00', '2023-01-02 08:10:52.688174', 10, 10);
INSERT INTO "main"."backend_evidencia" VALUES (2, 'Evaluación Iniciada Diagnóstica1', 'Segunda Entrega de la Evaluación1', 5, 10, 1, 8, 5, '2023-01-02 03:29:12.411701', null, '2022-07-09 22:00:00', '2023-01-02 03:29:12.411945', 10, 10);
INSERT INTO "main"."backend_evidencia" VALUES (3, 'Evidencia FINAL de la Evaluación Diagnóstica', 'Última entrega de la Evaluación Diagnóstica', 10, 10, 1, 9, 4, '2022-07-09 22:00:00', '2022-07-09 22:00:00', '2022-07-09 22:00:00', '2022-07-09 22:00:00', 10, 10);

-- ----------------------------
-- Table structure for backend_integrante
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_integrante";
CREATE TABLE "backend_integrante" (
"int_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"int_fkactividad"  integer NOT NULL,
"int_fkusuario"  integer NOT NULL,
"int_fkmiembro"  integer NOT NULL,
"int_roles"  varchar(20) NOT NULL,
"int_estado"  integer NOT NULL,
"int_creacion"  timestamp NOT NULL,
"int_modificacion"  timestamp NOT NULL,
"int_creador"  integer NOT NULL,
"int_modificador"  integer NOT NULL,
CONSTRAINT "fkey0" FOREIGN KEY ("int_fkactividad") REFERENCES "backend_actividad" ("act_id") DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of backend_integrante
-- ----------------------------
INSERT INTO "main"."backend_integrante" VALUES (1, 1, 10, 4, 'Moderador', 0, '2022-12-29 20:41:37.809066', '2023-01-03 00:59:54.554319', 3, 10);
INSERT INTO "main"."backend_integrante" VALUES (2, 1, 10, 10, 'Responsable', 1, '2022-12-29 20:41:44.318953', '2022-12-29 20:41:44.319000', 3, 3);
INSERT INTO "main"."backend_integrante" VALUES (3, 1, 10, 11, 'Integrante', 0, '2022-12-29 20:41:50.481092', '2022-12-29 20:43:13.538648', 3, 3);
INSERT INTO "main"."backend_integrante" VALUES (4, 1, 10, 11, 'Integrante', 0, '2022-12-29 20:43:30.072348', '2023-01-03 01:00:58.849529', 3, 10);
INSERT INTO "main"."backend_integrante" VALUES (5, 2, 10, 10, 'Moderador', 1, '2023-01-01 05:22:23.910014', '2023-01-01 05:22:23.910081', 10, 10);
INSERT INTO "main"."backend_integrante" VALUES (6, 1, 10, 4, 'Colaborador', 1, '2023-01-03 01:03:29.461083', '2023-01-03 01:03:29.461132', 10, 10);
INSERT INTO "main"."backend_integrante" VALUES (7, 1, 10, 10, 'Moderador', 0, '2023-01-03 01:03:50.272101', '2023-01-03 01:03:56.559211', 10, 10);
INSERT INTO "main"."backend_integrante" VALUES (8, 1, 10, 3, 'Moderador', 0, '2023-01-03 01:04:09.412051', '2023-01-03 01:27:13.041825', 10, 10);
INSERT INTO "main"."backend_integrante" VALUES (9, 1, 10, 3, 'Responsable', 0, '2023-01-03 01:27:24.615579', '2023-01-03 01:27:29.146458', 10, 10);
INSERT INTO "main"."backend_integrante" VALUES (10, 1, 10, 3, 'Colaborador', 0, '2023-01-03 01:27:44.994576', '2023-01-03 01:27:53.668059', 10, 10);
INSERT INTO "main"."backend_integrante" VALUES (11, 1, 10, 3, 'Integrante', 1, '2023-01-03 01:28:05.389506', '2023-01-03 01:28:05.389550', 10, 10);

-- ----------------------------
-- Table structure for backend_orden
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_orden";
CREATE TABLE "backend_orden" (
"ord_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"ord_nombre"  varchar(30) NOT NULL,
"ord_descripcion"  varchar(255) NOT NULL,
"ord_fkversion"  integer NOT NULL,
"ord_estado"  integer NOT NULL,
"ord_creacion"  timestamp NOT NULL,
"ord_modificacion"  timestamp NOT NULL,
"ord_creador"  integer NOT NULL,
"ord_modificador"  integer NOT NULL,
CONSTRAINT "fkey0" FOREIGN KEY ("ord_fkversion") REFERENCES "backend_version" ("ver_id")
);

-- ----------------------------
-- Records of backend_orden
-- ----------------------------
INSERT INTO "main"."backend_orden" VALUES (1, 'Orden inferior', 'Proceso congnitivo de orden inferior', 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_orden" VALUES (2, 'Orden superior', 'Proceso congnitivo de orden superior', 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);

-- ----------------------------
-- Table structure for backend_palabra
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_palabra";
CREATE TABLE "backend_palabra" (
"pal_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"pal_nombre"  varchar(255) NOT NULL,
"pal_descripcion"  varchar(255) NOT NULL,
"pal_fkproceso"  integer NOT NULL,
"pal_tipo"  integer NOT NULL,
"pal_estado"  integer NOT NULL,
"pal_creacion"  timestamp NOT NULL,
"pal_modificacion"  timestamp NOT NULL,
"pal_creador"  integer NOT NULL,
"pal_modificador"  integer NOT NULL,
CONSTRAINT "fkey0" FOREIGN KEY ("pal_fkproceso") REFERENCES "backend_proceso" ("pro_id") DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of backend_palabra
-- ----------------------------
INSERT INTO "main"."backend_palabra" VALUES (1, 'Recordar', 'Descripción de Recordar', 1, 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (2, 'Comprender', 'Descripción de Comprender', 2, 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (3, 'Aplicar', 'Descripción de Aplicar', 3, 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (4, 'Analizar', 'Descripción de Analizar', 4, 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (5, 'Evaluar', 'Descripción de Evaluar', 5, 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (6, 'Crear', 'Descripción de Crear', 6, 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (7, 'Describir', 'Descripción de Describir', 1, 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (8, 'Clasificar', 'Descripción de Clasificar', 2, 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (9, 'Desempeñar', 'Descripción de Desempeñar', 3, 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (10, 'Atribuir', 'Descripción de Atribuir', 4, 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (11, 'Atribuir', 'Descripción de Atribuir', 5, 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (12, 'Constuir', 'Descripción de Constuir', 6, 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (13, 'Definición', 'Descripción de Definición', 1, 3, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (14, 'Colección', 'Descripción de Colección', 2, 3, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (15, 'Demostración', 'Descripción de Demostración', 3, 3, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (16, 'Reseña', 'Descripción de Reseña', 4, 3, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (17, 'Reseña', 'Descripción de Reseña', 5, 3, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (18, 'Anuncio', 'Descripción de Anuncio', 6, 3, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (19, '¿Puedes enumerar...?', 'Descripción de ¿Puedes enumerar...?', 1, 4, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (20, '¿Puedes explicar qué está ocurriendo?', 'Descripción de ¿Puedes explicar qué está ocurriendo?', 2, 4, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (21, '¿Cómo usarías ...?', 'Descripción de ¿Cómo usarías ...?', 3, 4, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (22, '¿Cuáles son las partes o rasgos de ...?', 'Descripción de ¿Cuáles son las partes o rasgos de ...?', 4, 4, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (23, '¿Estás de acuerdo con...?', 'Descripción de ¿Estás de acuerdo con...?', 5, 4, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_palabra" VALUES (24, '¿Qué cambios harías para ...?', 'Descripción de ¿Qué cambios harías para ...?', 6, 4, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);

-- ----------------------------
-- Table structure for backend_participante
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_participante";
CREATE TABLE "backend_participante" (
"par_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"par_fkaula"  integer NOT NULL,
"par_fkusuario"  integer NOT NULL,
"par_roles"  varchar(20) NOT NULL,
"par_estado"  integer NOT NULL,
"par_creacion"  timestamp NOT NULL,
"par_modificacion"  timestamp NOT NULL,
"par_creador"  integer NOT NULL,
"par_modificador"  integer NOT NULL,
CONSTRAINT "fkey0" FOREIGN KEY ("par_fkaula") REFERENCES "backend_aula" ("aul_id") DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of backend_participante
-- ----------------------------
INSERT INTO "main"."backend_participante" VALUES (1, 1, 1, 'Creador', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (2, 1, 2, 'Colaborador', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (3, 1, 3, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (4, 2, 1, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (5, 2, 2, 'Colaborador', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (6, 2, 3, 'Creador', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (7, 3, 3, 'Creador', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (8, 4, 3, 'Colaborador', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (9, 5, 3, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (10, 6, 3, 'Colaborador', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (11, 3, 2, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (12, 4, 2, 'Creador', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (13, 5, 2, 'Creador', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (14, 6, 2, 'Creador', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (15, 3, 1, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (16, 4, 1, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (17, 5, 1, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (18, 6, 1, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (19, 7, 3, 'Creador', 1, '2022-08-04 01:20:05.694516', '2022-08-04 01:20:05.694516', 3, 3);
INSERT INTO "main"."backend_participante" VALUES (20, 8, 3, 'Creador', 1, '2022-08-04 01:20:59.954199', '2022-08-04 01:20:59.954199', 3, 3);
INSERT INTO "main"."backend_participante" VALUES (21, 3, 4, 'Participante', 0, '2022-07-09 22:00:00', '2022-12-28 11:10:39.009942', 0, 4);
INSERT INTO "main"."backend_participante" VALUES (22, 3, 5, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (23, 3, 6, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (24, 3, 7, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (25, 9, 3, 'Creador', 1, '2022-08-04 07:16:23.563537', '2022-08-04 07:16:23.563537', 3, 3);
INSERT INTO "main"."backend_participante" VALUES (26, 2, 1, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (27, 2, 5, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (28, 2, 6, 'Participante', 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_participante" VALUES (29, 1, 4, 'Participante', 0, '2022-12-28 08:58:55.448857', '2022-12-28 08:58:55.448900', 4, 4);
INSERT INTO "main"."backend_participante" VALUES (30, 2, 4, 'Participante', 0, '2022-12-28 10:40:13.555091', '2022-12-28 11:16:05.197191', 4, 4);
INSERT INTO "main"."backend_participante" VALUES (31, 1, 4, 'Participante', 0, '2022-12-28 10:50:23.811692', '2022-12-28 11:05:26.176948', 4, 4);
INSERT INTO "main"."backend_participante" VALUES (32, 1, 4, 'Participante', 0, '2022-12-28 11:28:37.319229', '2022-12-28 12:17:32.888736', 4, 4);
INSERT INTO "main"."backend_participante" VALUES (33, 2, 4, 'Participante', 0, '2022-12-28 11:55:48.252923', '2022-12-28 12:17:29.893963', 4, 4);
INSERT INTO "main"."backend_participante" VALUES (34, 3, 4, 'Participante', 0, '2022-12-28 11:55:52.869136', '2022-12-28 12:17:26.957327', 4, 4);
INSERT INTO "main"."backend_participante" VALUES (35, 5, 4, 'Participante', 0, '2022-12-28 11:55:55.884803', '2022-12-28 12:17:23.124269', 4, 4);
INSERT INTO "main"."backend_participante" VALUES (36, 5, 4, 'Participante', 0, '2022-12-28 12:17:37.043287', '2022-12-28 12:17:45.343345', 4, 4);
INSERT INTO "main"."backend_participante" VALUES (37, 5, 4, 'Participante', 1, '2022-12-28 12:17:48.884932', '2022-12-28 12:17:48.884974', 4, 4);
INSERT INTO "main"."backend_participante" VALUES (38, 1, 4, 'Participante', 1, '2022-12-28 12:18:12.523717', '2022-12-28 12:18:12.523759', 4, 4);
INSERT INTO "main"."backend_participante" VALUES (39, 1, 9, 'Participante', 0, '2022-12-29 00:32:32.690538', '2022-12-29 20:18:02.370139', 9, 9);
INSERT INTO "main"."backend_participante" VALUES (40, 1, 10, 'Participante', 1, '2022-12-29 09:26:50.945558', '2022-12-29 09:26:50.945626', 10, 10);
INSERT INTO "main"."backend_participante" VALUES (41, 1, 11, 'Participante', 1, '2022-12-29 18:49:12.072138', '2022-12-29 18:49:12.072183', 11, 11);
INSERT INTO "main"."backend_participante" VALUES (42, 9, 9, 'Participante', 1, '2022-12-29 20:18:08.691878', '2022-12-29 20:18:08.691932', 9, 9);
INSERT INTO "main"."backend_participante" VALUES (43, 1, 9, 'Participante', 1, '2022-12-29 20:18:31.407358', '2022-12-29 20:18:31.407401', 9, 9);

-- ----------------------------
-- Table structure for backend_proceso
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_proceso";
CREATE TABLE "backend_proceso" (
"pro_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"pro_nombre"  varchar(30) NOT NULL,
"pro_descripcion"  varchar(255) NOT NULL,
"pro_description"  varchar(255) NOT NULL,
"pro_posicion"  integer NOT NULL,
"pro_color"  varchar(10) NOT NULL,
"pro_fkorden"  integer NOT NULL,
"pro_estado"  integer NOT NULL,
"pro_creacion"  timestamp NOT NULL,
"pro_modificacion"  timestamp NOT NULL,
"pro_creador"  integer NOT NULL,
"pro_modificador"  integer NOT NULL,
CONSTRAINT "fkey0" FOREIGN KEY ("pro_fkorden") REFERENCES "backend_orden" ("ord_id") DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of backend_proceso
-- ----------------------------
INSERT INTO "main"."backend_proceso" VALUES (1, 'Recordar', 'Descripción de Recordar', 'Description of Remember', 1, '#FF0000', 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_proceso" VALUES (2, 'Comprender', 'Descripción de Comprender', 'Description of Understand', 2, '#FF7722', 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_proceso" VALUES (3, 'Aplicar', 'Descripción de Aplicar', 'Description of Apply', 3, '#FFFF00', 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_proceso" VALUES (4, 'Analizar', 'Descripción de Analizar', 'Description of Analyze', 4, '#77DD77', 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_proceso" VALUES (5, 'Evaluar', 'Descripción de Evaluar', 'Description of Avaluate', 5, '#7777FF', 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_proceso" VALUES (6, 'Crear', 'Descripción de Crear', 'Description of Create', 6, '#2277FF', 2, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);

-- ----------------------------
-- Table structure for backend_recurso
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_recurso";
CREATE TABLE "backend_recurso" (
"rec_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"rec_nombre"  varchar(30) NOT NULL,
"rec_descripcion"  varchar(255) NOT NULL,
"rec_ruta"  varchar(255) NOT NULL,
"rec_publico"  integer NOT NULL,
"rec_estado"  integer NOT NULL,
"rec_creacion"  timestamp NOT NULL,
"rec_modificacion"  timestamp NOT NULL,
"rec_creador"  integer NOT NULL,
"rec_modificador"  integer NOT NULL
);

-- ----------------------------
-- Records of backend_recurso
-- ----------------------------
INSERT INTO "main"."backend_recurso" VALUES (0, 'Sin Recurso', 'Sin Recurso', 'sinrecurso.png', 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_recurso" VALUES (1, 'El Recurso 1', 'Descripción de Recurso 1', 'recurso1.png', 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_recurso" VALUES (2, 'El Recurso 2', 'Descripción de Recurso 2', 'recurso2.png', 1, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_recurso" VALUES (3, 12345678901234567890, 123456789012345678901234567890, 'mexico-icono.png', 1, 1, '2022-08-18 04:40:44.329422', '2022-08-18 04:40:44.330424', 3, 3);
INSERT INTO "main"."backend_recurso" VALUES (4, 'Aaaaaaaaaaa', 'Aaaaaaaaaaaaaaaaaaaaa', 'usa-icono.png', 1, 1, '2022-08-18 04:45:12.231511', '2022-08-18 04:45:12.231511', 3, 3);
INSERT INTO "main"."backend_recurso" VALUES (5, 'New12345678', 123456789012345678901234567890, 'faq.png', 1, 1, '2022-08-19 01:08:57.003152', '2022-08-19 01:08:57.003199', 3, 3);
INSERT INTO "main"."backend_recurso" VALUES (6, 'Recurso123456789', 'Recurso1234567891234567890', 'buscar.png', 1, 1, '2022-11-20 02:18:39.417751', '2022-11-20 02:18:39.417793', 3, 3);
INSERT INTO "main"."backend_recurso" VALUES (7, 'Recurso123456789', 'Recurso1234567891234567890', 'buscar.png', 1, 1, '2022-11-20 02:18:45.294182', '2022-11-20 02:18:45.294223', 3, 3);
INSERT INTO "main"."backend_recurso" VALUES (8, 'Recurso123456789', 'Recurso1234567891234567890', 'buscar.png', 1, 1, '2022-11-20 02:19:02.698730', '2022-11-20 02:19:02.698771', 3, 3);
INSERT INTO "main"."backend_recurso" VALUES (9, 'Recurso123456789', 'Recurso1234567891234567890', 'buscar.png', 1, 1, '2022-11-20 02:20:00.614017', '2022-11-20 02:20:00.614060', 3, 3);
INSERT INTO "main"."backend_recurso" VALUES (10, 'Recurso123456789', 'Recurso1234567891234567890', 'buscar.png', 1, 1, '2022-11-20 02:34:14.980983', '2022-11-20 02:34:15.005493', 3, 3);
INSERT INTO "main"."backend_recurso" VALUES (11, 'Recurso123456789', 'Recurso1234567891234567890', 'buscar.png', 1, 1, '2022-11-20 02:40:59.106585', '2022-11-20 02:40:59.132394', 3, 3);

-- ----------------------------
-- Table structure for backend_version
-- ----------------------------
DROP TABLE IF EXISTS "main"."backend_version";
CREATE TABLE "backend_version" (
"ver_id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"ver_nombre"  varchar(30) NOT NULL,
"ver_descripcion"  varchar(255) NOT NULL,
"ver_anio"  integer NOT NULL,
"ver_estado"  integer NOT NULL,
"ver_creacion"  timestamp NOT NULL,
"ver_modificacion"  timestamp NOT NULL,
"ver_creador"  integer NOT NULL,
"ver_modificador"  integer NOT NULL
);

-- ----------------------------
-- Records of backend_version
-- ----------------------------
INSERT INTO "main"."backend_version" VALUES (1, 'Versión 1', 'Primera Versión Registrada', 1968, 0, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);
INSERT INTO "main"."backend_version" VALUES (2, 'Versión 2', 'Segunda Versión Registrada', 2001, 1, '2022-07-09 22:00:00', '2022-07-09 22:00:00', 0, 0);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS "main"."django_admin_log";
CREATE TABLE "django_admin_log" (
"id"  integer PRIMARY KEY AUTOINCREMENT NOT NULL,
"action_time"  datetime NOT NULL,
"object_id"  text,
"object_repr"  varchar(200) NOT NULL,
"change_message"  text NOT NULL,
"content_type_id"  integer,
"user_id"  integer NOT NULL,
"action_flag"  smallint NOT NULL,
CONSTRAINT "fkey0" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT "fkey1" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED,
CHECK ("action_flag" >= 0)
);

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS "main"."django_content_type";
CREATE TABLE "django_content_type" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app_label" varchar(100) NOT NULL, "model" varchar(100) NOT NULL);

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO "main"."django_content_type" VALUES (1, 'admin', 'logentry');
INSERT INTO "main"."django_content_type" VALUES (2, 'auth', 'permission');
INSERT INTO "main"."django_content_type" VALUES (3, 'auth', 'group');
INSERT INTO "main"."django_content_type" VALUES (4, 'auth', 'user');
INSERT INTO "main"."django_content_type" VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO "main"."django_content_type" VALUES (6, 'sessions', 'session');
INSERT INTO "main"."django_content_type" VALUES (7, 'backend', 'cliente');
INSERT INTO "main"."django_content_type" VALUES (8, 'backend', 'producto');
INSERT INTO "main"."django_content_type" VALUES (9, 'backend', 'pedido');
INSERT INTO "main"."django_content_type" VALUES (10, 'backend', 'estado');
INSERT INTO "main"."django_content_type" VALUES (11, 'backend', 'version');
INSERT INTO "main"."django_content_type" VALUES (12, 'backend', 'orden');
INSERT INTO "main"."django_content_type" VALUES (13, 'backend', 'proceso');
INSERT INTO "main"."django_content_type" VALUES (14, 'backend', 'palabra');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS "main"."django_migrations";
CREATE TABLE "django_migrations" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "applied" datetime NOT NULL);

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO "main"."django_migrations" VALUES (1, 'contenttypes', '0001_initial', '2022-07-11 09:51:48.340039');
INSERT INTO "main"."django_migrations" VALUES (2, 'auth', '0001_initial', '2022-07-11 09:51:48.834240');
INSERT INTO "main"."django_migrations" VALUES (3, 'admin', '0001_initial', '2022-07-11 09:51:48.961013');
INSERT INTO "main"."django_migrations" VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2022-07-11 09:51:49.099984');
INSERT INTO "main"."django_migrations" VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2022-07-11 09:51:49.235979');
INSERT INTO "main"."django_migrations" VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2022-07-11 09:51:49.364016');
INSERT INTO "main"."django_migrations" VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2022-07-11 09:51:49.490451');
INSERT INTO "main"."django_migrations" VALUES (8, 'auth', '0003_alter_user_email_max_length', '2022-07-11 09:51:49.616608');
INSERT INTO "main"."django_migrations" VALUES (9, 'auth', '0004_alter_user_username_opts', '2022-07-11 09:51:49.746527');
INSERT INTO "main"."django_migrations" VALUES (10, 'auth', '0005_alter_user_last_login_null', '2022-07-11 09:51:49.872657');
INSERT INTO "main"."django_migrations" VALUES (11, 'auth', '0006_require_contenttypes_0002', '2022-07-11 09:51:50.001507');
INSERT INTO "main"."django_migrations" VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2022-07-11 09:51:50.130784');
INSERT INTO "main"."django_migrations" VALUES (13, 'auth', '0008_alter_user_username_max_length', '2022-07-11 09:51:50.257198');
INSERT INTO "main"."django_migrations" VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2022-07-11 09:51:50.384660');
INSERT INTO "main"."django_migrations" VALUES (15, 'auth', '0010_alter_group_name_max_length', '2022-07-11 09:51:50.516104');
INSERT INTO "main"."django_migrations" VALUES (16, 'auth', '0011_update_proxy_permissions', '2022-07-11 09:51:50.639145');
INSERT INTO "main"."django_migrations" VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2022-07-11 09:51:50.767508');
INSERT INTO "main"."django_migrations" VALUES (18, 'sessions', '0001_initial', '2022-07-11 09:51:50.883937');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS "main"."django_session";
CREATE TABLE "django_session" ("session_key" varchar(40) NOT NULL PRIMARY KEY, "session_data" text NOT NULL, "expire_date" datetime NOT NULL);

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for sqlite_sequence
-- ----------------------------
DROP TABLE IF EXISTS "main"."sqlite_sequence";
CREATE TABLE sqlite_sequence(name,seq);

-- ----------------------------
-- Records of sqlite_sequence
-- ----------------------------
INSERT INTO "main"."sqlite_sequence" VALUES ('django_migrations', 18);
INSERT INTO "main"."sqlite_sequence" VALUES ('django_content_type', 14);
INSERT INTO "main"."sqlite_sequence" VALUES ('auth_permission', 60);
INSERT INTO "main"."sqlite_sequence" VALUES ('auth_group', 0);
INSERT INTO "main"."sqlite_sequence" VALUES ('django_admin_log', 0);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_version', 2);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_estado', 5);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_orden', 2);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_palabra', 24);
INSERT INTO "main"."sqlite_sequence" VALUES ('auth_token', 7);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_proceso', 6);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_recurso', 11);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_aula', 9);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_actividad', 10);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_participante', 43);
INSERT INTO "main"."sqlite_sequence" VALUES ('auth_recover', 9);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_integrante', 11);
INSERT INTO "main"."sqlite_sequence" VALUES ('auth_user', 11);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_archivo', 9);
INSERT INTO "main"."sqlite_sequence" VALUES ('backend_evidencia', 3);

-- ----------------------------
-- Indexes structure for table auth_group_permissions
-- ----------------------------
CREATE INDEX "main"."auth_group_permissions_group_id_b120cbf9"
ON "auth_group_permissions" ("group_id" ASC);
CREATE UNIQUE INDEX "main"."auth_group_permissions_group_id_permission_id_0cd325b0_uniq"
ON "auth_group_permissions" ("group_id" ASC, "permission_id" ASC);
CREATE INDEX "main"."auth_group_permissions_permission_id_84c5c92e"
ON "auth_group_permissions" ("permission_id" ASC);

-- ----------------------------
-- Indexes structure for table auth_permission
-- ----------------------------
CREATE INDEX "main"."auth_permission_content_type_id_2f476e4b"
ON "auth_permission" ("content_type_id" ASC);
CREATE UNIQUE INDEX "main"."auth_permission_content_type_id_codename_01ab375a_uniq"
ON "auth_permission" ("content_type_id" ASC, "codename" ASC);

-- ----------------------------
-- Indexes structure for table auth_recover
-- ----------------------------
CREATE UNIQUE INDEX "main"."user"
ON "auth_recover" ("username" ASC);

-- ----------------------------
-- Indexes structure for table auth_user_groups
-- ----------------------------
CREATE INDEX "main"."auth_user_groups_group_id_97559544"
ON "auth_user_groups" ("group_id" ASC);
CREATE INDEX "main"."auth_user_groups_user_id_6a12ed8b"
ON "auth_user_groups" ("user_id" ASC);
CREATE UNIQUE INDEX "main"."auth_user_groups_user_id_group_id_94350c0c_uniq"
ON "auth_user_groups" ("user_id" ASC, "group_id" ASC);

-- ----------------------------
-- Indexes structure for table auth_user_user_permissions
-- ----------------------------
CREATE INDEX "main"."auth_user_user_permissions_permission_id_1fbb5f2c"
ON "auth_user_user_permissions" ("permission_id" ASC);
CREATE INDEX "main"."auth_user_user_permissions_user_id_a95ead1b"
ON "auth_user_user_permissions" ("user_id" ASC);
CREATE UNIQUE INDEX "main"."auth_user_user_permissions_user_id_permission_id_14a6b632_uniq"
ON "auth_user_user_permissions" ("user_id" ASC, "permission_id" ASC);

-- ----------------------------
-- Indexes structure for table backend_aula
-- ----------------------------
CREATE UNIQUE INDEX "main".""
ON "backend_aula" ("aul_clave" ASC);

-- ----------------------------
-- Indexes structure for table django_admin_log
-- ----------------------------
CREATE INDEX "main"."django_admin_log_content_type_id_c4bce8eb"
ON "django_admin_log" ("content_type_id" ASC);
CREATE INDEX "main"."django_admin_log_user_id_c564eba6"
ON "django_admin_log" ("user_id" ASC);

-- ----------------------------
-- Indexes structure for table django_content_type
-- ----------------------------
CREATE UNIQUE INDEX "main"."django_content_type_app_label_model_76bd3d3b_uniq"
ON "django_content_type" ("app_label" ASC, "model" ASC);

-- ----------------------------
-- Indexes structure for table django_session
-- ----------------------------
CREATE INDEX "main"."django_session_expire_date_a5c62663"
ON "django_session" ("expire_date" ASC);
