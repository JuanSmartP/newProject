import 'package:infancia/domain/network/profile_network.dart';
// import 'package:vesta_flutter/network/porfile_network.dart';

class ProfileRepository {
  final NetworkServiceProfile? networkService;

  ProfileRepository({this.networkService});

  Future<Map<String, dynamic>?> getMunicipiosProfile(
      String departamento) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getMunicipiosProfile(departamento);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getMunicipios() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getMunicipios();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> updateProfile(String queryUpdate) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.updateProfile(queryUpdate);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> isEqualPassword(String user) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.isEqualPass(user);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getEstadosColombia() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getEstadosColombia();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }
}
