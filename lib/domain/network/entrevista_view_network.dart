import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:infancia/domain/models/entrevista_view_model.dart';

 
List result = [];

Response? response;

class NetworkEntrevistaView {
  final _url =
      'https://www.bibloplus.com/~biblop/webservice/tokenTest/DashboardInfanciaA/vesta_entrevista_data_xlsx.php';

  Future<List<Informacion>> getData(String consecutivo) async {
      response = await http.post(Uri.parse(_url), body: {
      'entrevista_id': consecutivo,
      'set_header': 'ERROR_CODE_WHEN_EMPTY'
    });

    result = jsonDecode(response!.body)['info'];

    print(consecutivo);
    print(response!.statusCode);

    print(response!.body);

    final newData = result
        .map((e) => Informacion.fromJson(e as Map<String, dynamic>))
        .toList();

    return newData;
  }
}
