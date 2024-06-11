import 'dart:convert';

import 'package:http/http.dart';
import 'package:infancia/domain/network/service_endpoint.dart';


 



class NetworkService {
  NetworkService();

  //Login
  Future<Map<String, dynamic>?> getLoginData(String user) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();


    //PENSAR UNA FORMA DE INCLUIR LA ENTIDAD CUANDO ES INTERNACIONAL
    var url = await endpoint.getEndPoint("8001860611", "Select", "Consulta");

    /*

    final query = "SELECT DISTINCT us.`PK_USUARIO`, us.`CONTRASENIA`,us.`FK_PERFIL`, us.`FK_TERCERO`, us.`ACTIVO` ,IFNULL(u.`nombres`,ter.`NOMBRE1`) AS nombres ,IFNULL(web.`WEB_O_MAIL`,\"No tiene\") AS correo  ,IFNULL(u.`apellidos`,ter.`APELLIDO1`) AS apellidos , t.`FK_DEPARTAMENTO`,t.`FK_MUNICIPIO`,t.`FK_PAIS`, u.`fecha_nacimiento`, tel.`NUMERO`, t.`DIRECCION`, dept.`NOMBRE` AS dept_nombre, mun.`NOMBRE` AS  mun_nombre, IFNULL(us.`token_notifi`,'') AS token, IFNULL(func.`pfk_tercero`,'No asignado') AS funcionario, IFNULL(noti.`pfk_entidad`,'No asignado') AS envia_nofiticacion, IFNULL(noti.`pfk_noti_a`,'No asignado') AS tipo_envio, IFNULL(emp.`noti_general_alerta`, 'No asignado') AS noti_alerta, IFNULL(noti.`tipo_alerta`,'No asignado') AS alertas, IFNULL(u.`tipo_conducta`,'No asignado') AS conducta, IFNULL(u.`pfk_entidad_emite`,'No asignado') as entidad_escogida, IFNULL(us.`foto`,'No tiene') as foto  \n" +
        "                                                                                                    FROM usu_usuarios us\n" +
        "                                                                                                    INNER JOIN ter_direcciones t ON t.`FK_TERCERO` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN `ter_web_mail` web ON web.`FK_TERCERO` = us.`FK_TERCERO` \n" +
        "                                                                                                    LEFT JOIN terceros_usuarios u ON u.`pk_tercero` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN ter_p_natural ter ON ter.`FK_TERCERO` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN `vesta_denuncias_registros_new` func ON func.`pfk_denunciante` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN `vesta_tabla_notificaciones_entidad` noti ON noti.`id_ter_noti` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN  empresa emp ON emp.`NIT` = us.`ENTIDAD`\n" +
        "                                                                                                    INNER JOIN ter_telefonos tel ON tel.`FK_TERCERO` = us.`FK_TERCERO`\n" +
        "                                                                                                    INNER JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO` = t.`FK_DEPARTAMENTO`\n" +
        "                                                                                                    INNER JOIN genp_municipios mun ON mun.`FK_DEPARTAMENTO` = t.`FK_DEPARTAMENTO` AND mun.`PK_MUNICIPIO` = t.`FK_MUNICIPIO`\n" +
        "                                                                                                    WHERE us.PK_USUARIO = '$user' AND tel.`TIPO` = 'C'";
*/

