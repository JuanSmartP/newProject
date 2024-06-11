import 'dart:convert';

import 'package:http/http.dart';
import 'package:infancia/domain/network/service_endpoint.dart';
import 'package:infancia/domain/preferences/preferences.dart';
 

 
    

final baseURLTest =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Consulta_General.php";

 

final baseURLAppContigoTest =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/EndContigoRecepTest.php";

final baseURLAppContigoTestGuardarCaso =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/Guardar_Denuncia_Defensoria_Test.php";

class NetworkServiceDenuncias {
  NetworkServiceDenuncias();

  //Login
  Future<Map<String, dynamic>?> getDenuncias(String user) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var queryDenuncias =
        "SELECT den.*,  dept.`NOMBRE` AS nameDepartamento, mun.`NOMBRE` AS nameCiudad\n" +
            "FROM vesta_denuncias den\n" +
            "INNER JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO` = den.`departamento`\n" +
            "INNER JOIN genp_municipios mun ON mun.`FK_DEPARTAMENTO` = den.`departamento` AND mun.`PK_MUNICIPIO` = den.`ciudad`\n" +
            "WHERE den.`usuario` = '$user' AND den.tipo_solucion_carac_den = '1'\n" +
            "GROUP BY conta_denuncias\n" +
            "ORDER BY den.`fecha_denuncia` DESC";

