import 'dart:convert';
import 'package:http/http.dart';

final baseURL =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Consulta_General.php";

class NetworkAppVersion {
  Future<Map<String, dynamic>?> getAppVersion() async {
    var versionObj = new Map<String, dynamic>();

    final query =
        "SELECT * FROM `app_version` WHERE `sos` = 'iOS' AND app = 'Infancia'";

    versionObj['query'] = query;

    try {
      final response = await post(Uri.parse(baseURL),
          headers: {"Accept": "application/json"}, body: versionObj);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getContactoNumber(String regional) async {
    var versionObj = new Map<String, dynamic>();

    final String query =
        "SELECT * FROM `contacto_soporte` WHERE regional='${regional}'";

    versionObj['query'] = query;

    try {
      final response = await post(Uri.parse(baseURL),
          headers: {"Accept": "application/json"}, body: versionObj);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }
}
