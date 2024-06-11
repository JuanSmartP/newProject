import 'package:infancia/domain/network/redes_services.dart';


class RedesRepository {
  final NetworkServiceRedes? networkService;

  RedesRepository({this.networkService});

  Future<Map<String, dynamic>?> getRedes(String ciudad) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getRedes(ciudad);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }
}
