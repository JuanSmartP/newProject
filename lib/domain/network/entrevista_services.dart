import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:infancia/domain/models/entrevista_casos_model.dart';
import 'package:infancia/domain/preferences/preferences.dart';


const _url =
    'https://www.bibloplus.com/~biblop/webservice/tokenTest/EndContigoRecep.php';
class NetworkEntrevista {
  final _user = Preferences.usuario;

  Future<List<Info>> getData() async {
    Response response = await http.post(Uri.parse(_url), body: {
      "query":
          "SELECT ent.*, us.nombres, us.apellidos, reg.estado\nFROM vesta_entrevista ent\nINNER JOIN terceros_usuarios us ON us.pk_tercero = ent.idTercero\nINNER JOIN vesta_detalles_registro reg ON reg.pfk_tercero = ent.idTercero\nWHERE ent.usuario = '$_user' ORDER BY ent.fecha_entrevista DESC \n"
    });

    final List result = jsonDecode(response.body)['info'];

    print(response.statusCode);

    print(response.body);

    return result.map((e) => Info.fromJson(e)).toList();
  }
}


 

