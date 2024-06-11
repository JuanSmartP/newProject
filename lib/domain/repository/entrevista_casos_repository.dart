import 'package:infancia/domain/models/entrevista_casos_model.dart';
import 'package:infancia/domain/network/entrevista_services.dart';

class EntrevistRepository {

  final NetworkEntrevista networkEntrevista;

  EntrevistRepository(this.networkEntrevista);

  Future<List<Info>> getData() async {

    return await networkEntrevista.getData();
    
  }
}
