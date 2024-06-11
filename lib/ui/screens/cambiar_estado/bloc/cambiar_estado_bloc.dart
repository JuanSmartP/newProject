import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infancia/domain/network/contactos_services.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/contacto_repository.dart';
import 'package:infancia/domain/repository/denuncias_repository.dart';

part 'cambiar_estado_event.dart';
part 'cambiar_estado_state.dart';

class CambiarEstadoBloc extends Bloc<CambiarEstadoEvent, CambiarEstadoState> {
  final DenunciasRepository denunciasRepository;

  CambiarEstadoBloc({required this.denunciasRepository})
      : super(CambiarEstadoInitial()) {
    on<cambiarEstado>((event, emit) async {
      // TODO: implement event handler
      emit(CambiandoEstado());

      //Hago el update

      ContactosRepository alertasTempranasRepository =
          ContactosRepository(networkService: NetworkServiceContactos());

      var estadoNuevo = "";

      switch (event.estadoACambiar) {
        case "1":
          estadoNuevo = "EV";

          break;
        case "2":
          estadoNuevo = "V";

          break;
        case "3":
          estadoNuevo = "ES";

          break;
        case "4":
          estadoNuevo = "R";

          break;
        default:
      }

      var updateDir =
          "UPDATE `vesta_denuncias` SET estado = '${estadoNuevo}', usuario_cambio = '${Preferences.usuario}', fecha_cambio = NOW() WHERE `conta_denuncias`= '${event.consecutivo}'";

      Map<String, dynamic>? updateEstadoRequest =
          await alertasTempranasRepository.updateFav(updateDir);

      emit(EstadoCambiado());
    });

    on<cambiarEstadoSolicitud>((event, emit) async {
      emit(CambiandoEstado());

      ContactosRepository alertasTempranasRepository =
          ContactosRepository(networkService: NetworkServiceContactos());

      var estadoNuevo = "";

      switch (event.estadoACambiar) {
        case "1":
          estadoNuevo = "Pendiente";

          break;
        case "2":
          estadoNuevo = "En progreso";

          break;
        case "3":
          estadoNuevo = "Resuelta";
          break;
        case "4":
          estadoNuevo = "No contesta";

          break;
        case "5":
          estadoNuevo = "Cerrada";

          break;
        default:
      }

      var updateDir =
          "UPDATE `vesta_canal_atencion` SET estado = '${estadoNuevo}', atendidoPor = '${Preferences.usuario}', fecha_cambio = NOW() WHERE `idCanal`= '${event.idCanal}'";

      Map<String, dynamic>? updateEstadoRequest =
          await alertasTempranasRepository.updateFav(updateDir);

      emit(EstadoCambiado());
    });
  }
}
