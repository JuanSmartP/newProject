part of 'maptodas_bloc.dart';

abstract class MaptodasState extends Equatable {
  const MaptodasState();

  @override
  List<Object> get props => [];
}

class MaptodasInitial extends MaptodasState {}

class SedesMostrarMarcadores extends MaptodasState {
  final Set<Marker> marcadores;
  const SedesMostrarMarcadores(this.marcadores);
}

class MapaInitial extends MaptodasState {}
