import 'dart:convert';

import 'package:http/http.dart';
import 'package:infancia/domain/network/service_endpoint.dart';
import 'package:infancia/domain/preferences/preferences.dart';
 

const baseURL =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Consulta_General.php";

const baseURLInsert =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Guardar_entrega.php";

const baseURLAppContigo =
    "http://www.bibloplus.com/~biblop/webservice/tokenTest/EndContigoRecep.php";



const baseURLAppContigoTest =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/EndContigoRecepTest.php";

class NetworkServiceContactos {
  Future<Map<String, dynamic>?> getContactos(String tercero) async {
    var loginObj = new Map<String, dynamic>();

    final query =
        "SELECT us.`fk_tercero`,us.`pk_contact`,us.`pais` as pkPais,us.`departamento` as pkDepartamento,us.`municipio` as pkMunicipio, us.`nombre`, us.`telefono`,pa.`NOMBRE` as pais, dep.`NOMBRE` AS departamento, IFNULL(mun.`NOMBRE`, 'No tiene') AS municipio, us.`direccion`, us.`email`, us.`fav`, us.fecha_creacion\n" +
            "FROM `contactos_usuarios` us\n" +
            "LEFT JOIN genp_municipios mun ON mun.`PK_MUNICIPIO` = us.`municipio` AND mun.`FK_DEPARTAMENTO` = us.`departamento`\n" +
            "INNER JOIN genp_departamentos dep ON dep.`PK_DEPARTAMENTO` = us.`departamento`\n" +
            "INNER JOIN genp_pais pa ON pa.`PK_PAIS` = us.`pais`\n" +
            "WHERE us.`fk_tercero` = '${tercero}' ORDER BY fecha_creacion ASC";

    print(query);

    loginObj['query'] = query;

    try {
      final response = await post(Uri.parse(baseURL),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
      //return ;
    }
  }

  Future<Map<String, dynamic>?> updateFav(String insertDenuncia) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    //alertasObjt['inserts'] = insertDenuncia; // Con web service
    alertasObjt['query'] = insertDenuncia; // Con api Defen
    try {
      /*
      final response = await post(Uri.parse(baseURLAppContigoTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: alertasObjt);

      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getPaises() async {
    var alertasObjt = new Map<String, dynamic>();

    final query = "SELECT * FROM  genp_pais ORDER BY NOMBRE ASC";

    alertasObjt['query'] = query;
    try {
      final response = await post(Uri.parse(baseURL),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getEstados(String pais) async {
    var alertasObjt = new Map<String, dynamic>();

    final query =
        "SELECT * FROM  genp_departamentos WHERE FK_PAIS = '$pais' ORDER BY NOMBRE ASC";

    alertasObjt['query'] = query;
    try {
      final response = await post(Uri.parse(baseURL),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getEstadosTodos() async {
    var alertasObjt = new Map<String, dynamic>();

    final query = "SELECT * FROM  genp_departamentos ORDER BY NOMBRE ASC";

    alertasObjt['query'] = query;
    try {
      final response = await post(Uri.parse(baseURL),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getCiudades() async {
    var alertasObjt = new Map<String, dynamic>();

    final query = "SELECT * FROM  genp_municipios ORDER BY NOMBRE ASC";

    alertasObjt['query'] = query;
    try {
      final response = await post(Uri.parse(baseURL),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }
}
