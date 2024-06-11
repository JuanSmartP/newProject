part of 'cambiar_estado_bloc.dart';

abstract class CambiarEstadoEvent extends Equatable {
  const CambiarEstadoEvent();

  @override
  List<Object> get props => [];
}

class cambiarEstado extends CambiarEstadoEvent {
  String consecutivo;
  String estadoACambiar;

  cambiarEstado({required this.consecutivo, required this.estadoACambiar});
}

class cambiarEstadoSolicitud extends CambiarEstadoEvent {
  String idCanal;
  String estadoACambiar;

  cambiarEstadoSolicitud({required this.idCanal, required this.estadoACambiar});
}
