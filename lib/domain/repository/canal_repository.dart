import 'package:infancia/domain/network/canal_services.dart';
import 'package:infancia/domain/preferences/preferences.dart';
// import 'package:vesta_flutter/network/canal_service.dart';
// import 'package:vesta_flutter/preferences.dart';

class CanalRepository {
  final CanalService? canalService;

  CanalRepository({this.canalService});

  Future<Map<String, dynamic>?> guardarCanal(String dataQuery) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await canalService!.guardarCanalAtencion(dataQuery);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getBlur(String tipo, String formulario) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await canalService!.getBlur(tipo, formulario);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getEntidades() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await canalService!.getEntidades();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getCanalesMain(String regional,
      String fechaInicial, String fechaFinal, bool rangoFecha) async {
    //Aca le pregunto al network si el login es correcto y traigo la info

    if (Preferences.perfil == '3') {
      if (regional == "No tiene") {
        //Pregunto las fechas
        if (fechaInicial != "") {
          //Tiene fechas
          return await canalService!.getCanalesMainTodosPorFecha(
              regional, fechaInicial, fechaFinal, rangoFecha);
        } else {
          return await canalService!.getCanalesMainTodos(regional);
        }
      } else {
        return await canalService!.getCanalesMain(regional);
      }
    } else {
      return await canalService!.getCanalesMain(regional);
    }

    //return loginData!.map((e) => User.fromJson(e)).toList();
  }
}
