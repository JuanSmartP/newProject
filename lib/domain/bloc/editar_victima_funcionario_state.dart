part of 'editar_victima_funcionario_bloc.dart';

abstract class EditarVictimaFuncionarioState extends Equatable {
  const EditarVictimaFuncionarioState();

  @override
  List<Object> get props => [];
}

class EditarVictimaFuncionarioInitial extends EditarVictimaFuncionarioState {}

class UpdateingInfoVictimaFuncionario extends EditarVictimaFuncionarioState {}

class InfoUpdatedVictimaFuncionario extends EditarVictimaFuncionarioState {
  //RegistroFuncionaroVictimas registroFuncionaroVictimas;
  InfoUpdatedVictimaFuncionario();
}
