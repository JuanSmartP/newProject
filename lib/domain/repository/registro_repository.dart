// import 'package:vesta_flutter/database/Floor/Departamentos.dart';
// import 'package:vesta_flutter/database/Floor/Paises.dart';
// import 'package:vesta_flutter/database/Floor/database_appContigo.dart';
// import 'package:vesta_flutter/network/registro_service.dart';

import 'package:infancia/domain/network/registro_services.dart';

class RegistroRepository {
  final NetworkServiceRegistro? networkService;

  RegistroRepository({this.networkService});

  Future<Map<String, dynamic>?> getPaises() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getPaises();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  // Future<List<Pais?>> getPaisesOffline() async {
  //   //Aca le pregunto al network si el login es correcto y traigo la info
  //   final database = await $FloorAppDatabase
  //       .databaseBuilder('appContigo_database.db')
  //       .build();
  //   var daoLugares = database.daoLugares;
  //   return await daoLugares.getPaises();
  //   //return loginData!.map((e) => User.fromJson(e)).toList();
  // }

  Future<Map<String, dynamic>?> getEstadosTodos() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getEstadosTodos();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  // Future<List<Departamento?>> getEstadosTodosOffLine() async {
  //   //Aca le pregunto al network si el login es correcto y traigo la info
  //   final database = await $FloorAppDatabase
  //       .databaseBuilder('appContigo_database.db')
  //       .build();
  //   var daoLugares = database.daoLugares;
  //   return await daoLugares
  //       .getDepartamentosTodos(); //return loginData!.map((e) => User.fromJson(e)).toList();
  // }

  Future<Map<String, dynamic>?> getCiudades() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getCiudades();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getMunicipios() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getMunicipios();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getEstados(String pais) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getEstados(pais);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> verifyUser(String id) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.verifyUser(id);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> guardarDenuncia(String insertDenuncia) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.insertDenuncia(insertDenuncia);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getEstadosColombia() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getEstadosColombia();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }
}
