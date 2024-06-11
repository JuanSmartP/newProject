part of 'guardar_solicitud_bloc.dart';

abstract class GuardarSolicitudEvent extends Equatable {
  const GuardarSolicitudEvent();

  @override
  List<Object> get props => [];
}

class guardarSolicitud extends GuardarSolicitudEvent {
  String idDapartamento;
  String idMunicipio;
  String servidorPublico;
  String entidad;
  String cargo;
  String particular;
  String nombres;
  String celular;
  String correo;
  String descripcion;

  guardarSolicitud(
      {required this.idDapartamento,
      required this.idMunicipio,
      required this.servidorPublico,
      required this.entidad,
      required this.cargo,
      required this.particular,
      required this.nombres,
      required this.celular,
      required this.correo,
      required this.descripcion});
}
