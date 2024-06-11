

import 'package:infancia/domain/network/login_services.dart';

class LoginRepository {
  final NetworkService? networkService;

  LoginRepository({this.networkService});

  Future<Map<String, dynamic>?> getLogin(String user) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getLoginData(user);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> userExist(String user) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.userExist(user);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> updatePass(String queryUpdate) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.updatePass(queryUpdate);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }
}
