part of 'adddenuncia_bloc.dart';

abstract class AdddenunciaEvent extends Equatable {
  const AdddenunciaEvent();

  @override
  List<Object> get props => [];
}

class CargarCiudades extends AdddenunciaEvent {
  CargarCiudades();
}

class EscogerFoto extends AdddenunciaEvent {
  EscogerFoto();
}
