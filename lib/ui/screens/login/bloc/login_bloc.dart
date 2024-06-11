import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:infancia/domain/models/user_model.dart';
import 'package:infancia/domain/network/denuncias.dart';
import 'package:infancia/domain/network/login_services.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/denuncias_repository.dart';
import 'package:infancia/domain/repository/login_repository.dart';
import 'package:infancia/ui/screens/login/login_screen.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository =
      LoginRepository(networkService: NetworkService());
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {


       
      emit(LoginLoading());

      bool result = await InternetConnectionChecker().hasConnection;

      if (result) {
        Map<String, dynamic>? userList =
            await loginRepository.getLogin(event.username.trim());


        if (userList!["response"] == "No acceso") {
          emit(BloqueoLogin());
        } else {
          if (password.text == "" || email.text == "" ) {
            emit(EmptyFields());
            //Usuario no existe

          }else if( userList!["Status"] == "False") {
            emit(LoginFails());
          }

          else {
            //Si es true, si existe y verifico su contraseña
            var bytes = utf8.encode(event.pass);
            var encrytText = sha1.convert(bytes);
            var passEncyrpt = encrytText.toString();
            print(passEncyrpt);

            var userMap = userList["info"] as List<dynamic>;
            var userData = User.fromJson(userMap[0]);
            var pass = userData.pass;

            //Comparo si las contraseñas son iguales
            if (pass == passEncyrpt) {
              //Son iguales
              if (userData.estado == "0") {
                emit(LoginBlock());
              } else {
                //Guardar preferencias
                Preferences.perfil = userData.perfil;
                Preferences.usuario = userData.usuario;
                Preferences.nombre =
                    userData.nombres == null ? "" : userData.nombres.toString();
                Preferences.apellidos = userData.apellidos == null
                    ? ""
                    : userData.apellidos.toString();
                Preferences.celular = userData.telefono;
                Preferences.email = userData.email;
                Preferences.id = userData.identificacion;
                Preferences.pkDepartamento = userData.pkDepartamento;
                Preferences.pkMunicipio = userData.pkMunicipio;
                Preferences.direccion = userData.direccion;
                Preferences.foto =
                    userData.foto == null ? "" : userData.foto.toString();
                Preferences.perfilEntidad = userData.perfilEntidad;
                Preferences.nombreEntidad = userData.nombreEntidad.toString();
                Preferences.entidadUsuario = userData.entidadUsuario;
                Preferences.regional = userData.regional;
                Preferences.nameRegional = userData.nameRegional;
                Preferences.pkPais = userData.pkPais;
                Preferences.colorEntidad = userData.colorEntidad;
                Preferences.conducta = userData.conducta!;

                var insertIngreso =
                    "INSERT INTO `app_ingreso`(`fechaIngreso`, `app`, `usuario`) VALUES (NOW(),'iOS','${userData.usuario}')";

                DenunciasRepository repository = DenunciasRepository(
                    networkService: NetworkServiceDenuncias());

                Map<String, dynamic>? municipiosList =
                    await repository.guardarDenuncia(insertIngreso);

                emit(LoginSuccess());
              }
            } else {
              emit(LoginFails());
            }
          }
        }
      } else {
        emit(SinConexionLogin());
      }
    });
  }
}
