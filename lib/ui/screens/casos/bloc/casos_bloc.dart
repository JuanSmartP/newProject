import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infancia/domain/models/entrevista_casos_model.dart';
import 'package:infancia/domain/network/entrevista_services.dart';

part 'casos_event.dart';
part 'casos_state.dart';

class CasosBloc extends Bloc<CasosEvent, CasosState> {
  final NetworkEntrevista networkEntrevista;

  CasosBloc(this.networkEntrevista) : super(CasosLoadindData()) {
    on<CasosEvent>((event, emit) async {
      emit(CasosLoadindData());

      try {
        final data = await networkEntrevista.getData();
        emit(CasosLoadedData(data));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
