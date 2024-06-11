import 'dart:convert';

import 'package:http/http.dart';
import 'package:infancia/domain/network/service_endpoint.dart';
import 'package:infancia/domain/preferences/preferences.dart';

final baseURLTest =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Consulta_General.php";

final baseURLInsertTest =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Guardar_entrega.php";

final baseURLAppContigo =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/EndContigoRecep.php";

final baseUrlAppContigoTest =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/EndContigoRecepTest.php";

class NetworkServiceRegistro {
  NetworkServiceRegistro();

  Future<Map<String, dynamic>?> getPaises() async {
    var alertasObjt = new Map<String, dynamic>();

    final query = "SELECT * FROM  genp_pais ORDER BY NOMBRE ASC";

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

  Future<Map<String, dynamic>?> getEstadosTodos() async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query =
        "SELECT * FROM  genp_departamentos WHERE FK_PAIS = '${Preferences.getPkPais}' ORDER BY NOMBRE ASC";

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

  Future<Map<String, dynamic>?> getCiudades() async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query =
        "SELECT * FROM  genp_municipios WHERE FK_PAIS = '${Preferences.getPkPais}' AND FK_REGIONAL IS NOT NULL ORDER BY NOMBRE ASC";

    alertasObjt['query'] = query;
    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getMunicipios() async {
    var alertasObjt = new Map<String, dynamic>();

    final query =
        "SELECT * FROM  genp_municipios WHERE FK_REGIONAL IS NOT NULL AND FK_PAIS = '${Preferences.getPkPais}'";

    alertasObjt['query'] = query;

    try {
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      //print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getEstados(String pais) async {
    var alertasObjt = new Map<String, dynamic>();

    final query = "SELECT * FROM  genp_departamentos WHERE FK_PAIS = '$pais'";

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

  Future<Map<String, dynamic>?> verifyUser(String id) async {
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
      final response = await post(Uri.parse(url),
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

  Future<Map<String, dynamic>?> getEstadosColombia() async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query =
        "SELECT * FROM  genp_departamentos WHERE FK_PAIS = '${Preferences.getPkPais}'";

    alertasObjt['query'] = query;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/

      final response = await post(Uri.parse(baseUrlAppContigoTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }
}
