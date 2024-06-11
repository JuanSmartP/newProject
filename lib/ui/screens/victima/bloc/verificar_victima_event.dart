part of 'verificar_victima_bloc.dart';

abstract class VerificarVictimaEvent extends Equatable {
  const VerificarVictimaEvent();

  @override
  List<Object> get props => [];
}

class getUserExist extends VerificarVictimaEvent {
  String id;
  getUserExist({required this.id});
}
