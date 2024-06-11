import 'dart:convert';

import 'package:http/http.dart';
import 'package:infancia/domain/network/service_endpoint.dart';
import 'package:infancia/domain/preferences/preferences.dart';
// import 'package:vesta_flutter/network/service_endpoint.dart';
// import 'package:vesta_flutter/pages/Beneficios/beneficios_main.dart';
// import 'package:vesta_flutter/preferences.dart';

 

const urlTest =
    'https://www.bibloplus.com/~biblop/webservice/tokenTest/EndContigoRecepTest.php';

class VerificarIDService {
  Future<Map<String, dynamic>?> getUserExist(String id) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query = "SELECT 1 FROM terceros_usuarios WHERE pk_tercero = '$id'";

    alertasObjt['query'] = query;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/

      final response = await post(Uri.parse(urlTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);

      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getUserInfoByID(String id) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

/*
    final query = "SELECT DISTINCT us.`PK_USUARIO`, IFNULL(us.`ENTIDAD`, 'No registra') as entidadUsuario, us.`CONTRASENIA`,us.`FK_PERFIL`, us.`FK_TERCERO`,us.`ACTIVO` ,IFNULL(u.`nombres`,ter.`NOMBRE1`) AS nombres ,IFNULL(web.`WEB_O_MAIL`,\"No tiene\") AS correo  ,IFNULL(u.`apellidos`,ter.`APELLIDO1`) AS apellidos , IFNULL(t.`FK_DEPARTAMENTO`, emp.pfk_departamento) as FK_DEPARTAMENTO,IFNULL(t.`FK_MUNICIPIO`,emp.pfk_municipio) as FK_MUNICIPIO ,IFNULL(t.`FK_PAIS`, emp.pfk_pais) as FK_PAIS, u.`fecha_nacimiento`,IFNULL( tel.`NUMERO`, emp.TELEFONO) as NUMERO, IFNULL(t.`DIRECCION`, emp.DIRECCION) as DIRECCION, dept.`NOMBRE` AS dept_nombre, mun.`NOMBRE` AS  mun_nombre, IFNULL(us.`token_notifi`,'') AS token, IFNULL(func.`pfk_tercero`,'No asignado') AS funcionario, IFNULL(noti.`pfk_entidad`,'No asignado') AS envia_nofiticacion, IFNULL(noti.`pfk_noti_a`,'No asignado') AS tipo_envio, IFNULL(emp.`noti_general_alerta`, 'No asignado') AS noti_alerta, IFNULL(noti.`tipo_alerta`,'No asignado') AS alertas, IFNULL(u.`tipo_conducta`,'No asignado') AS conducta, IFNULL(u.`pfk_entidad_emite`,'No asignado') as entidad_escogida, IFNULL(us.`foto`,'No tiene') as foto, IFNULL(emp.`NOMBRE`,'No tiene') as empresaName, IFNULL(emp.`LOGO`,'No tiene') as logo, IFNULL(us.`perfil_entidad`,'No tiene') as perfil_entidad, IFNULL(us.`regional`,'No tiene') as regional  \n" +
        "                                                                                                    FROM usu_usuarios us\n" +
        "                                                                                                    LEFT JOIN ter_direcciones t ON t.`FK_TERCERO` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN `ter_web_mail` web ON web.`FK_TERCERO` = us.`FK_TERCERO` \n" +
        "                                                                                                    INNER JOIN terceros_usuarios u ON u.`pk_tercero` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN ter_p_natural ter ON ter.`FK_TERCERO` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN `vesta_denuncias_registros_new` func ON func.`pfk_denunciante` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN `vesta_tabla_notificaciones_entidad` noti ON noti.`id_ter_noti` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN  empresa emp ON emp.`NIT` = us.`ENTIDAD`\n" +
        "                                                                                                    LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO` = t.`FK_DEPARTAMENTO` OR dept.`PK_DEPARTAMENTO` = emp.pfk_departamento\n" +
        "                                                                                                    LEFT JOIN genp_municipios mun ON mun.`FK_DEPARTAMENTO` = t.`FK_DEPARTAMENTO` AND mun.`PK_MUNICIPIO` = t.`FK_MUNICIPIO`  OR mun.`FK_DEPARTAMENTO` = emp.pfk_departamento AND mun.`PK_MUNICIPIO` = emp.pfk_municipio\n" +
        "                                                                                                    WHERE us.FK_TERCERO = '$id'";*/

    final query = "SELECT vics.`pk_tercero`,vics.`nombres` AS nombres, vics.`apellidos` AS apellidos,IFNULL(vics.`nombreIdentitario`,'')  AS nombreIdentitario ,IFNULL(tel.`NUMERO`,'No tiene')  AS numero, vics.`fecha_nacimiento` AS fecha_nacimiento, IFNULL(mail.`WEB_O_MAIL`,'No registra') AS mail, IFNULL(dir.`DIRECCION`,'No registra') direccion,IFNULL(vics.`sexo`,'No asignado') AS sexo, se.NOMBRE as sexoName, IFNULL(vics.`fk_estadoc`,'No asignado') AS estado_civil, es.nombre as estadocName,  IFNULL(vics.`fk_escolaridad`,'No asignado') AS escolaridad,escol.nombre as escolaridadName,  IFNULL(vics.`fk_genero`,'No asignado') AS genero, sis.sisben as sisbenName, gen.nombre as generoName,et.etnia as etniaName, vict.poblacion_victima as victimaName,  dis.tipo_discapacidad as discapacidadName ,cap.capacidad_exepcional as capacidadName ,IFNULL(dir.`FK_DEPARTAMENTO`,'No registra') dept, det.*,IFNULL(dir.`FK_MUNICIPIO`,'No registra') AS mun,IFNULL(det.estado,'EV') as estadoR, est.estrato as estratoName, dept.NOMBRE AS deptName, IFNULL(mun.NOMBRE,'No registra') AS munName, eps.nombre_eps as epsName, mig.nombre as estatusName, vics.ruv, IFNULL(vics.victimaTF,'No') victimaTF \n" +
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
        "                WHERE vics.app IN('IA') AND vics.pk_tercero = '${id}'";

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
}
