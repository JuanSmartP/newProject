import 'dart:convert';

import 'package:http/http.dart';
import 'package:infancia/domain/network/service_endpoint.dart';
import 'package:infancia/domain/network/verificarID_service.dart';
import 'package:infancia/domain/preferences/preferences.dart';
 

 

class NetworkServiceEntrevistas {
  NetworkServiceEntrevistas();

  Future<Map<String, dynamic>?> getPreguntasGeneral(
      String grupoPregunta) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

/*
    var queryPreguntas =
        "SELECT *,preg.idGrupoPregunta grupoPregunta from vesta_entrevista_pregunta preg LEFT JOIN vesta_entrevista_pregunta_opcion op ON op.idPregunta = preg.idpregunta and op.idTipoPregunta = preg.tipopregunta and op.idGrupoPregunta = preg.idGrupoPregunta WHERE preg.idGrupoPregunta = '$grupoPregunta' ORDER BY preg.idPregunta, op.idOpcion";
*/

    var queryPreguntas =
        "SELECT preg.*,op.* ,preg.idGrupoPregunta grupoPregunta, IFNULL(her.idPreguntaOpcion, 'No registra' ) as pregunta_hereda, her.idHerencia,her.herenciaOpcion,her.idGrupoHerencia  from vesta_entrevista_pregunta preg LEFT JOIN vesta_entrevista_pregunta_opcion op ON op.idPregunta = preg.idpregunta AND op.idTipoPregunta = preg.tipopregunta and op.idGrupoPregunta = preg.idGrupoPregunta LEFT JOIN vesta_entrevista_opcion_herencia her ON her.idpregunta = preg.idpregunta AND her.idOpcion = op.idOpcion AND her.idTipoPregunta = op.idTipoPregunta WHERE preg.idGrupoPregunta = '$grupoPregunta' ORDER BY preg.idPregunta, op.idOpcion";

    loginObj['query'] = queryPreguntas;

    print(queryPreguntas);

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);*/

      /*
      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: loginObj);
*/

      final response = await post(Uri.parse(baseURLAppContigoTest),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
      //return ;
    }
  }

  Future<Map<String, dynamic>?> getHerenciaOpcion(
      String idPRegunta, String idTipoPregunta, String idOpcion) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var queryDenuncias =
        "SELECT * FROM `vesta_entrevista_opcion_herencia` WHERE idpregunta = '${idPRegunta}' AND idTipoPregunta = '${idTipoPregunta}' AND idOpcion = '${idOpcion}'";

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
      return null;
    }
  }

  Future<Map<String, dynamic>?> insertEntrevista(String insertDenuncia) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    //alertasObjt['inserts'] = insertDenuncia;
    alertasObjt['query'] = insertDenuncia;

    try {
      final response = await post(Uri.parse(baseURLAppContigoTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);

/*
      final response = await post(Uri.parse(baseURLInsertTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/
      print(response.body);

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    } catch (e) {
      print(e);
    }
  }



  Future<Map<String, dynamic>?> guardarEntrevistaNuevo(
      String entrevistaData, String opcionesData, String textoData) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Insert", "Entrevista");

    alertasObjt['entrevista'] = entrevistaData;
    alertasObjt['respuestaOpciones'] = opcionesData;
    alertasObjt['respuestaTexto'] = textoData;
    try {
      /*
      final response = await post(Uri.parse(baseDeDatosVestaGuardadoEntrevista),
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

  Future<Map<String, dynamic>?> getGrupos(String entidad) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var queryDenuncias =
        "SELECT * FROM genp_grupo_preguntas e WHERE e.entidad = '$entidad' AND e.estado = 'Activo' AND e.idTipoConducta = '${Preferences.conducta}' ORDER BY e.idGrupo ASC";

    loginObj['query'] = queryDenuncias;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);*/
      final response = await post(Uri.parse(urlTest),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
      //return ;
    }
  }
}
