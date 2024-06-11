part of 'changepassword_bloc.dart';

abstract class ChangepasswordState extends Equatable {
  const ChangepasswordState();

  @override
  List<Object> get props => [];
}

class CambiopassInitial extends ChangepasswordState {}

class CambiandoPassword extends ChangepasswordState {}

class PasswordNoIguales extends ChangepasswordState {}

class PasswordNoValida extends ChangepasswordState {}

class PasswordNoIgual extends ChangepasswordState {}

class PasswordChnaged extends ChangepasswordState {}
