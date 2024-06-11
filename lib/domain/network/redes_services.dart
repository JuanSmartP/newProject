import 'dart:convert';

import 'package:http/http.dart';
import 'package:infancia/domain/network/service_endpoint.dart';
import 'package:infancia/domain/preferences/preferences.dart';
// import 'package:vesta_flutter/network/service_endpoint.dart';
// import 'package:vesta_flutter/preferences.dart';

class NetworkServiceRedes {
  Future<Map<String, dynamic>?> getRedes(String ciudad) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query = "SELECT \n" +
        "  s.`PK_REDAPOYO`,\n" +
        "  s.`NOMBRE_SEDE`,\n" +
        "  s.`FK_DEPARTAMENTO`,\n" +
        "  s.`FK_MUNICIPIO`,\n" +
        "  s.`DIRECCION`,\n" +
        "  s.`TELEFONO`,\n" +
        "  s.`MOVIL`,\n" +
        "  s.`EMAIL`,\n" +
        "  s.`LONGITUD`,\n" +
        "  s.`LATITUD`,\n" +
        "  s.`HORARIO_AM1`,\n" +
        "  s.`HORARIO_AM2`,\n" +
        "  s.`HORARIO_PM1`,\n" +
        "  s.`HORARIO_PM2`,\n" +
        "  IFNULL(\n" +
        "    s.`CELULAR_WHATSAPP`,\n" +
        "    'No disponible'\n" +
        "  ) AS CELULAR_WHATSAPP \n" +
        "FROM\n" +
        "  `vesta_sedes_apoyo` s \n" +
        "  INNER JOIN `genp_municipios` mun ON mun.`FK_DEPARTAMENTO` = s.`FK_DEPARTAMENTO` AND mun.`PK_MUNICIPIO` = s.`FK_MUNICIPIO`\n" +
     //   "  WHERE mun.`NOMBRE` = '$ciudad'\n" +
        "where s.pfk_tipo_conducta = '9'";
    //"  ORDER BY s.`orden` DESC";

    loginObj['query'] = query;

    print(loginObj);

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
}
