import 'dart:convert';

import 'package:http/http.dart';
import 'package:infancia/domain/network/service_endpoint.dart';
import 'package:infancia/domain/preferences/preferences.dart';
 

const baseURLTest =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Consulta_General.php";
 

const baseURLInsertTest =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Guardar_entrega.php";

const baseURLAppContigo =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/EndContigoRecep.php";

const baseURLAppContigoTest =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/EndContigoRecepTest.php";

class NetworkServiceRegistroInicial {
  NetworkServiceRegistroInicial();

  Future<Map<String, dynamic>?> getRegistrosInicialesVictimasFuncionario(
      String id) async {
    var loginObj = new Map<String, dynamic>();

    final query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, dir.`DIRECCION` AS direccion,vics.`sexo` AS sexo, vics.`fk_estadoc` AS estado_civil, vics.`fk_escolaridad` AS escolaridad, vics.`fk_genero` AS genero, dir.`FK_DEPARTAMENTO` AS dept, dir.`FK_MUNICIPIO` AS mun,IFNULL(det.estado,'EV') as estadoR, det.*, vics.ruv, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName\n" +
        "                FROM `vesta_denuncias_registros_new_vi` vic\n" +
        "                LEFT JOIN `terceros_usuarios` vics ON vics.`pk_tercero` = vic.pfk_tercero\n" +
        "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vic.pfk_tercero\n" +
        "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vic.pfk_tercero\n" +
        "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vic.pfk_tercero\n" +
        "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vic.pfk_tercero\n" +
        "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
        "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
        "                WHERE vic.pfk_idFuncionario  = '$id'";

    loginObj['query'] = query;

    try {
      /*
      final response = await post(Uri.parse(baseURL),
          headers: {"Accept": "application/json"}, body: loginObj);*/

      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getVictimasFuncionario(
      String tiposConducta) async {
    var loginObj = new Map<String, dynamic>();

    var perfil = Preferences.perfil;

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var query = "";

    switch (perfil) {
      case "3":
        //Admin
        query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos, IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
            "                FROM `terceros_usuarios` vics\n" +
            "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
            "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
            "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
            "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
            "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
            "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
            "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
            "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
            "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
            "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
            "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
            "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
            "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
            "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
            "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
            "                WHERE vics.app = 'IA' AND vics.tipo_conducta IN$tiposConducta  LIMIT 100";

        if (Preferences.perfilEntidad == "3") {
          //Admin municipal
          /*
          query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos, IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
              "                FROM `terceros_usuarios` vics\n" +
              "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
              "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
              "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
              "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
              "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
              "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
              "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
              "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
              "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
              "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
              "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
              "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
              "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
              "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                WHERE vics.app = 'D' AND vics.tipo_conducta IN$tiposConducta AND dir.`FK_DEPARTAMENTO` = '${Preferences.pkDepartamento}' AND dir.FK_MUNICIPIO = '${Preferences.pkMunicipio}' LIMIT 100";
              */

          query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos, IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
              "                FROM `terceros_usuarios` vics\n" +
              "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
              "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
              "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
              "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
              "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
              "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
              "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
              "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
              "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
              "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
              "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
              "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
              "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
              "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                WHERE vics.app = 'IA' AND dir.`FK_DEPARTAMENTO` = '${Preferences.pkDepartamento}' AND dir.FK_MUNICIPIO = '${Preferences.pkMunicipio}' LIMIT 100";
        } else {
          if (Preferences.perfilEntidad == "1") {
            //Admin Nacional
            query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos, IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
                "                FROM `terceros_usuarios` vics\n" +
                "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
                "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
                "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
                "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
                "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
                "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
                "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
                "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
                "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
                "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
                "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
                "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
                "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
                "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
                "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
                "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
                "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
                "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
                "                WHERE vics.app = 'IA' LIMIT 100";
          } else {
            //Admin departamental
            query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos, IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
                "                FROM `terceros_usuarios` vics\n" +
                "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
                "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
                "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
                "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
                "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
                "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
                "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
                "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
                "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
                "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
                "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
                "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
                "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
                "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
                "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
                "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
                "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
                "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
                "                WHERE vics.app = 'IA' AND dir.`FK_DEPARTAMENTO` = '${Preferences.pkDepartamento}' LIMIT 100";
          }
        }

        break;

      case "5":
        //Funcionario
        query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos, IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
            "                FROM `terceros_usuarios` vics\n" +
            "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
            "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
            "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
            "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
            "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
            "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
            "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
            "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
            "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
            "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
            "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
            "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
            "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
            "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
            "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
            "                WHERE vics.app = 'IA' AND dir.`FK_DEPARTAMENTO` = '${Preferences.pkDepartamento}' AND dir.FK_MUNICIPIO = '${Preferences.pkMunicipio}' LIMIT 100";

        if (Preferences.perfilEntidad == '1') {
          //Funcionario nacional
          query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos, IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
              "                FROM `terceros_usuarios` vics\n" +
              "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
              "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
              "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
              "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
              "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
              "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
              "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
              "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
              "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
              "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
              "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
              "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
              "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
              "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                WHERE vics.app = 'IA' AND vics.tipo_conducta IN$tiposConducta LIMIT 100";
        }

        //Perfil funcionario Regional
        if (Preferences.perfilEntidad == "5") {
          query = "SELECT DISTINCT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos, IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
              "                FROM `terceros_usuarios` vics\n" +
              "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
              "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
              "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
              "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
              "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
              "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
              "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
              "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
              "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
              "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
              "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
              "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
              "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
              "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                WHERE vics.app = 'IA' /*AND mun.`FK_REGIONAL` = '${Preferences.regional}'*/\n" +
              "                ORDER BY vics.fecha_creacion_tercero DESC  LIMIT 100";
        }

        break;
    }

    print(query);

    loginObj['query'] = query;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getVictimasFuncionarioById(
      String idVictima, String tiposConducta) async {
    var loginObj = new Map<String, dynamic>();

    var perfil = Preferences.perfil;

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var query = "";

    switch (perfil) {
      case "3":
        //Perfil Admin nacional
        query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos,IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
            "                FROM `terceros_usuarios` vics\n" +
            "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
            "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
            "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
            "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
            "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
            "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
            "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
            "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
            "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
            "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
            "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
            "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
            "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
            "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
            "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
            "                WHERE vics.app = 'IA' AND vics.pk_tercero = '${idVictima}'";

        if (Preferences.perfilEntidad == "3") {
          //Perfil admin municipal
          query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos,IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
              "                FROM `terceros_usuarios` vics\n" +
              "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
              "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
              "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
              "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
              "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
              "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
              "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
              "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
              "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
              "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
              "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
              "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
              "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
              "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                WHERE vics.app = 'IA' AND dir.`FK_DEPARTAMENTO` = '${Preferences.pkDepartamento}' AND dir.FK_MUNICIPIO = '${Preferences.pkMunicipio}' AND vics.pk_tercero = '${idVictima}'";
        } else {
          //Perfil admin Departamental
          query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos,IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
              "                FROM `terceros_usuarios` vics\n" +
              "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
              "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
              "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
              "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
              "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
              "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
              "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
              "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
              "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
              "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
              "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
              "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
              "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
              "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                WHERE vics.app = 'IA' AND dir.`FK_DEPARTAMENTO` = '${Preferences.pkDepartamento}' AND vics.pk_tercero = '${idVictima}'";
        }

        break;

      case "5":
        //Perfil funcionario
        query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos, IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
            "                FROM `terceros_usuarios` vics\n" +
            "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
            "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
            "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
            "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
            "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
            "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
            "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
            "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
            "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
            "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
            "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
            "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
            "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
            "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
            "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
            "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
            "                WHERE vics.app = 'IA' AND vics.tipo_conducta IN$tiposConducta AND vics.pk_tercero = '${idVictima}'";

        if (Preferences.perfilEntidad == "5") {
          //Funcionario regional
          query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos,IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario, IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
              "                FROM `terceros_usuarios` vics\n" +
              "                LEFT JOIN `vesta_detalles_registro` det ON det.`pfk_tercero` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_direcciones dir ON dir.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = vics.pk_tercero\n" +
              "                LEFT JOIN ter_web_mail mail ON mail.`FK_TERCERO`  = vics.pk_tercero\n" +
              "                LEFT JOIN genp_sexos se ON se.PK_SEXO  = vics.`sexo`\n" +
              "                LEFT JOIN genp_estado_civil es ON es.pk_estado  = vics.`fk_estadoc`\n" +
              "                LEFT JOIN genp_escolaridad escol ON escol.pk_escolaridad  = vics.`fk_escolaridad`\n" +
              "                LEFT JOIN genp_genero gen ON gen.pk_genero  = vics.`fk_genero`\n" +
              "                LEFT JOIN genp_estrato est ON est.pk_estrato  = det.estrato\n" +
              "                LEFT JOIN genp_sisben sis ON sis.pk_sisben  = det.nivel_sisben\n" +
              "                LEFT JOIN genp_etnias et ON et.pk_etnia  = det.etnia\n" +
              "                LEFT JOIN genp_poblacion_victima vict ON vict.pk_poblacion_victima  = det.victima_conflicto\n" +
              "                LEFT JOIN genp_tipo_discapacidad dis ON dis.pk_tipo_discapacidad  = det.discapacidad\n" +
              "                LEFT JOIN genp_capacidades_exepcionales cap ON cap.pk_capacidad_exepcional  = det.capacidad_excepcional\n" +
              "                LEFT JOIN genp_eps eps ON eps.pk_codigo  = det.eps_victima\n" +
              "                LEFT JOIN genp_estatus_migratorio mig ON mig.pk_codigo  = det.estatus_migratorio_victima\n" +
              "                LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO`  = dir.`FK_MUNICIPIO` AND mun.`FK_DEPARTAMENTO`  = dir.`FK_DEPARTAMENTO`\n" +
              "                WHERE vics.app = 'IA' AND mun.`FK_REGIONAL` = '${Preferences.regional}' AND vics.pk_tercero = '${idVictima}' LIMIT 100";
        }

        break;
    }

    loginObj['query'] = query;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getDepartamentos() async {
    var alertasObjt = new Map<String, dynamic>();

    const query = "SELECT * FROM  genp_departamentos WHERE FK_PAIS = '82'";

    alertasObjt['query'] = query;

    try {
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getTipoConducta() async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query =
        "SELECT NIT, NOMBRE, tipos_soluciones_carac  FROM `empresa` em  WHERE NIT = '${Preferences.entidadUsuario}'";

    alertasObjt['query'] = query;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/
      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getBlur(String tipo, String formulario) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var query = "";

    if (tipo == "Entidad") {
      //Blur por Entidad
      query =
          "SELECT per.id, per.entidad  as usuarioOEntidad,per.idCampo, per.valor, c.idCampo as idCampoTexto, c.formulario FROM vesta_campos_permisos_entidad as per INNER JOIN vesta_campos_permisos c on c.id = per.idCampo WHERE per.entidad = '${Preferences.entidadUsuario}' AND c.formulario = '$formulario'";
    } else {
      //Blur por Usuario

      query =
          "SELECT per.id, per.usuario as usuarioOEntidad,per.idCampo, per.valor, c.idCampo as idCampoTexto, c.formulario FROM vesta_campos_permisos_usuario as per INNER JOIN vesta_campos_permisos c on c.id = per.idCampo WHERE per.usuario = '${Preferences.usuario}' AND c.formulario = '$formulario'";
    }

    alertasObjt['query'] = query;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/
      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getTipoConductaEmpresa(
      String tiposConducta) async {
    var alertasObjt = new Map<String, dynamic>();

    final query =
        "SELECT * FROM `vesta_tipo_solucion` WHERE `pk_tipo_solucion` IN$tiposConducta";

    alertasObjt['query'] = query;

    try {
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getMunicipios() async {
    var alertasObjt = new Map<String, dynamic>();

    const query = "SELECT * FROM  genp_municipios";

    alertasObjt['query'] = query;

    try {
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  //Actualizar info
  Future<Map<String, dynamic>?> updateRegistro(String insertDenuncia) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    //alertasObjt['inserts'] = insertDenuncia;
    alertasObjt['query'] = insertDenuncia;

    try {
      /*
      final response = await post(Uri.parse(baseURLInsertTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }
}
