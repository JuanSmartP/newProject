part of 'verificar_victima_bloc.dart';

abstract class VerificarVictimaState extends Equatable {
  const VerificarVictimaState();

  @override
  List<Object> get props => [];
}

class VerificarVictimaInitial extends VerificarVictimaState {}

class ConsultandoUsuario extends VerificarVictimaState {}

class UserData extends VerificarVictimaState {
  RegistroFuncionaroVictimas userdata;
  UserData({required this.userdata});
}

class UserNotExist extends VerificarVictimaState {}

class UserNotExistUsuario extends VerificarVictimaState {}

class UserBloqueo extends VerificarVictimaState {}

class UserVictimaSinConexion extends VerificarVictimaState {}
