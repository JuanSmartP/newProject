part of 'preguntas_entrevista_bloc.dart';

abstract class PreguntasEntrevistaEvent extends Equatable {
  const PreguntasEntrevistaEvent();

  @override
  List<Object> get props => [];
}

class getPreguntas extends PreguntasEntrevistaEvent {
  String grupoPregunta;
  int conteoGrupos;
  getPreguntas({required this.grupoPregunta, required this.conteoGrupos});
}

class savePreguntas extends PreguntasEntrevistaEvent {
  String idEntrevista;
  String idTercero;
  List<RespuestaEntrevista> respuestaPreguntas = [];

  savePreguntas(
      {required this.idEntrevista,
      required this.idTercero,
      required this.respuestaPreguntas});
}

class mostrarPreguntas extends PreguntasEntrevistaEvent {
  String idPregunta;
  String respuesta;
  final List<PreguntasOpciones> preguntasData;
  final List<GrupoPreguntas> gruposData;
  final List<Herencia> herenciaData;
  final String? herenciaOpcionRespuesta;

  mostrarPreguntas(
      {required this.idPregunta,
      required this.preguntasData,
      required this.gruposData,
      required this.herenciaData,
      required this.respuesta,
      required this.herenciaOpcionRespuesta});
}
