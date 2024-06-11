import 'package:infancia/domain/models/dashboard_infancia.dart';

import '../network/dashboard_service.dart';

class DashBoardRepository {
  final DashBoardService? networkService;

  DashBoardRepository({this.networkService});

  Future<Map<String, dynamic>?> getVariablesByYearAndMonth(
      String codigo,
      String year,
      String regional,
      String departamento,
      String municipio,
      bool reg,
      bool depa,
      bool mun,
      bool violenciaLey,
      bool violenciaOtras,
      bool trata) async {
    if (violenciaLey) {
      return await networkService!.getVariablesByYearAndMonth(
          codigo, year, regional, departamento, municipio, reg, depa, mun);
    }
    if (violenciaOtras) {
      return await networkService!.getVariablesByYearAndMonthOtras(
          codigo, year, regional, departamento, municipio, reg, depa, mun);
    }
    if (trata) {
      return await networkService!.getVariablesByYearAndMonthTrata(
          codigo, year, regional, departamento, municipio, reg, depa, mun);
    }
  }

  //Regionales

  Future<Map<String, dynamic>?> getRegionales() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getRegionales();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  // Peticion a infancia
  Future<Map<String, dynamic>?> getConteoinfancia(
      String year, String pregunta, String opcion, String forma_orden) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!
        .getCaracterizacionInfancia(year, pregunta, opcion, forma_orden);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  //Departamentos
  Future<Map<String, dynamic>?> getDepartamentos() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getDepartamentos();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  //Municipios
  Future<Map<String, dynamic>?> getMunicipios() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getMunicipios();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  //Grupos
  Future<Map<String, dynamic>?> getGrupos(String entidad) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getGrupos(entidad);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  //Prerguntas

  Future<Map<String, dynamic>?> getPreguntasGeneral(String grupo) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getPreguntasGeneral(grupo);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getConteoCaracterizacion(
      String citerio,
      String segmento,
      String year,
      String departamento,
      String ciudad,
      String regional,
      String idPregunta) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getCaracterizacion(
        citerio, segmento, year, departamento, ciudad, regional, idPregunta);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getSolicitudes(
    String segmento,
    String year,
    String departamento,
    String ciudad,
    String regional,
  ) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!
        .getSolicitudes(segmento, year, departamento, ciudad, regional);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }
}
