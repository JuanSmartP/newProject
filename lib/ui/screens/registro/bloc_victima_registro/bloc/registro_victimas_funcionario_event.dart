part of 'registro_victimas_funcionario_bloc.dart';

abstract class RegistroVictimasFuncionarioEvent extends Equatable {
  const RegistroVictimasFuncionarioEvent();

  @override
  List<Object> get props => [];
}

class GuardarRegistroVictimaFuncionario
    extends RegistroVictimasFuncionarioEvent {
  String appIA;
  String idTipo;
  String id;
  String nombres;
  String apellidos;
  String nombreIdentitario;
  String telefonoCelular;
  String correo;
  String fechaRegistro;
  String tipoConducta;
  String departamento;
  String ciudad;
  String direccion;
  GuardarRegistroVictimaFuncionario(
      {
      required this.appIA,  
      required this.idTipo,
      required this.id,
      required this.nombres,
      required this.apellidos,
      required this.nombreIdentitario,
      required this.telefonoCelular,
      required this.correo,
      required this.fechaRegistro,
      required this.tipoConducta,
      required this.departamento,
      required this.ciudad,
      required this.direccion});
}
