import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infancia/domain/models/entrevista_view_model.dart';
import 'package:infancia/domain/network/entrevista_view_network.dart';

part 'entrevista_bloc_event.dart';
part 'entrevista_bloc_state.dart';

class EntrevistaBlocBloc
    extends Bloc<EntrevistaBlocEvent, EntrevistaBlocState> {

      
  final NetworkEntrevistaView networkEntrevistaView;

  final String consecutivo;

  EntrevistaBlocBloc(this.consecutivo, this.networkEntrevistaView)
      : super(LoadingData()) {
    on<EntrevistaBlocEvent>((event, emit) async {


      
      emit(LoadingData());

      try {
        final data = await networkEntrevistaView.getData(consecutivo);

        emit(DataLoadeed(data));

        // ignore: empty_catches
      } catch (e) {}
    });
  }
}
