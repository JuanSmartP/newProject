part of 'registro_victimas_funcionario_bloc.dart';

abstract class RegistroVictimasFuncionarioState extends Equatable {
  const RegistroVictimasFuncionarioState();

  @override
  List<Object> get props => [];
}

class RegistroVictimasFuncionarioInitial
    extends RegistroVictimasFuncionarioState {}

class FaltanCamposVictimaFuncionario extends RegistroVictimasFuncionarioState {}

class ExistePersonaVictimaFuncionario extends RegistroVictimasFuncionarioState {
}

class VerificanoInformacionRegistroFuncionario
    extends RegistroVictimasFuncionarioState {}

class RegistroFinalizadoVictimaFuncionario
    extends RegistroVictimasFuncionarioState {}











