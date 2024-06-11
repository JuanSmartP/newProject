part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

//Estado en el pasa cuando oprime el boton login. Muestra un cargando
class LoginLoading extends LoginState {}

//Login es satisfactorio. Va a la otra pagina
class LoginSuccess extends LoginState {}

//Login es errado. Muestra el dialogo
class LoginFails extends LoginState {}

//Login satisfactorio pero, usuario bloqueado
class LoginBlock extends LoginState {}

//No hay conexion
class SinConexionLogin extends LoginState {}

//Bloqueo de operaciones
class BloqueoLogin extends LoginState {}

//Estado creado por jp
class EmptyFields extends LoginState{}




//TEST LOGIN
 