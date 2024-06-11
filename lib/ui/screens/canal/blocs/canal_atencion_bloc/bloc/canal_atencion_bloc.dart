import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infancia/domain/models/blur_model.dart';
import 'package:infancia/domain/models/canales_model.dart';
import 'package:infancia/domain/models/entidad_model.dart';
import 'package:infancia/domain/repository/canal_repository.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:vesta_flutter/Blocs/AddSeguimiento/add_seguimiento_bloc.dart';
// import 'package:vesta_flutter/Utils.dart';
// import 'package:vesta_flutter/models/canales_model.dart';
// import 'package:vesta_flutter/models/entidad_model.dart';
// import 'package:vesta_flutter/repositorry/canal_repository.dart';

// import '../../models/blur_model.dart';

part 'canal_atencion_event.dart';
part 'canal_atencion_state.dart';

class CanalAtencionBloc extends Bloc<CanalAtencionEvent, CanalAtencionState> {
  CanalRepository repository;
  CanalAtencionBloc({required this.repository})
      : super(CanalAtencionInitial()) {
    on<getEntidades>((event, emit) async {
      Map<String, dynamic>? entidades = await repository.getEntidades();
      var entidadesData = entidades!["info"] as List<dynamic>;
      print(entidadesData);

      List<DropdownMenuItem<String>> entidadesItems = [];
      for (int i = 0; i < entidadesData.length; i++) {
        var entidad = EntidadModel.fromJson(entidadesData[i]);
        var item = DropdownMenuItem(
            value: entidad.NIT,
            child: Text(Utils.decodificarElemento(entidad.nombre)));
        entidadesItems.add(item);
      }
      emit(EntidadesData(entidadesItems));
    });

    on<getCanalesMain>((event, emit) async {
      // TODO: implement event handler

      emit(CargangoSolicitudes());

      bool result = await InternetConnectionChecker().hasConnection;

      if (result) {
        Map<String, dynamic>? solicitudes = await repository.getCanalesMain(
            event.regional,
            event.fechaInicial,
            event.fechaFinal,
            event.rangoFecha);

        var solicituesData = solicitudes!["info"] as List<dynamic>;

        //BLUR
        Map<String, dynamic>? blurInfoUsuario =
            await repository.getBlur("Usuario", "Bandeja - Solicitudes");

        Map<String, dynamic>? blurInfoEntidad =
            await repository.getBlur("Entidad", "Bandeja - Solicitudes");

        var registroBlurEntidad = blurInfoEntidad!["info"] as List<dynamic>;

        var registroBlurUsuario = blurInfoUsuario!["info"] as List<dynamic>;

        List<dynamic> registroBlur;
        if (!registroBlurUsuario.isEmpty) {
          //Agarro este
          registroBlur = registroBlurUsuario;
        } else {
          registroBlur = registroBlurEntidad;
        }

        if (solicitudes!["Status"] == "False") {
          emit(SolicitudesNoHay());
        } else {
          List<SolicituesModel> solicitudesList = [];
          for (int i = 0; i < solicituesData.length; i++) {
            var solicitudes = SolicituesModel.fromJson(solicituesData[i]);
            solicitudesList.add(solicitudes);
          }

          //BLUR
          List<BlurCampos> registrosBlurList = [];
          if (!registroBlur.isEmpty) {
            for (int i = 0; i < registroBlur.length; i++) {
              var blurData = BlurCampos.fromJson(registroBlur[i]);
              registrosBlurList.add(blurData);
            }
          }

          emit(SolicitudesData(solicitudesList, registrosBlurList));
        }
      } else {
        emit(SolicitudesNoHay());
      }
    });
  }
}
