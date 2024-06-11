import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infancia/domain/models/preguntas_grupos.dart';
import 'package:infancia/domain/models/preguntas_herencia.dart';
import 'package:infancia/domain/models/preguntas_opciones_model.dart';
import 'package:infancia/domain/models/respuesta_entrevista_model.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/entrevista_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
 
part 'preguntas_entrevista_event.dart';
part 'preguntas_entrevista_state.dart';

class PreguntasEntrevistaBloc
    extends Bloc<PreguntasEntrevistaEvent, PreguntasEntrevistaState> {
  final EntrevistaRepository repository;

  PreguntasEntrevistaBloc({required this.repository})
      : super(PreguntasEntrevistaInitial()) {


    on<getPreguntas>((event, emit) async {
      emit(PreguntasConsultando());
      print("Emit ------> PreguntasConsultando");

      //Verifico conexion
      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        //Obtengo los grupos
        Map<String, dynamic>? gruposInfo =
            await repository.getGrupos(Preferences.entidadUsuario);
        var gruposData = gruposInfo!["info"] as List<dynamic>;

        if (gruposData.length != 0) {
          //Significa que si hay grupos
          List<GrupoPreguntas> gruposList = [];
          for (int i = 0; i < gruposData.length; i++) {
            var gData = GrupoPreguntas.fromJson(gruposData[i]);
            gruposList.add(gData);
          }

          //Obtengo las preguntas a partir del grupo
          Map<String, dynamic>? preguntasInfo = await repository
              .getPreguntasGeneral(gruposList[event.conteoGrupos].idGrupo);
          var preguntasData = preguntasInfo!["info"] as List<dynamic>;

          List<PreguntasOpciones> preguntasList = [];
          for (int i = 0; i < preguntasData.length; i++) {
            var preguntaData = PreguntasOpciones.fromJson(preguntasData[i]);
            preguntasList.add(preguntaData);
          }

          //Herencia preguntas
          List<Herencia> preguntasListHerencia = [];
          for (int i = 0; i < preguntasData.length; i++) {
            var preguntaDataHerencia = Herencia.fromJson(preguntasData[i]);
            if (preguntaDataHerencia.idHerencia != null) {
              preguntasListHerencia.add(preguntaDataHerencia);
            }
          }

          emit(PreguntasData(preguntasList, gruposList, preguntasListHerencia));
        } else {}
      } else {
        emit(NoConexionPreguntas());
      }

      print("Emit ------> NovedadesData");
    });



    on<mostrarPreguntas>((event, NOemit) {
       //Verifico la respuesta
      if (event.respuesta.toString().split("_")[2] == "True") {
        //Tiene herencia
        for (var item in event.preguntasData) {
          if (item.idPregunta == event.idPregunta) {
            item.heredaPregunta = "False";
            print("${item.heredaPregunta}");
          }
        }
      } else {
        //No tiene herencia. Verifico si hay herencia mostrada segun su respuesta
        var idPreguntaRespondida = event.respuesta.toString().split("_")[0];
        for (var item in event.herenciaData) {
          if (item.idPreguntaOpcion == idPreguntaRespondida &&
              item.herenciaOpcion == null) {
            //Esa pregunta tiene herencia
            //La opcion escogida es herencia?
            var idPreguntaHerencia = item.idPreguntaHerencia;
            //Ya la tengo, la oculto
            for (var item in event.preguntasData) {
              if (item.idPregunta == idPreguntaHerencia &&
                  item.heredaPregunta == "False") {
                item.heredaPregunta = "True";
                print("${item.heredaPregunta}");
              }
            }
          }
        }
      }

      //Ahora, verifico las herencias de las opciones
      if (event.herenciaOpcionRespuesta != null) {
        //No es null. Verifico sus herencias
        if (event.herenciaOpcionRespuesta == "True") {
          //Si es true, busco las herencias o lo que debe mostrar en la parte de herencia
          for (var item in event.herenciaData) {
            if (event.respuesta.toString().split("_")[0] ==
                    item.idPreguntaOpcion &&
                event.respuesta.toString().split("_")[1] ==
                    item.idOpcionOpcion) {
              //Encuentro la opcion. Saco las preguntas y sus herencias para colocarlas en true
              var preguntaHerencia = item.idPreguntaHerencia;
              var preguntaOpcionHerencia = item.herenciaOpcion;
              //Los busco en las preguntas y los coloco en true
              for (var item in event.preguntasData) {
                if (item.idPregunta == preguntaHerencia) {
                  if (item.idOpcion != preguntaOpcionHerencia) {
                    //Si es diferente, la oculto
                    item.visibilidadOpcion = false;
                  } else {
                    item.visibilidadOpcion = true;
                  }
                }
              }
            }
          }

          //Muestro
          for (var item in event.herenciaData) {
            if (event.respuesta.toString().split("_")[0] ==
                    item.idPreguntaOpcion &&
                event.respuesta.toString().split("_")[1] ==
                    item.idOpcionOpcion) {
              //Encuentro la opcion. Saco las preguntas y sus herencias para colocarlas en true
              var preguntaHerencia = item.idPreguntaHerencia;
              var preguntaOpcionHerencia = item.herenciaOpcion;
              //Los busco en las preguntas y los coloco en true
              for (var item in event.preguntasData) {
                if (item.idPregunta == preguntaHerencia) {
                  if (item.idOpcion == preguntaOpcionHerencia) {
                    //Si es diferente, la oculto
                    item.visibilidadOpcion = true;
                  }
                }
              }
            }
          }
        } else {
          //Falso. Muestro las opciones ocultas
          for (var item in event.herenciaData) {
            if (event.respuesta.toString().split("_")[0] ==
                item.idPreguntaOpcion) {
              //Encuentro la opcion. Saco las preguntas y sus herencias para colocarlas en true
              var preguntaHerencia = item.idPreguntaHerencia;
              //var preguntaOpcionHerencia = item.herenciaOpcion;
              //Los busco en las preguntas y los coloco en true
              for (var item in event.preguntasData) {
                if (item.idPregunta == preguntaHerencia) {
                  item.visibilidadOpcion = true;
                }
              }
            }
          }
        }
      }

      emit(Visual());
      print("Emit ------> Mostrar preguntas");
      emit(PreguntasData(
          event.preguntasData, event.gruposData, event.herenciaData));
    });

    on<savePreguntas>((event, emit) async {
      emit(GuardandoPreguntas());

    
      
      
      
      print("Emit ------> PreguntasGuardando");

      //Procedo a generar los inserts
      var vestaEntrevistaInsertInfo =
          "<::>${event.idEntrevista}<::>${event.idTercero}<::>${Preferences.usuario}";

      var vestaEntrevistaRespuestaOpcionInsert = "";
      for (RespuestaEntrevista respuesta in event.respuestaPreguntas) {
        if (respuesta.idTipoPregunta != 'R') {
          vestaEntrevistaRespuestaOpcionInsert +=
              "<::>${respuesta.idPregunta}<::>${respuesta.idOpcion}<::>${event.idEntrevista}<::>${respuesta.idGrupoPregunta}<::>${respuesta.idTipoPregunta};";

          /*
          respuestaOpcionesInserts +=
              "INSERT INTO `vesta_entrevista_respuesta_opcion`(`idPregunta`, `idOpcion`, `idEntrevista`, `idGrupoPregunta`, `idTipoPregunta`,`textoRespuesta` ,`fecha_respuesta`) VALUES ('${respuesta.idPregunta}','${respuesta.idOpcion}','${event.idEntrevista}','${respuesta.idGrupoPregunta}','${respuesta.idTipoPregunta}','${respuesta.idTextoRespuesta}',NOW());\n";*/
        }
      }

      var vestaEntrevistaRespuestaTextoInsert = "";

      for (RespuestaEntrevista respuesta in event.respuestaPreguntas) {
        if (respuesta.idTipoPregunta == 'R') {
          vestaEntrevistaRespuestaTextoInsert +=
              "<::>${respuesta.idPregunta}<::>${respuesta.idTipoPregunta}<::>${event.idEntrevista}<::>${respuesta.idGrupoPregunta}<::>${respuesta.idTextoRespuesta};";

/*
          respuestaTextoInserts +=
              "INSERT INTO `vesta_entrevista_respuesta_texto`(`idPregunta`, `idTipoPregunta`, `idEntrevista`, `idGrupoPregunta`, `textoRespuesta`, `fecha_respuesta`) VALUES ('${respuesta.idPregunta}','${respuesta.idTipoPregunta}','${event.idEntrevista}','${respuesta.idGrupoPregunta}','${respuesta.idTextoRespuesta}',NOW());\n";*/
        }
      }

      
      // var update =
      //     "UPDATE `vesta_detalles_registro` SET `estado`= 'V' WHERE `pfk_tercero` = '${event.idTercero}'";

      Map<String, dynamic>? insertsOpciones =
          await repository.guardarEntrevistaNuevo(
              vestaEntrevistaInsertInfo,
              vestaEntrevistaRespuestaOpcionInsert,
              vestaEntrevistaRespuestaTextoInsert);

      
      // Map<String, dynamic>? insertsTexto =
      //     await repository.guardarEntrevista(update);

      emit(EntrevistaGuardada());

      print('=======> emit(Entrevista guardada) ');


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
