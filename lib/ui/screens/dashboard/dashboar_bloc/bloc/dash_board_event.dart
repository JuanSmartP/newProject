// ignore_for_file: camel_case_types

part of 'dash_board_bloc.dart';

class DashBoardEvent extends Equatable {
  const DashBoardEvent();

  @override
  List<Object> get props => [];
}

// class getConteoCasosVariables extends DashBoardEvent {
//   String year;
//   String variable;
//   String regional;
//   String departamento;
//   String municipio;
//   bool reg;
//   bool depa;
//   bool mun;
//   bool violenciaLey;
//   bool violenciaOtras;
//   bool trata;

//   //bool mun;

//   getConteoCasosVariables(
//       {required this.year,
//       required this.variable,
//       required this.regional,
//       required this.departamento,
//       required this.municipio,
//       required this.reg,
//       required this.depa,
//       required this.mun,
//       required this.violenciaLey,
//       required this.violenciaOtras,
//       required this.trata});
// }

// class getConteoCaracterizacion extends DashBoardEvent {
//   String year;
//   String criterio;
//   String segmento;
//   String departamento;
//   String municipio;
//   String regional;
//   String pregunta;

//   bool reg;
//   bool depa;

//   //bool mun;

//   getConteoCaracterizacion(
//       {required this.year,
//       required this.criterio,
//       required this.segmento,
//       required this.departamento,
//       required this.municipio,
//       required this.regional,
//       required this.pregunta,
//       required this.reg,
//       required this.depa});
// }

class getRegionalesPais extends DashBoardEvent {
  const getRegionalesPais();
}

class getDepartamentos extends DashBoardEvent {
  const getDepartamentos();
}

class getMunicipios extends DashBoardEvent {
  const getMunicipios();
}


// ignore: must_be_immutable
class getConteoInfancia extends DashBoardEvent {
  String year;
  String pregunta;
  String opcion;
  String forma_orden;
  getConteoInfancia(
      {required this.year,
      required this.pregunta,
      required this.opcion,
      required this.forma_orden});
}