    loginObj['query'] = queryDenuncias;

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
      //return ;
    }
  }

  Future<Map<String, dynamic>?> getDenunciasBuscarFecha(String fechaInicial,
      String fechaFinal, String regional, bool boolFecha) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var queryFecha = "";

    if (boolFecha) {
      //Con rango de fecha
      if (regional == "0") {
        queryFecha =
            "SELECT vest.* , CONCAT_WS(' ', ter.NOMBRE1, ter.NOMBRE2, ter.APELLIDO1, ter.APELLIDO2) AS NombreDupla, reg.descripcion AS Regional, vest.fecha_denuncia,func.role FROM vesta_denuncias vest INNER JOIN vesta_denuncias_registros_new func ON func.pfk_denuncia = vest.conta_denuncias INNER JOIN ter_p_natural ter ON ter.FK_TERCERO = func.pfk_tercero INNER JOIN usu_usuarios us ON us.FK_TERCERO = func.pfk_tercero INNER JOIN genp_regional reg ON reg.pk_regional = us.regional WHERE vest.fecha_denuncia BETWEEN '$fechaInicial' AND '$fechaFinal' AND func.role = 'Registro'";
      } else {
        queryFecha =
            "SELECT vest.* , CONCAT_WS(' ', ter.NOMBRE1, ter.NOMBRE2, ter.APELLIDO1, ter.APELLIDO2) AS NombreDupla, reg.descripcion AS Regional, vest.fecha_denuncia,func.role FROM vesta_denuncias vest INNER JOIN vesta_denuncias_registros_new func ON func.pfk_denuncia = vest.conta_denuncias INNER JOIN ter_p_natural ter ON ter.FK_TERCERO = func.pfk_tercero INNER JOIN usu_usuarios us ON us.FK_TERCERO = func.pfk_tercero INNER JOIN genp_regional reg ON reg.pk_regional = us.regional WHERE vest.fecha_denuncia BETWEEN '$fechaInicial' AND '$fechaFinal' AND func.role = 'Registro' AND us.regional = '$regional'";
      }
    } else {
      //Sin rango de fecha
      var fechArray = fechaInicial.split("-");
      if (regional == "0") {
        queryFecha =
            "SELECT vest.* , CONCAT_WS(' ', ter.NOMBRE1, ter.NOMBRE2, ter.APELLIDO1, ter.APELLIDO2) AS NombreDupla, reg.descripcion AS Regional, vest.fecha_denuncia,func.role FROM vesta_denuncias vest INNER JOIN vesta_denuncias_registros_new func ON func.pfk_denuncia = vest.conta_denuncias INNER JOIN ter_p_natural ter ON ter.FK_TERCERO = func.pfk_tercero INNER JOIN usu_usuarios us ON us.FK_TERCERO = func.pfk_tercero INNER JOIN genp_regional reg ON reg.pk_regional = us.regional WHERE YEAR(vest.fecha_denuncia) = '${fechArray[0]}' AND MONTH(vest.fecha_denuncia) = '${fechArray[1]}' AND DAY(vest.fecha_denuncia) = '${fechArray[2]}' AND func.role = 'Registro'";
      } else {
        queryFecha =
            "SELECT vest.* , CONCAT_WS(' ', ter.NOMBRE1, ter.NOMBRE2, ter.APELLIDO1, ter.APELLIDO2) AS NombreDupla, reg.descripcion AS Regional, vest.fecha_denuncia,func.role FROM vesta_denuncias vest INNER JOIN vesta_denuncias_registros_new func ON func.pfk_denuncia = vest.conta_denuncias INNER JOIN ter_p_natural ter ON ter.FK_TERCERO = func.pfk_tercero INNER JOIN usu_usuarios us ON us.FK_TERCERO = func.pfk_tercero INNER JOIN genp_regional reg ON reg.pk_regional = us.regional WHERE YEAR(vest.fecha_denuncia) = '${fechArray[0]}' AND MONTH(vest.fecha_denuncia) = '${fechArray[1]}' AND DAY(vest.fecha_denuncia) = '${fechArray[2]}' AND func.role = 'Registro' AND us.regional = '$regional'";
      }
    }

    print(queryFecha);

    loginObj['query'] = queryFecha;

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
      //return ;
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

  Future<Map<String, dynamic>?> getFuncionariosUsuarios(String fechaInicial,
      String fechaFinal, String entidad, bool boolFecha) async {
    var loginObj = new Map<String, dynamic>();

    var queryFecha = "";

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    if (boolFecha) {
      //Con rango de fecha

      queryFecha = "SELECT app_ingreso.*, CONCAT_WS(' ', ter.NOMBRE1, ter.NOMBRE2, ter.APELLIDO1, ter.APELLIDO2) AS NombreDupla,reg.descripcion AS Regional\n" +
          "FROM app_ingreso \n" +
          "INNER JOIN usu_usuarios us ON us.PK_USUARIO = app_ingreso.usuario\n" +
          "INNER JOIN ter_p_natural ter ON ter.FK_TERCERO = us.FK_TERCERO\n" +
          "INNER JOIN genp_regional reg ON reg.pk_regional = us.regional  \n" +
          "WHERE us.ENTIDAD = '$entidad' AND app_ingreso.fechaIngreso BETWEEN '$fechaInicial' AND '$fechaFinal' AND us.PK_USUARIO != 'dpc.asa' \n";
    } else {
      //Sin rango de fecha
      var fechArray = fechaInicial.split("-");

      queryFecha = "SELECT app_ingreso.*, CONCAT_WS(' ', ter.NOMBRE1, ter.NOMBRE2, ter.APELLIDO1, ter.APELLIDO2) AS NombreDupla,reg.descripcion AS Regional\n" +
          "FROM app_ingreso \n" +
          "INNER JOIN usu_usuarios us ON us.PK_USUARIO = app_ingreso.usuario\n" +
          "INNER JOIN ter_p_natural ter ON ter.FK_TERCERO = us.FK_TERCERO\n" +
          "INNER JOIN genp_regional reg ON reg.pk_regional = us.regional  \n" +
          "WHERE us.ENTIDAD = '$entidad' AND  YEAR(app_ingreso.fechaIngreso) = '${fechArray[0]}' AND MONTH(app_ingreso.fechaIngreso) = '${fechArray[1]}' AND DAY(app_ingreso.fechaIngreso) = '${fechArray[2]}' AND us.PK_USUARIO != 'dpc.asa' \n";
    }

    print(queryFecha);

    loginObj['query'] = queryFecha;

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
      //return ;
    }
  }

  Future<Map<String, dynamic>?> getDenunciasAmenazas(String user) async {
    var loginObj = new Map<String, dynamic>();

    var queryDenuncias =
        "SELECT den.*, IFNULL(arch.`url`,'No contiene')url,  dept.`NOMBRE` AS nameDepartamento, mun.`NOMBRE` AS nameCiudad\n" +
            "FROM vesta_denuncias den\n" +
            "LEFT JOIN `vesta_denuncias_archivos` arch ON arch.`pfk_conta_denuncias` = den.`conta_denuncias`\n" +
            "INNER JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO` = den.`departamento`\n" +
            "INNER JOIN genp_municipios mun ON mun.`FK_DEPARTAMENTO` = den.`departamento` AND mun.`PK_MUNICIPIO` = den.`ciudad`\n" +
            "WHERE den.`usuario` = '$user' AND den.tipo_solucion_carac_den = '1'\n" +
            "GROUP BY conta_denuncias\n" +
            "ORDER BY den.`fecha_denuncia` DESC";

    loginObj['query'] = queryDenuncias;

    try {
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
      //return ;
    }
  }

  Future<Map<String, dynamic>?> getDenunciasSemaforo() async {
    var loginObj = new Map<String, dynamic>();

    var entidad = Preferences.entidadUsuario;

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var queryDenuncias =
        "SELECT * FROM vesta_denuncia_semaforo WHERE entidad = '$entidad' AND conducta = '1'";

    loginObj['query'] = queryDenuncias;

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
      //return ;
    }
  }

  Future<Map<String, dynamic>?> getDenunciasAmenazasFuncionario(
      String id) async {
    var loginObj = new Map<String, dynamic>();

    final query = "SELECT den.*, IFNULL(arch.`url`,'No tiene') url, IFNULL(fun.`pfk_denunciante`, 'No asignado') AS victima, IFNULL(CONCAT_WS(' ',t.`nombres`, t.`apellidos`), 'No asignado' )  AS Nombre_victima, den.`latitud`,den.`longitud`, dept.`NOMBRE` AS nameDepartamento, mun.`NOMBRE` AS nameCiudad\n" +
        "                                         FROM vesta_denuncias den\n" +
        "                                         LEFT JOIN `vesta_denuncias_archivos` arch ON arch.`pfk_conta_denuncias` = den.`conta_denuncias`\n" +
        // "                                         LEFT JOIN `vesta_clase_amenaza` ame ON ame.`id_clase_amenaza` = den.`clase_amenaza`\n" +
        // "                                         LEFT JOIN  `vesta_asignacion_ruta_atencion` asigr ON asigr.`pfk_alerta` = den.`conta_denuncias`\n" +
        "                                         INNER JOIN `vesta_denuncias_registros_new` fun ON fun.`pfk_denuncia` = den.`conta_denuncias`\n" +
        "                                         LEFT  JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO` = den.`departamento`\n" +
        "                                         LEFT JOIN genp_municipios mun ON mun.`FK_DEPARTAMENTO` = den.`departamento` AND mun.`PK_MUNICIPIO` = den.`ciudad`\n" +
        "                                         LEFT JOIN `terceros_usuarios` t ON t.`pk_tercero` = fun.`pfk_denunciante`\n" +
        "                                         WHERE fun.`pfk_tercero` = '$id' AND den.tipo_solucion_carac_den = '3'\n" +
        "                                         GROUP BY conta_denuncias\n" +
        "                                         ORDER BY den.`fecha_denuncia` DESC";

    loginObj['query'] = query;

    try {
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
      //return ;
    }
  }

  //Get bloqueo de personas y sesión
  Future<Map<String, dynamic>?> getBloqueo() async {
    var loginObj = new Map<String, dynamic>();

    final query = "SELECT `entidad`, `bloqueo`, `logout` FROM `app_sesion`";

    loginObj['query'] = query;

    try {
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
      //return ;
    }
  }

  Future<Map<String, dynamic>?> getDenunciasAmenazasFuncionarioEquidadGenero(
      String id) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query = "SELECT den.*, IFNULL(fun.`pfk_denunciante`, 'No asignado') AS victima, IFNULL(CONCAT_WS(' ',t.`nombres`, t.`apellidos`), 'No asignado' )  AS Nombre_victima, den.`latitud`,den.`longitud`, dept.`NOMBRE` AS nameDepartamento, mun.`NOMBRE` AS nameCiudad\n" +
        "                                         FROM vesta_denuncias den\n" +
        // "                                         LEFT JOIN `vesta_clase_amenaza` ame ON ame.`id_clase_amenaza` = den.`clase_amenaza`\n" +
        // "                                         LEFT JOIN  `vesta_asignacion_ruta_atencion` asigr ON asigr.`pfk_alerta` = den.`conta_denuncias`\n" +
        "                                         INNER JOIN `vesta_denuncias_registros_new` fun ON fun.`pfk_denuncia` = den.`conta_denuncias`\n" +
        "                                         LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO` = den.`departamento`\n" +
        "                                         LEFT JOIN genp_municipios mun ON mun.`FK_DEPARTAMENTO` = den.`departamento` AND mun.`PK_MUNICIPIO` = den.`ciudad`\n" +
        "                                         LEFT JOIN `terceros_usuarios` t ON t.`pk_tercero` = fun.`pfk_denunciante`\n" +
        "                                         WHERE fun.`pfk_tercero` = '$id' AND den.tipo_solucion_carac_den = '1'\n" +
        "                                         GROUP BY conta_denuncias\n" +
        "                                         ORDER BY den.`fecha_denuncia` DESC";

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
      //return ;
    }
  }

  Future<Map<String, dynamic>?> getDenunciasEquidadGeneroAdminByName(
      String name) async {
    var loginObj = new Map<String, dynamic>();

    var query = "";
    var perfil = Preferences.perfil;

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    switch (perfil) {
      case "3":
        query = "SELECT den.*, IFNULL(fun.`pfk_denunciante`, 'No asignado') AS victima, IFNULL(CONCAT_WS(' ',t.`nombres`, t.`apellidos`), 'No asignado' )  AS Nombre_victima, den.`latitud`,den.`longitud`, dept.`NOMBRE` AS nameDepartamento, mun.`NOMBRE` AS nameCiudad\n" +
            "                                         FROM vesta_denuncias den\n" +
            //  "                                         LEFT JOIN `vesta_clase_amenaza` ame ON ame.`id_clase_amenaza` = den.`clase_amenaza`\n" +
            //  "                                         LEFT JOIN  `vesta_asignacion_ruta_atencion` asigr ON asigr.`pfk_alerta` = den.`conta_denuncias`\n" +
            "                                         INNER JOIN `vesta_denuncias_registros_new` fun ON fun.`pfk_denuncia` = den.`conta_denuncias`\n" +
            "                                         LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO` = den.`departamento`\n" +
            "                                         LEFT JOIN genp_municipios mun ON mun.`FK_DEPARTAMENTO` = den.`departamento` AND mun.`PK_MUNICIPIO` = den.`ciudad`\n" +
            "                                         LEFT JOIN `terceros_usuarios` t ON t.`pk_tercero` = fun.`pfk_denunciante`\n" +
            "                                         WHERE den.nombres LIKE '%$name%' or den.apellidos LIKE '%$name%' or CONCAT_WS(' ', den.nombres, den.apellidos) LIKE '%$name%'\n" +
            "                                         GROUP BY conta_denuncias\n" +
            "                                         ORDER BY den.`fecha_denuncia` DESC";
        break;

      case "5":
        query = "SELECT den.*, IFNULL(fun.`pfk_denunciante`, 'No asignado') AS victima, IFNULL(CONCAT_WS(' ',t.`nombres`, t.`apellidos`), 'No asignado' )  AS Nombre_victima, den.`latitud`,den.`longitud`, dept.`NOMBRE` AS nameDepartamento, mun.`NOMBRE` AS nameCiudad\n" +
            "                                         FROM vesta_denuncias den\n" +
            // "                                         LEFT JOIN `vesta_clase_amenaza` ame ON ame.`id_clase_amenaza` = den.`clase_amenaza`\n" +
            // "                                         LEFT JOIN  `vesta_asignacion_ruta_atencion` asigr ON asigr.`pfk_alerta` = den.`conta_denuncias`\n" +
            "                                         INNER JOIN `vesta_denuncias_registros_new` fun ON fun.`pfk_denuncia` = den.`conta_denuncias`\n" +
            "                                         LEFT JOIN genp_departamentos dept ON dept.`PK_DEPARTAMENTO` = den.`departamento`\n" +
            "                                         LEFT JOIN genp_municipios mun ON mun.`FK_DEPARTAMENTO` = den.`departamento` AND mun.`PK_MUNICIPIO` = den.`ciudad`\n" +
            "                                         LEFT JOIN `terceros_usuarios` t ON t.`pk_tercero` = fun.`pfk_denunciante`\n" +
            "                                         WHERE fun.`pfk_tercero` = '${Preferences.id}' AND den.tipo_solucion_carac_den = '1' AND (den.nombres LIKE '%$name%' or den.apellidos LIKE '%$name%' or CONCAT_WS(' ', den.nombres, den.apellidos) LIKE '%$name%')\n" +
            "                                         GROUP BY conta_denuncias\n" +
            "                                         ORDER BY den.`fecha_denuncia` DESC";
    }

    loginObj['query'] = query;

    //print(query);

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
      //return ;
    }
  }

  Future<Map<String, dynamic>?> getMunicipios() async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var query = "";

    if (Preferences.getPkPais.isEmpty) {
      query =
          "SELECT * FROM  genp_municipios WHERE FK_PAIS = '82' AND FK_REGIONAL IS NOT NULL ORDER BY NOMBRE ASC";
    } else {
      query =
          "SELECT * FROM  genp_municipios WHERE FK_PAIS = '${Preferences.getPkPais}' AND FK_REGIONAL IS NOT NULL ORDER BY NOMBRE ASC";
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

  Future<Map<String, dynamic>?> getDuplasRegionales(String regional) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query =
        "SELECT FK_TERCERO, PK_USUARIO FROM `usu_usuarios` WHERE regional = '$regional' AND FK_TERCERO NOT IN ('${Preferences.id}')";

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

  Future<Map<String, dynamic>?> getMunicipiosRegional() async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query =
        "SELECT * FROM  genp_municipios WHERE FK_REGIONAL = '${Preferences.regional}' ORDER BY NOMBRE ASC";

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

  Future<Map<String, dynamic>?> sendEmail(String correo) async {
    var alertasObjt = new Map<String, dynamic>();

    alertasObjt['mail'] = "ricardolpr25@gmail.com";
    //alertasObjt['mail'] = "ricardo_prado25@hotmail.com";

    try {
      final response = await post(Uri.parse(baseURLTestCorreo),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> sendEmailVictima(
      String correo, String asunto, String mensaje) async {
    var alertasObjt = new Map<String, dynamic>();

    //alertasObjt['mail'] = "ricardolpr25@gmail.com";
    alertasObjt['mail'] = correo;
    alertasObjt['asunto'] = asunto;
    alertasObjt['mensaje'] = mensaje;

    //alertasObjt['mail'] = "ricardo_prado25@hotmail.com";

    try {
      final response = await post(Uri.parse(baseURLTestCorreo),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getMunicipiosDepartamento(
      String departamento) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query =
        "SELECT * FROM  genp_municipios WHERE FK_DEPARTAMENTO = '$departamento' ORDER BY NOMBRE ASC";

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

  Future<Map<String, dynamic>?> getEstadosColombia() async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var query = "";

    if (Preferences.getPkPais.isEmpty) {
      //Afuera
      query =
          "SELECT * FROM  genp_departamentos WHERE FK_PAIS = '82' ORDER BY NOMBRE ASC";
    } else {
      //Adentro
      query =
          "SELECT * FROM  genp_departamentos WHERE FK_PAIS = '${Preferences.getPkPais}' ORDER BY NOMBRE ASC";
    }

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

  Future<Map<String, dynamic>?> getCorreosRuta(
      String idTipoConducta, String dept, String mun) async {
    var alertasObjt = new Map<String, dynamic>();

    final queryRuta =
        "SELECT ruta.`consecutivo`, ruta.`descripcion`, rsed.`pfk_red_apoyo`, rsed.`pfk_sede`, sed.`NOMBRE_SEDE`, sed.`EMAIL` , per.valor\n" +
            "FROM `vesta_ruta_atention` ruta\n" +
            "INNER JOIN `vesta_ruta_atention_sedes` rsed ON rsed.`pfk_consecutivo` = ruta.`consecutivo`\n" +
            "INNER JOIN `vesta_sedes_apoyo` sed ON sed.`PK_REDAPOYO` = rsed.`pfk_red_apoyo` AND sed.`PK_SEDE` = rsed.`pfk_sede`\n" +
            "INNER JOIN permisos_app per\n" +
            "WHERE ruta.`tipo_conducta` = '$idTipoConducta' AND ruta.`pfk_departamento` = '$dept' AND ruta.`pfk_municipio` = '$mun' AND per.nombre_permiso = 'ruta_envio'";

    alertasObjt['query'] = queryRuta;
    try {
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> insertDenuncia(String insertDenuncia) async {
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

  //GUARDAR DENUNCIA DEFENSORIA
  Future<Map<String, dynamic>?> guardarDenunciaPreguntas(
      String respuestasInfo,
      String respuestasViolencia,
      String respuestaOtras,
      String respuestaTrata,
      String respuestaVulneracion,
      String respuestaGestion,
      String insertInfoProteccion,
      String insertInfoRecepcion,
      String insertInfoAgresor,
      String insertInfoVariables,
      String insertInfoTerapia) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Insert", "Caso");

    alertasObjt['info'] = respuestasInfo;
    alertasObjt['violencia'] = respuestasViolencia;
    alertasObjt['otras'] = respuestaOtras;
    alertasObjt['trata'] = respuestaTrata;
    alertasObjt['vulneracion'] = respuestaVulneracion;
    alertasObjt['gestion'] = respuestaGestion;
    alertasObjt['protec'] = insertInfoProteccion;
    alertasObjt['recepcion'] = insertInfoRecepcion;
    alertasObjt['agresor'] = insertInfoAgresor;
    alertasObjt['variables'] = insertInfoVariables;
    alertasObjt['terapia'] = insertInfoTerapia;

    try {
      /*
      final response = await post(
          Uri.parse(baseDeDatosVestaGuardarDenunciaPreguntas),
          headers: {"Accept": "application/json"},
          body: alertasObjt);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: alertasObjt);

      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }
}
