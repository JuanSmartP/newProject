import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'visible_event.dart';
part 'visible_state.dart';

class VisibleBloc extends Bloc<VisibleEvent, VisibleState> {
  VisibleBloc() : super(VisibleInitial()) {
    on<setVisibility>((event, emit) {
      if (event.isvisible == false) {
        emit(Visible(true));
      } else {
        emit(NotVisible(false));
      }
    });
  }
}
