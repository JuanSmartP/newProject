part of 'canal_atencion_bloc.dart';

abstract class CanalAtencionEvent extends Equatable {
  const CanalAtencionEvent();

  @override
  List<Object> get props => [];
}

class getEntidades extends CanalAtencionEvent {}

class getCanalesMain extends CanalAtencionEvent {
  String regional;
  String fechaFinal;
  String fechaInicial;
  bool rangoFecha;
  getCanalesMain(
      {required this.regional,
      required this.fechaFinal,
      required this.fechaInicial,
      required this.rangoFecha});
}
