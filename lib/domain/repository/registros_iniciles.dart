import 'package:infancia/domain/network/registros_iniciales.dart';


class RegistroInicialRepository {
  final NetworkServiceRegistroInicial? networkService;

  RegistroInicialRepository({this.networkService});

  Future<Map<String, dynamic>?> getRegistrosInicialesVictimasFuncionario(
      String id) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getRegistrosInicialesVictimasFuncionario(id);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getDepartamentos() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getDepartamentos();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getTipoConducta() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getTipoConducta();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getTipoConductaEmpresa(
      String inConductas) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getTipoConductaEmpresa(inConductas);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getVictimasFuncionarioById(
      String idVictima, String tiposConducta) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!
        .getVictimasFuncionarioById(idVictima, tiposConducta);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getVictimasFuncionario(
      String tiposConducta) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getVictimasFuncionario(tiposConducta);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getMunicipios() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getMunicipios();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> updateRegistro(String query) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.updateRegistro(query);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getBlur(String tipo, String formulario) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getBlur(tipo, formulario);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }
}
