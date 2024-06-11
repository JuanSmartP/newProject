import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:crypto/crypto.dart';
import 'package:infancia/domain/network/profile_network.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/profile_repository.dart';
import 'dart:convert';

// import 'package:vesta_flutter/network/porfile_network.dart';
// import 'package:vesta_flutter/preferences.dart';
// import 'package:vesta_flutter/repositorry/profile_repository.dart';

part 'changepassword_event.dart';
part 'changepassword_state.dart';

class ChangepasswordBloc
    extends Bloc<ChangepasswordEvent, ChangepasswordState> {
  ChangepasswordBloc() : super(CambiopassInitial()) {
    on<ChangePasswordToNew>((event, emit) async {
      emit(CambiandoPassword());

      if (event.oldPassword != event.repeatOldPassword) {
        //Las contraseñasno son iguales
        emit(PasswordNoIguales());
      } else {
        if (isValidPassword(event.newPassword)) {
          //Verifico si la contraseña es igual a la de arriba.
          var bytes = utf8.encode(event.oldPassword);
          var encrytText = sha1.convert(bytes);
          var oldPass = encrytText.toString();

          NetworkServiceProfile networkService = NetworkServiceProfile();

          final ProfileRepository alertasTempranasRepository =
              ProfileRepository(networkService: networkService);

          Map<String, dynamic>? isEqual = await alertasTempranasRepository
              .isEqualPassword(Preferences.usuario);

          var userMap = isEqual!["info"] as List<dynamic>;
          var data = userMap[0] as Map<String, dynamic>;
          var password = data["CONTRASENIA"];

          if (oldPass == password) {
            //Si coindicen. Procedo a Cambiarla
            var bytesNew = utf8.encode(event.newPassword);
            var encrytTextNew = sha1.convert(bytesNew);
            var newPass = encrytTextNew.toString();

            //Hago update
            var queryUpdate =
                "UPDATE usu_usuarios SET CONTRASENIA = '$newPass' WHERE PK_USUARIO = '${Preferences.usuario}'";
            Map<String, dynamic>? updateResponse =
                await alertasTempranasRepository.updateProfile(queryUpdate);

            emit(PasswordChnaged());
          } else {
            emit(PasswordNoIgual());
          }
        } else {
          //No esvalida
          emit(PasswordNoValida());
        }
      }
    });
  }
  bool isValidPassword(String password) {
    final alphanumeric = RegExp(r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}$');
    return alphanumeric.hasMatch(password);
  }
}
