import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infancia/domain/models/blur_model.dart';
import 'package:infancia/domain/models/registro_victimas.dart';
import 'package:infancia/domain/network/denuncias.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/denuncias_repository.dart';
import 'package:infancia/domain/repository/registros_iniciles.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'registros_funcionario_event.dart';
part 'registros_funcionario_state.dart';

class RegistrosFuncionarioBloc
    extends Bloc<RegistrosFuncionarioEvent, RegistrosFuncionarioState> {
  RegistroInicialRepository repository;

  RegistrosFuncionarioBloc({required this.repository})
      : super(RegistrosFuncionarioInitial()) {
    on<getRegistrosIniciales>((event, emit) async {
      emit(RegistrosFuncionariosConsultando());

      bool result = await InternetConnectionChecker().hasConnection;

      if (result) {
        /*
        Map<String, dynamic>? registrosFuncionarioInfo = await repository
            .getRegistrosInicialesVictimasFuncionario(Preferences.id);*/

        DenunciasRepository denunciasRepository =
            DenunciasRepository(networkService: NetworkServiceDenuncias());

        Map<String, dynamic>? getBlock = await denunciasRepository.getBloqueo();

        var userMap = getBlock!["info"] as List<dynamic>;
        var data = userMap[0] as Map<String, dynamic>;
        var bloqueo = data["bloqueo"];
        var sesion = data["logout"];

        if (bloqueo == "Si") {
          emit(BloqueoRegistrosFuncionarios());
        } else {
          Map<String, dynamic>? getTipoDeConducta =
              await repository.getTipoConducta();

          var tipoDeConductasData = getTipoDeConducta!["info"] as List<dynamic>;

          List<String> listaConductas = List.of([Preferences.conducta]);

          // List<EmpresaConducta> entidadConducta = [];
          // for (int i = 0; i < tipoDeConductasData.length; i++) {
          //   var conductas = EmpresaConducta.fromJson(tipoDeConductasData[i]);
          //   entidadConducta.add(conductas);
          // }

          // List<String> listaConductas =
          //     entidadConducta[0].tipoConducta.split("<:-:>");

          //MANDO LAS CONDUCTAS DE LA ENTIDAD A LA FUNCION
          Map<String, dynamic>? registrosFuncionarioInfo =
              await repository.getVictimasFuncionario(armarIn(listaConductas));

          //Obtengo blur de entidad
          Map<String, dynamic>? blurInfoEntidad =
              await repository.getBlur("Entidad", "Registro");

          //Obtengo blur de usuario
          Map<String, dynamic>? blurInfoUsuario =
              await repository.getBlur("Usuario", "Registro");

          var registroBlurEntidad = blurInfoEntidad!["info"] as List<dynamic>;

          var registroBlurUsuario = blurInfoUsuario!["info"] as List<dynamic>;

          List<dynamic> registroBlur;
          if (!registroBlurUsuario.isEmpty) {
            //Agarro este
            registroBlur = registroBlurUsuario;
          } else {
            registroBlur = registroBlurEntidad;
          }

          if (registrosFuncionarioInfo!["Status"] == "False") {
            emit(RegistrosFuncionarioNohay());
            print("Emit ------> RegistrosFuncionarioNohay");
          } else {
            var registroFuncionariosData =
                registrosFuncionarioInfo["info"] as List<dynamic>;

            List<RegistroFuncionaroVictimas> registrosFuncionarioList = [];
            for (int i = 0; i < registroFuncionariosData.length; i++) {
              var alertasTempranaData = RegistroFuncionaroVictimas.fromJson(
                  registroFuncionariosData[i]);
              registrosFuncionarioList.add(alertasTempranaData);
            }

            //   //BLUR
            List<BlurCampos> registrosBlurList = [];
            if (!registroBlur.isEmpty) {
              for (int i = 0; i < registroBlur.length; i++) {
                var blurData = BlurCampos.fromJson(registroBlur[i]);
                registrosBlurList.add(blurData);
              }
            }

            emit(RegistrosFuncionarioData(
                registrosFuncionarioList, registrosBlurList));
            print("Emit ------> TrataPersonasData");
          }
        }

        //Debo comsultar los tipo de conducta de la entidad que esta ingresada
      } else {
        emit(SinConexionRegistrosFuncionarios());
      }
    });

    on<getRegistroInicialesByid>((event, emit) async {
      emit(RegistrosFuncionariosConsultando());

      bool result = await InternetConnectionChecker().hasConnection;

      if (result) {
        /*
        Map<String, dynamic>? registrosFuncionarioInfo = await repository
            .getRegistrosInicialesVictimasFuncionario(Preferences.id);*/

        DenunciasRepository denunciasRepository =
            DenunciasRepository(networkService: NetworkServiceDenuncias());

        Map<String, dynamic>? getBlock = await denunciasRepository.getBloqueo();

        var userMap = getBlock!["info"] as List<dynamic>;
        var data = userMap[0] as Map<String, dynamic>;
        var bloqueo = data["bloqueo"];
        var sesion = data["logout"];

        if (bloqueo == "Si") {
          emit(BloqueoRegistrosFuncionarios());
        } else {
          //Debo comsultar los tipo de conducta de la entidad que esta ingresada
          Map<String, dynamic>? getTipoDeConducta =
              await repository.getTipoConducta();

          var tipoDeConductasData = getTipoDeConducta!["info"] as List<dynamic>;

          // List<EmpresaConducta> entidadConducta = [];
          // for (int i = 0; i < tipoDeConductasData.length; i++) {
          //   var conductas = EmpresaConducta.fromJson(tipoDeConductasData[i]);
          //   entidadConducta.add(conductas);
          // }

          // List<String> listaConductas =
          //     entidadConducta[0].tipoConducta.split("<:-:>");

          List<String> listaConductas = List.of([Preferences.conducta]);

          Map<String, dynamic>? registrosFuncionarioInfo =
              await repository.getVictimasFuncionarioById(
                  event.idVictima, armarIn(listaConductas));

          //Obtengo blur de entidad
          Map<String, dynamic>? blurInfoEntidad =
              await repository.getBlur("Entidad", "Registro");

          //Obtengo blur de usuario
          Map<String, dynamic>? blurInfoUsuario =
              await repository.getBlur("Usuario", "Registro");

          var registroBlurEntidad = blurInfoEntidad!["info"] as List<dynamic>;

          var registroBlurUsuario = blurInfoUsuario!["info"] as List<dynamic>;

          List<dynamic> registroBlur;
          if (!registroBlurUsuario.isEmpty) {
            //Agarro este
            registroBlur = registroBlurUsuario;
          } else {
            registroBlur = registroBlurEntidad;
          }

          if (registrosFuncionarioInfo!["Status"] == "False") {
            //No hay alertas tempranas
            emit(RegistrosFuncionarioNohay());
            print("Emit ------> RegistrosFuncionarioNohay");
          } else {
            var registroFuncionariosData =
                registrosFuncionarioInfo["info"] as List<dynamic>;

            List<RegistroFuncionaroVictimas> registrosFuncionarioList = [];
            for (int i = 0; i < registroFuncionariosData.length; i++) {
              var alertasTempranaData = RegistroFuncionaroVictimas.fromJson(
                  registroFuncionariosData[i]);
              registrosFuncionarioList.add(alertasTempranaData);
            }

            //BLUR
            List<BlurCampos> registrosBlurList = [];
            // if (!registroBlur.isEmpty) {
            //   for (int i = 0; i < registroBlur.length; i++) {
            //     var blurData = BlurCampos.fromJson(registroFuncionariosData[i]);
            //     registrosBlurList.add(blurData);
            //   }
            // }
            // emit(RegistrosFuncionarioData(
            //     registrosFuncionarioList, registrosBlurList));
            print("Emit ------> TrataPersonasData");
          }
        }
      }

      //}

      else {
        emit(SinConexionRegistrosFuncionarios());
      }
    });
  }

  String armarIn(List<String> entidadConducta) {
    String insq = "('";

    for (var i = 0; i < entidadConducta.length; i++) {
      if (entidadConducta.length == 1) {
        insq = insq + entidadConducta[i] + "')";
      } else {
        if (i == entidadConducta.length - 1) {
          insq = insq + entidadConducta[i] + "')";
        } else {
          insq = insq + entidadConducta[i] + "',";
        }
      }
    }

    return insq;
  }
}
