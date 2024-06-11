part of 'preguntas_entrevista_bloc.dart';

abstract class PreguntasEntrevistaState extends Equatable {
  const PreguntasEntrevistaState();

  @override
  List<Object> get props => [];
}

class PreguntasEntrevistaInitial extends PreguntasEntrevistaState {}

class PreguntasConsultando extends PreguntasEntrevistaState {}

class PreguntasData extends PreguntasEntrevistaState {
  final List<PreguntasOpciones> preguntasData;
  final List<GrupoPreguntas> gruposData;
  final List<Herencia> herenciaData;

  const PreguntasData(this.preguntasData, this.gruposData, this.herenciaData);
}

class Visual extends PreguntasEntrevistaState {}

class PreguntasNohay extends PreguntasEntrevistaState {}

class NoConexionPreguntas extends PreguntasEntrevistaState {}

class GuardandoPreguntas extends PreguntasEntrevistaState {}



class EntrevistaGuardada extends PreguntasEntrevistaState {}
