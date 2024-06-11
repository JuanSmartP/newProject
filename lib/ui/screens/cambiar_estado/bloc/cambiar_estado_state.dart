part of 'cambiar_estado_bloc.dart';

abstract class CambiarEstadoState extends Equatable {
  const CambiarEstadoState();

  @override
  List<Object> get props => [];
}

class CambiarEstadoInitial extends CambiarEstadoState {}

class CambiandoEstado extends CambiarEstadoState {}

class EstadoCambiado extends CambiarEstadoState {}
