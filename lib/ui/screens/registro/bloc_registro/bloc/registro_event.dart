part of 'registro_bloc.dart';

abstract class RegistroEvent extends Equatable {
  const RegistroEvent();

  @override
  List<Object> get props => [];
}

class CargarPaises extends RegistroEvent {
  CargarPaises();
}

class CargarPaisesRegistro extends RegistroEvent {
  CargarPaisesRegistro();
}

class CargarEstadosPaises extends RegistroEvent {
  String pais;
  CargarEstadosPaises({required this.pais});
}

class CargarEstadosCiudadesPaises extends RegistroEvent {
  String pais;
  String estado;

  CargarEstadosCiudadesPaises({required this.pais, required this.estado});
}
