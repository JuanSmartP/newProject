part of 'mapadenuncias_bloc.dart';

abstract class MapadenunciasState extends Equatable {
  const MapadenunciasState();

  @override
  List<Object> get props => [];
}

class MapadenunciasInitial extends MapadenunciasState {}

class MostrarMarcadorDenuncia extends MapadenunciasState {
  final Set<Marker> marcadores;
  const MostrarMarcadorDenuncia(this.marcadores);
}

class PolylineSede extends MapadenunciasState {
  final PolylineResult poliResult;
  const PolylineSede(this.poliResult);
}
