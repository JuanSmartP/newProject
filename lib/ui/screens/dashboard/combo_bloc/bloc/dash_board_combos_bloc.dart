import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infancia/domain/models/estado_model.dart';
import 'package:infancia/domain/models/municipio_model.dart';
import 'package:infancia/domain/models/preguntas_grupos.dart';
import 'package:infancia/domain/models/preguntas_model.dart';
import 'package:infancia/domain/models/regional_model.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/dashboard_repository.dart';
import 'package:infancia/domain/theme/utils.dart';
// import 'package:vesta_flutter/Utils.dart';
// import 'package:vesta_flutter/database/Floor/Departamentos.dart';
// import 'package:vesta_flutter/database/Floor/Municipios.dart';
// import 'package:vesta_flutter/preferences.dart';
// import 'package:vesta_flutter/repositorry/dashboard_repository.dart';

// import '../../models/estado_model.dart';
// import '../../models/municipio_model.dart';
// import '../../models/preguntas_grupos.dart';
// import '../../models/preguntas_model.dart';
// import '../../models/preguntas_opciones_model.dart';
// import '../../models/regional_model.dart';

part 'dash_board_combos_event.dart';
part 'dash_board_combos_state.dart';

class DashBoardCombosBloc
    extends Bloc<DashBoardCombosEvent, DashBoardCombosState> {
  final DashBoardRepository dashBoardRepository;

  DashBoardCombosBloc({required this.dashBoardRepository})
      : super(DashBoardCombosInitial()) {
    on<getCombos>((event, emit) async {
      // TODO: implement event handler

      emit(const CargandoCombos());

      Map<String, dynamic>? regionales =
          await dashBoardRepository.getRegionales();

      Map<String, dynamic>? departamentos =
          await dashBoardRepository.getDepartamentos();

      Map<String, dynamic>? municipios =
          await dashBoardRepository.getMunicipios();

      //emit(PreguntasData(preguntasList, gruposList));

      var regionalesData = regionales!["info"] as List<dynamic>;

      List<DropdownMenuItem<String>> regionalesItems = [];
      var itemInicialRegional = const DropdownMenuItem(
          value: "000",
          child: Text(
            "Todas",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff202224),
              fontFamily: 'Nunito',
            ),
          ));

      regionalesItems.add(itemInicialRegional);

      for (int i = 0; i < regionalesData.length; i++) {
        var reg = Regional.fromJson(regionalesData[i]);
        var item = DropdownMenuItem(
            value: reg.codigoRegional,
            child: Text(
              Utils.decodificarElemento(reg.descripcion),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff202224),
                fontFamily: 'Nunito',
              ),
            ));
        regionalesItems.add(item);
      }

      var depaData = departamentos!["info"] as List<dynamic>;

      List<DropdownMenuItem<String>> departamentosItems = [];
      var itemInicialDepartamento = const DropdownMenuItem(
          value: "000",
          child: Text(
            "Todos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff202224),
              fontFamily: 'Nunito',
            ),
          ));

      departamentosItems.add(itemInicialDepartamento);
      for (int i = 0; i < depaData.length; i++) {
        var depa = Estado.fromJson(depaData[i]);
        var item = DropdownMenuItem(
            value: depa.codigoEstado,
            child: Text(
              Utils.decodificarElemento(depa.nombreEstado),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff202224),
                fontFamily: 'Nunito',
              ),
            ));
        departamentosItems.add(item);
      }

      var munData = municipios!["info"] as List<dynamic>;

      List<DropdownMenuItem<String>> municipiosItems = [];
      for (int i = 0; i < munData.length; i++) {
        var mun = Municipios.fromJson(munData[i]);
        var item = DropdownMenuItem(
            value: "${mun.codigoMunicipios}_${mun.codigoDepartamento}",
            child: Text(
              Utils.decodificarElemento(mun.nombreMunicipio),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff202224),
                fontFamily: 'Nunito',
              ),
            ));
        municipiosItems.add(item);
      }

      Map<String, dynamic>? gruposInfo =
          await dashBoardRepository.getGrupos(Preferences.entidadUsuario);
      var gruposData = gruposInfo!["info"] as List<dynamic>;

      //Significa que si hay grupos

      List<GrupoPreguntas> gruposList = [];
      for (int i = 0; i < gruposData.length; i++) {
        var gData = GrupoPreguntas.fromJson(gruposData[i]);
        gruposList.add(gData);
      }
      //Obtengo las preguntas a partir del grupo

      Map<String, dynamic>? preguntasInfo =
          await dashBoardRepository.getPreguntasGeneral(gruposList[0].idGrupo);
      var preguntasData = preguntasInfo!["info"] as List<dynamic>;

      //Caracterizacion
      List<DropdownMenuItem<String>> caracterizacionPreguntasItems = [];
      for (int i = 0; i < preguntasData.length; i++) {
        var preg = Preguntas.fromJson(preguntasData[i]);
        var item = DropdownMenuItem(
            value: preg.idPregunta,
            child: Text(
              capitalizeFirstLetter(Utils.decodificarElemento(preg.pregunta)),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff202224),
                fontFamily: 'Nunito',
              ),
            ));
        caracterizacionPreguntasItems.add(item);
      }

      emit(CombosCargados(regionalesItems, departamentosItems, municipiosItems,
          caracterizacionPreguntasItems));
    });
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text; // Manejar caso de cadena vacía
  String firstLetter = text.substring(0, 1).toUpperCase();
  String restOfText = text.substring(1).toLowerCase();
  return firstLetter + restOfText;
}
