import 'package:infancia/domain/models/entrevista_view_model.dart';
import 'package:infancia/domain/network/entrevista_view_network.dart';

class EntrevistaViewRespository {
  final NetworkEntrevistaView networkEntrevistaView;

  EntrevistaViewRespository(this.networkEntrevistaView);

  Future<List<Informacion>> getEntrevistaData() async {
    return await networkEntrevistaView.getData('');
  }
}
