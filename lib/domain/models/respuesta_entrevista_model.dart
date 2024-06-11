import 'package:equatable/equatable.dart';

class RespuestaEntrevista extends Equatable {
  String idPregunta;
  String? idOpcion;
  String idEntrevista;
  String idTipoPregunta;
  String idTextoRespuesta;
  String idGrupoPregunta;

  RespuestaEntrevista(
      {required this.idPregunta,
      required this.idOpcion,
      required this.idEntrevista,
      required this.idTipoPregunta,
      required this.idTextoRespuesta,
      required this.idGrupoPregunta});

  @override
  // TODO: implement props
  @override
  List<Object> get props => [];
}
