import 'package:infancia/domain/network/contactos_services.dart';


class ContactosRepository {
  final NetworkServiceContactos? networkService;

  ContactosRepository({this.networkService});

  Future<Map<String, dynamic>?> getContactos(String tercero) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getContactos(tercero);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> updateFav(String query) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.updateFav(query);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> guardarContactos(String query) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.updateFav(query);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getPaises() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getPaises();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getEstadosTodos() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getEstadosTodos();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getCiudades() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getCiudades();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }
}
