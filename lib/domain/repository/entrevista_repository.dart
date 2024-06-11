import 'package:infancia/domain/network/entrevista_service.dart';


class EntrevistaRepository {
  final NetworkServiceEntrevistas? networkService;

  EntrevistaRepository({this.networkService});

  Future<Map<String, dynamic>?> getPreguntasGeneral(
      String grupoPregunta) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getPreguntasGeneral(grupoPregunta);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getGrupos(String entidad) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getGrupos(entidad);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> guardarEntrevista(String inserts) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.insertEntrevista(inserts);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> guardarEntrevistaNuevo(
      String entrevistaData, String opcionesData, String textoData) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!
        .guardarEntrevistaNuevo(entrevistaData, opcionesData, textoData);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getHerenciaOpcion(
      String idPregunta, String idGrupoPregunta, String idOpcion) async {
    return await networkService!
        .getHerenciaOpcion(idPregunta, idGrupoPregunta, idOpcion);
  }
}
