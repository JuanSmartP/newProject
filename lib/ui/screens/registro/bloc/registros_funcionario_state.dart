part of 'registros_funcionario_bloc.dart';

abstract class RegistrosFuncionarioState extends Equatable {
  const RegistrosFuncionarioState();

  @override
  List<Object> get props => [];
}

class RegistrosFuncionarioInitial extends RegistrosFuncionarioState {}

class RegistrosFuncionariosConsultando extends RegistrosFuncionarioState {}

class RegistrosFuncionarioNohay extends RegistrosFuncionarioState {}

class RegistrosFuncionarioData extends RegistrosFuncionarioState {
  final List<RegistroFuncionaroVictimas> registroFuncionarioData;
  final List<BlurCampos> registrosBlur;

  const RegistrosFuncionarioData(
      this.registroFuncionarioData, this.registrosBlur);
}

class SinConexionRegistrosFuncionarios extends RegistrosFuncionarioState {}

class BloqueoRegistrosFuncionarios extends RegistrosFuncionarioState {}