    final query = "SELECT DISTINCT us.`PK_USUARIO`, IFNULL(us.`ENTIDAD`, 'No registra') as entidadUsuario, us.`CONTRASENIA`,us.`FK_PERFIL`, us.`FK_TERCERO`,us.`ACTIVO` ,IFNULL(u.`nombres`,ter.`NOMBRE1`) AS nombres ,IFNULL(web.`WEB_O_MAIL`,\"No tiene\") AS correo  ,IFNULL(u.`apellidos`,ter.`APELLIDO1`) AS apellidos , IFNULL(t.`FK_DEPARTAMENTO`, emp.pfk_departamento) as FK_DEPARTAMENTO,IFNULL(t.`FK_MUNICIPIO`,emp.pfk_municipio) as FK_MUNICIPIO ,IFNULL(t.`FK_PAIS`, emp.pfk_pais) as FK_PAIS, u.`fecha_nacimiento`,IFNULL( tel.`NUMERO`, emp.TELEFONO) as NUMERO, IFNULL(t.`DIRECCION`, emp.DIRECCION) as DIRECCION, dept.`NOMBRE` AS dept_nombre, mun.`NOMBRE` AS  mun_nombre, IFNULL(us.`token_notifi`,'') AS token, IFNULL(func.`pfk_tercero`,'No asignado') AS funcionario, IFNULL(emp.`noti_general_alerta`, 'No asignado') AS noti_alerta, IFNULL(u.`tipo_conducta`,'No asignado') AS conducta, IFNULL(u.`pfk_entidad_emite`,'No asignado') as entidad_escogida, IFNULL(us.`foto`,'No tiene') as foto, IFNULL(emp.`NOMBRE`,'No tiene') as empresaName, IFNULL(emp.`LOGO`,'No tiene') as logo, IFNULL(us.`perfil_entidad`,'No tiene') as perfil_entidad, IFNULL(us.`regional`,'No tiene') as regional, IFNULL(reg.`descripcion`,'No tiene') nameRegional, IFNULL(col.`panel_menu`, '#FF2B66') colorEntidad, IFNULL(us.`tipo_alerta`,'No asignado') AS conducta\n" +
        "                                                                                                    FROM usu_usuarios us\n" +
        "                                                                                                    LEFT JOIN ter_direcciones t ON t.`FK_TERCERO` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN `ter_web_mail` web ON web.`FK_TERCERO` = us.`FK_TERCERO` \n" +
        "                                                                                                    LEFT JOIN terceros_usuarios u ON u.`pk_tercero` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN ter_p_natural ter ON ter.`FK_TERCERO` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN `vesta_denuncias_registros_new` func ON func.`pfk_denunciante` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN  empresa emp ON emp.`NIT` = us.`ENTIDAD`\n" +
        "                                                                                                    LEFT JOIN ter_telefonos tel ON tel.`FK_TERCERO` = us.`FK_TERCERO`\n" +
        "                                                                                                    LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO` = t.`FK_DEPARTAMENTO` OR dept.`PK_DEPARTAMENTO` = emp.pfk_departamento\n" +
        "                                                                                                    LEFT JOIN genp_municipios mun ON mun.`FK_DEPARTAMENTO` = t.`FK_DEPARTAMENTO` AND mun.`PK_MUNICIPIO` = t.`FK_MUNICIPIO`  OR mun.`FK_DEPARTAMENTO` = emp.pfk_departamento AND mun.`PK_MUNICIPIO` = emp.pfk_municipio\n" +
        "                                                                                                    LEFT JOIN genp_regional reg ON reg.`pk_regional` = us.`regional`\n" +
        "                                                                                                    LEFT JOIN vesta_colores_entidad col ON col.`PK_REDAPOYO` = us.`ENTIDAD`\n" +
        "                                                                                                    WHERE us.PK_USUARIO = '$user'AND us.tipo_alerta='9'" ;

    loginObj['query'] = query;
    print(query);

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      if (response.body.contains("Access denied for user")) {
        Map<String, dynamic> miMapa = {};

        // Añadir elementos al Map
        miMapa['response'] = 'No acceso';
        return miMapa;
      }

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
      //return ;
    }
  }

  Future<Map<String, dynamic>?> userExist(String user) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint("8001860611", "Select", "Consulta");

    final query = "SELECT us.*, mail.`WEB_O_MAIL` AS correo\n" +
        "FROM usu_usuarios us\n" +
        "INNER JOIN ter_web_mail mail ON mail.`FK_TERCERO` = us.`FK_TERCERO`\n" +
        "WHERE us.`PK_USUARIO` = '$user'";

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

  Future<Map<String, dynamic>?> updatePass(String update) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint("8001860611", "Select", "Consulta");

    //alertasObjt['inserts'] = update;
    alertasObjt['query'] = update;
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
