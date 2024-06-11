part of 'editar_victima_funcionario_bloc.dart';

abstract class EditarVictimaFuncionarioEvent extends Equatable {
  const EditarVictimaFuncionarioEvent();

  @override
  List<Object> get props => [];
}

class UpdateRegistroVictimaFuncionario extends EditarVictimaFuncionarioEvent {
  RegistroFuncionaroVictimas registroFuncionaroVictimas;

  UpdateRegistroVictimaFuncionario({required this.registroFuncionaroVictimas});
}
