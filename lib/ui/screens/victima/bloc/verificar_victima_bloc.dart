import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infancia/domain/models/registro_victimas.dart';
import 'package:infancia/domain/network/denuncias.dart';
import 'package:infancia/domain/repository/denuncias_repository.dart';
import 'package:infancia/domain/repository/verificarIID_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
 

part 'verificar_victima_event.dart';
part 'verificar_victima_state.dart';

class VerificarVictimaBloc
    extends Bloc<VerificarVictimaEvent, VerificarVictimaState> {
  VerificarIDRepository verificarIDRepository;

  VerificarVictimaBloc({required this.verificarIDRepository})
      : super(VerificarVictimaInitial()) {
    on<getUserExist>((event, emit) async {
      emit(ConsultandoUsuario());

      bool result = await InternetConnectionChecker().hasConnection;

      if (result) {
        DenunciasRepository denunciasRepository =
            DenunciasRepository(networkService: NetworkServiceDenuncias());

        Map<String, dynamic>? getBlock = await denunciasRepository.getBloqueo();

        var userMap = getBlock!["info"] as List<dynamic>;
        var data = userMap[0] as Map<String, dynamic>;
        var bloqueo = data["bloqueo"];
        var sesion = data["logout"];

        if (bloqueo == "Si") {
          //Bloqueo. No se puede agregar
          emit(UserBloqueo());
        } else {
          Map<String, dynamic>? verify =
              await verificarIDRepository.getUserExist(event.id);
          List<dynamic> info = verify!["info"];

          if (info.length != 0) {
            //Esta persona esta registrada
            //emit(ExistePersona());
            Map<String, dynamic>? victimaInfo =
                await verificarIDRepository.getUserInfoByID(event.id);
            List<dynamic> infoVcitima = victimaInfo!["info"];

            //Verifico si existe
            if (infoVcitima.length != 0) {
              var user = RegistroFuncionaroVictimas.fromJson(infoVcitima[0]);

              emit(UserData(userdata: user));
            } else {
              //La  victima existe pero no cuenta con usuario
              emit(UserNotExistUsuario());
            }
          } else {
            //emit(IrRegistroAidcional());
            //No existe
            emit(UserNotExist());
          }
        }
      } else {
        emit(UserVictimaSinConexion());
      }
    });
  }
}
