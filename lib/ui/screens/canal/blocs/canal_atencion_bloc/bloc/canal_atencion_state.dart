part of 'canal_atencion_bloc.dart';

abstract class CanalAtencionState extends Equatable {
  const CanalAtencionState();

  @override
  List<Object> get props => [];
}

class CanalAtencionInitial extends CanalAtencionState {}

class EntidadesData extends CanalAtencionState {
  final List<DropdownMenuItem<String>> entidadesItems;
  const EntidadesData(this.entidadesItems);
}

class CargangoSolicitudes extends CanalAtencionState {}

class SolicitudesNoHay extends CanalAtencionState {}

class SolicitudesNoConexion extends CanalAtencionState {}


class SolicitudesData extends CanalAtencionState {
  final List<SolicituesModel> solicitudesData;
  final List<BlurCampos> registrosBlurList;
  const SolicitudesData(this.solicitudesData, this.registrosBlurList);
}
