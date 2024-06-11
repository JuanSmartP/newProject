import 'dart:convert';
import 'package:http/http.dart';
import 'package:infancia/domain/network/service_endpoint.dart';
import 'package:infancia/domain/preferences/preferences.dart';

const baseURLTest =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Consulta_General.php";

const baseDeDatosVestaGuardarCanalAtencion =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Guardar_Canal_Atencion.php";

const baseURLAppContigoTestCanal =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/Guardar_Canal_Atencion_Test.php";



class CanalService {
  Future<Map<String, dynamic>?> guardarCanalAtencion(String dataQuery) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Insert", "Canal");

    loginObj['cAtencionCanal!'] = dataQuery;

    try {
      /*
      final response = await post(Uri.parse(baseURL),
          headers: {"Accept": "application/json"}, body: loginObj);*/

/*
      final response = await post(
          Uri.parse(baseDeDatosVestaGuardarCanalAtencion),
          headers: {"Accept": "application/json"},xs
          body: loginObj);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getEntidades() async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query = "SELECT NIT,NOMBRE FROM `empresa`";

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

  Future<Map<String, dynamic>?> getCanalesMain(String regional) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query =
        "SELECT c.*,dep.NOMBRE as Departamento, mun.NOMBRE as Municipio   FROM `vesta_canal_atencion` c \n" +
            "INNER JOIN genp_municipios mun ON mun.PK_MUNICIPIO = c.pfk_municipio AND mun.FK_DEPARTAMENTO = c.pfk_departamento \n" +
            "INNER JOIN genp_departamentos dep ON dep.PK_DEPARTAMENTO = mun.FK_DEPARTAMENTO\n" +
            "WHERE /*mun.FK_REGIONAL = '$regional' and*/ c.tipoConducta='9'\n" +
            "ORDER BY c.fecha_registro DESC";

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

  Future<Map<String, dynamic>?> getCanalesMainTodos(String regional) async {
    var loginObj = <String, dynamic>{};

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    const query =
        "SELECT c.*,dep.NOMBRE as Departamento, mun.NOMBRE as Municipio   FROM `vesta_canal_atencion` c \n" +
            "INNER JOIN genp_municipios mun ON mun.PK_MUNICIPIO = c.pfk_municipio AND mun.FK_DEPARTAMENTO = c.pfk_departamento \n" +
            "INNER JOIN genp_departamentos dep ON dep.PK_DEPARTAMENTO = mun.FK_DEPARTAMENTO\n" +
            "ORDER BY c.fecha_registro DESC LIMIT 100";

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

  Future<Map<String, dynamic>?> getCanalesMainTodosPorFecha(String regional,
      String fechaInicial, String fechaFinal, bool rangoFecha) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var query = "";

    if (rangoFecha) {
      if (regional == "No tiene") {
        query = "SELECT c.*,dep.NOMBRE as Departamento, mun.NOMBRE as Municipio   FROM `vesta_canal_atencion` c \n" +
            "INNER JOIN genp_municipios mun ON mun.PK_MUNICIPIO = c.pfk_municipio AND mun.FK_DEPARTAMENTO = c.pfk_departamento \n" +
            "INNER JOIN genp_departamentos dep ON dep.PK_DEPARTAMENTO = mun.FK_DEPARTAMENTO\n" +
            "WHERE fecha_registro BETWEEN '$fechaInicial' AND '$fechaFinal'\n" +
            "ORDER BY c.fecha_registro DESC LIMIT 100";
      } else {
        query = "SELECT c.*,dep.NOMBRE as Departamento, mun.NOMBRE as Municipio   FROM `vesta_canal_atencion` c \n" +
            "INNER JOIN genp_municipios mun ON mun.PK_MUNICIPIO = c.pfk_municipio AND mun.FK_DEPARTAMENTO = c.pfk_departamento \n" +
            "INNER JOIN genp_departamentos dep ON dep.PK_DEPARTAMENTO = mun.FK_DEPARTAMENTO\n" +
            "WHERE mun.FK_REGIONAL = '${regional}' AND fecha_registro BETWEEN '$fechaInicial' AND '$fechaFinal'\n" +
            "ORDER BY c.fecha_registro DESC LIMIT 100";
      }
    } else {
      var fechArray = fechaInicial.split("-");
      if (regional == "No tiene") {
        query = "SELECT c.*,dep.NOMBRE as Departamento, mun.NOMBRE as Municipio   FROM `vesta_canal_atencion` c \n" +
            "INNER JOIN genp_municipios mun ON mun.PK_MUNICIPIO = c.pfk_municipio AND mun.FK_DEPARTAMENTO = c.pfk_departamento \n" +
            "INNER JOIN genp_departamentos dep ON dep.PK_DEPARTAMENTO = mun.FK_DEPARTAMENTO\n" +
            "WHERE YEAR(c.fecha_registro) = '${fechArray[0]}' AND MONTH(c.fecha_registro) = '${fechArray[1]}' AND DAY(c.fecha_registro) = '${fechArray[2]}'\n" +
            "ORDER BY c.fecha_registro DESC LIMIT 100";
      } else {
        query = "SELECT c.*,dep.NOMBRE as Departamento, mun.NOMBRE as Municipio   FROM `vesta_canal_atencion` c \n" +
            "INNER JOIN genp_municipios mun ON mun.PK_MUNICIPIO = c.pfk_municipio AND mun.FK_DEPARTAMENTO = c.pfk_departamento \n" +
            "INNER JOIN genp_departamentos dep ON dep.PK_DEPARTAMENTO = mun.FK_DEPARTAMENTO\n" +
            "WHERE mun.FK_REGIONAL = '${regional}' AND YEAR(c.fecha_registro) = '${fechArray[0]}' AND MONTH(c.fecha_registro) = '${fechArray[1]}' AND DAY(c.fecha_registro) = '${fechArray[2]}'\n" +
            "ORDER BY c.fecha_registro DESC LIMIT 100";
      }
    }

    loginObj['query'] = query;
    print(query);

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
}
