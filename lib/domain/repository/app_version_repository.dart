 

import 'package:infancia/domain/network/app_version_services.dart';

class AppVersionRepository {
  final NetworkAppVersion? networkService;

  AppVersionRepository({this.networkService});

  Future<Map<String, dynamic>?> getAppVersion() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getAppVersion();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }
}
