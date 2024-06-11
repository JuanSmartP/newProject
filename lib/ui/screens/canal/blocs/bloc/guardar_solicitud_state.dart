part of 'guardar_solicitud_bloc.dart';

abstract class GuardarSolicitudState extends Equatable {
  const GuardarSolicitudState();

  @override
  List<Object> get props => [];
}

class GuardarSolicitudInitial extends GuardarSolicitudState {}

class SolicitudGuardando extends GuardarSolicitudState {}

class SolicitudGuardado extends GuardarSolicitudState {}
