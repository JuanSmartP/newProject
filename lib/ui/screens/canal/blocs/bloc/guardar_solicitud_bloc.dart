import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infancia/domain/repository/canal_repository.dart';


part 'guardar_solicitud_event.dart';
part 'guardar_solicitud_state.dart';

class GuardarSolicitudBloc
    extends Bloc<GuardarSolicitudEvent, GuardarSolicitudState> {
  CanalRepository repository;

  GuardarSolicitudBloc({required this.repository})
      : super(GuardarSolicitudInitial()) {
    on<guardarSolicitud>((event, emit) async {
      emit(SolicitudGuardando());

      var position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .timeout(Duration(seconds: 20));

      String? entidad = "";
      if (event.entidad == "") {
        entidad = null;
      } else {
        entidad = event.entidad;
      }


      String valuesInserts =
          "<::>${event.idDapartamento}<::>${event.idMunicipio}<::>${event.servidorPublico}<::>${entidad}<::>" +
              "${event.cargo}<::>${event.particular}<::>${event.nombres}<::>${event.celular}<::>${event.descripcion}<::>${position.latitude}<::>${position.longitude}<::>${event.correo}<::>9";

      Map<String, dynamic>? insertCanal =
          await repository.guardarCanal(valuesInserts);

      emit(SolicitudGuardado());
    });
  }
}
