part of 'mapadenuncias_bloc.dart';

abstract class MapadenunciasEvent extends Equatable {
  const MapadenunciasEvent();

  @override
  List<Object> get props => [];
}

class UbicacionDenuncia extends MapadenunciasEvent {
  String latitud;
  String longitud;

  UbicacionDenuncia({required this.latitud, required this.longitud});
}

class UbicacionSede extends MapadenunciasEvent {
  String latitud;
  String longitud;

  UbicacionSede({required this.latitud, required this.longitud});
}

/*
class UbicarSedes extends MapadenunciasEvent {
  final List<RedesApoyoModel> redes;
  UbicarSedes({required this.redes});
}
*/
