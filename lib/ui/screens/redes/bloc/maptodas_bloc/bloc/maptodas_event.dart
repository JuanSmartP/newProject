part of 'maptodas_bloc.dart';

abstract class MaptodasEvent extends Equatable {
  const MaptodasEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MaptodasEvent {
  final List<RedesApoyoModel> sedesMostrar;
  const OnMapInitializedEvent(this.sedesMostrar);
}

class UbicarMarcadoresSedes extends MaptodasEvent {
  final List<RedesApoyoModel> sedesMostrar;
  const UbicarMarcadoresSedes(this.sedesMostrar);
}
