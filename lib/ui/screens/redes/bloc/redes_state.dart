part of 'redes_bloc.dart';

abstract class RedesState extends Equatable {
  const RedesState();

  @override
  List<Object> get props => [];
}

class RedesInitial extends RedesState {}

class RedesConsultando extends RedesState {}

class RedesNohay extends RedesState {}

class RedesData extends RedesState {
  final List<RedesApoyoModel> redesData;
  const RedesData(this.redesData);
}

class SinConexionRedes extends RedesState {}
