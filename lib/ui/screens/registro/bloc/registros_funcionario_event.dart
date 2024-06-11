part of 'registros_funcionario_bloc.dart';

abstract class RegistrosFuncionarioEvent extends Equatable {
  const RegistrosFuncionarioEvent();

  @override
  List<Object> get props => [];
}

class getRegistrosIniciales extends RegistrosFuncionarioEvent {
  getRegistrosIniciales();
}

class getRegistroInicialesByid extends RegistrosFuncionarioEvent {
  String idVictima;
  getRegistroInicialesByid({required this.idVictima});
}
