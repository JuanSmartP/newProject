import 'package:infancia/domain/network/verificarID_service.dart';


class VerificarIDRepository {
  final VerificarIDService? networkService;

  VerificarIDRepository({this.networkService});

  Future<Map<String, dynamic>?> getUserExist(String id) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getUserExist(id);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getUserInfoByID(String id) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getUserInfoByID(id);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }
}
