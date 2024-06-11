import 'dart:convert';

import 'package:http/http.dart';
 

 
const baseURLTest =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Consulta_General.php";

const baseURLInsertTest =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Guardar_entrega.php";

const baseURLTestCorreo =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/SendEmail.php";

var baseDeDatosVestaGuardarDenunciaPreguntas =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Guardar_Denuncia_Defensoria.php";

/*
//Con defensoria
const baseURLAppContigo =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/EndContigoRecep.php";
    */

const baseURLAppContigoTest =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/EndContigoRecepTest.php";

const baseURLAppContigoTestGuardarCaso =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/Guardar_Denuncia_Defensoria_Test.php";

class NetworkServiceEndpoint {
  NetworkServiceEndpoint();

  Future<String> getEndPoint(String entidad, String tipo, String desc) async {
    var loginObj = new Map<String, dynamic>();

    var queryDenuncias =
        "SELECT  `urlEndpoint` FROM `databasePoint` WHERE entidad = '$entidad' AND tipo = '$tipo' AND descripcion = '$desc' AND app = 'MOBILE'";

    loginObj['query'] = queryDenuncias;

    try {
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      var jcdoe = jsonDecode(response.body) as Map<String, dynamic>;
      var userMap = jcdoe!["info"] as List<dynamic>;

      if (userMap.isEmpty) {
        //No hay enlace
        return "https://www.bibloplus.com/~biblop/webservice/vestaTest/Consulta_General.php";
      } else {
        var data = userMap[0] as Map<String, dynamic>;
        String url = data["urlEndpoint"];
        return url;
      }
    } catch (e) {
      print(e);
      return "Error: $e";
    }
  }
}
