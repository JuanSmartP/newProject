import 'dart:core';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infancia/domain/network/denuncias.dart';
import 'package:infancia/domain/network/registro_services.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/denuncias_repository.dart';
import 'package:infancia/domain/repository/registro_repository.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:vesta_flutter/Blocs/RegistroControl/registrocontrol_bloc.dart';
// import 'package:vesta_flutter/network/denuncias_service.dart';
// import 'package:vesta_flutter/network/registro_service.dart';
// import 'package:vesta_flutter/preferences.dart';
// import 'package:vesta_flutter/repositorry/denuncias_repository.dart';
// import 'package:vesta_flutter/repositorry/registro_repository.dart';

part 'registro_victimas_funcionario_event.dart';
part 'registro_victimas_funcionario_state.dart';

class RegistroVictimasFuncionarioBloc extends Bloc<
    RegistroVictimasFuncionarioEvent, RegistroVictimasFuncionarioState> {
  RegistroVictimasFuncionarioBloc()
      : super(RegistroVictimasFuncionarioInitial()) {
    on<GuardarRegistroVictimaFuncionario>((event, emit) async {


      
      emit(VerificanoInformacionRegistroFuncionario());
      if (event.id == "" ||
          event.idTipo == "" ||
          event.nombres == "" ||
          event.apellidos == "" ||
          event.departamento == "" ||
          event.tipoConducta == "" ||
          event.direccion == "") {
        emit(FaltanCamposVictimaFuncionario());
      } else {
        //Hola

        final RegistroRepository repository =
            RegistroRepository(networkService: NetworkServiceRegistro());

        Map<String, dynamic>? verify = await repository.verifyUser(event.id);
        List<dynamic> info = verify!["info"];

        if (info.length != 0) {
          //Esta persona esta registrada
          emit(ExistePersonaVictimaFuncionario());
        } else {
          //Guardo en la base de datos

          final isGranted = await Permission.location.isGranted;

          if (isGranted) {
            var position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.best)
                .timeout(Duration(seconds: 20));

            var insert_terceros =
                "INSERT INTO `terceros_usuarios` (`pk_tercero`,`nombres`,`apellidos`,`nombreIdentitario`,`latitud`,`longitud`,`usuario_creador`,`fecha_creacion_tercero`,`fecha_ingreso_tercero`, `tipo_conducta`, `app`) " +
                    "VALUES ('" +
                    event.id.trim() +
                    "','" +
                    event.nombres.trim() +
                    "','" +
                    event.apellidos.trim() +
                    "','" +
                    event.nombreIdentitario.trim() +
                    "','" +
                    position.latitude.toString() +
                    "','" +
                    position.longitude.toString() +
                    "','" +
                    Preferences.usuario +
                    "',NOW(),NOW(), '${event.tipoConducta}','IA');\n";

            //Usuario
            /*
                                                var insert_user = "INSERT INTO `usu_usuarios` (`PK_USUARIO`,`FK_PERFIL`,`FK_TERCERO`,`CONTRASENIA`,`FECHA_CREACION`,`ACTIVO`,`ENTIDAD`,`tipo_alerta`,`tipo_registro`)" +
                                                        "VALUES ('" + correo_electronico.text!!.trim() + "','2','" + persona[0] +"','" + contra_encrypt + "',CURRENT_TIMESTAMP,'0','0','1','MOVIL');\n"
                    */
            //MAIL
            var insert_mail =
                "INSERT INTO `ter_web_mail` (`FK_TERCERO`,`WEB_O_MAIL`,`TIPO`)" +
                    "VALUES('" +
                    event.id +
                    "','" +
                    event.correo +
                    "','M');\n";

            //DIRECCION
            /*
                                                var munDireccion = arraylist_mun[position_mun].first.split("_")[1]
                                                if(munDireccion== "No") {
                                                    munDireccion = "NULL"
                                                }*/
            var insert_direccion =
                "INSERT INTO `ter_direcciones`(`FK_TERCERO`,`FK_TIPO_DIR`,`FK_DEPARTAMENTO`,`FK_MUNICIPIO`,`DIRECCION`,`FK_PAIS`)" +
                    "VALUES('" +
                    event.id +
                    "','1','" +
                    event.departamento +
                    "','" +
                    event.ciudad +
                    "','" +
                    event.direccion +
                    "','82');\n";

            //TELEFONO
            var insert_tel =
                "INSERT INTO `ter_telefonos`(`FK_TERCERO`,`TIPO`,`NUMERO`)" +
                    "VALUES('" +
                    event.id +
                    "','C','" +
                    event.telefonoCelular +
                    "');\n";

            //TIPO IDENTIFICACION
            var insert_tipoid =
                "INSERT INTO `ter_terceros_identificaciones`(`FK_TERCERO`,`FK_TIPO_IDENT`,`NUM_IDENTIFICACION`)" +
                    "VALUES('" +
                    event.id +
                    "','" +
                    event.idTipo +
                    "','" +
                    event.id +
                    "');";

            //LE ASIGNO AL FUNCIONARIO ENSEGUIDA
            var insertCaracterizacion =
                "INSERT INTO `vesta_denuncias_registros_new_vi`(`pfk_tercero`, `pfk_idFuncionario`, `fecha_registro`, `fecha_modificacion`, `usuario_modificador`) " +
                    "VALUES ('" +
                    event.id +
                    "','" +
                    Preferences.id +
                    "',NOW(),NOW(),'" +
                    Preferences.usuario +
                    "');";

            //DETALLES PERSONA
            var insert_detalles =
                "INSERT INTO `vesta_detalles_registro`(`pfk_tercero`,`estado`)" +
                    "VALUES('" +
                    event.id +
                    "','EV');";

            //CREAR USUARIO DE LA VICTIMA

            /*
            var bytes = utf8.encode(event.id);
            var encrytText = sha1.convert(bytes);
            var password = encrytText.toString();

            var insert_user =
                "INSERT INTO `usu_usuarios` (`PK_USUARIO`,`FK_PERFIL`,`FK_TERCERO`,`CONTRASENIA`,`FECHA_CREACION`,`ACTIVO`,`ENTIDAD`,`tipo_alerta`,`tipo_registro`)" +
                    "VALUES ('" +
                    event.correo.trim() +
                    "','2','" +
                    event.id +
                    "','" +
                    password +
                    "',CURRENT_TIMESTAMP,'1','0','1','MOVIL');\n";*/

            final RegistroRepository repository =
                RegistroRepository(networkService: NetworkServiceRegistro());

            //Ejecuto las consultas de base de datos
            Map<String, dynamic>? insertResponseTerceros =
                await repository.guardarDenuncia(insert_terceros);

            Map<String, dynamic>? insertResponseMail =
                await repository.guardarDenuncia(insert_mail);

            Map<String, dynamic>? insertResponseDireccion =
                await repository.guardarDenuncia(insert_direccion);

            Map<String, dynamic>? insertResponseTel =
                await repository.guardarDenuncia(insert_tel);

            Map<String, dynamic>? insertResponseTipoId =
                await repository.guardarDenuncia(insert_tipoid);

            Map<String, dynamic>? insertResponseCaracterizacion =
                await repository.guardarDenuncia(insertCaracterizacion);

            Map<String, dynamic>? insertResponseDetalles =
                await repository.guardarDenuncia(insert_detalles);

            /* Insertar usuario victima
            Map<String, dynamic>? insertUser =
                await repository.guardarDenuncia(insert_user);*/

            //Envio de correo
            String asunto = "Registro y creación de cuenta";
            String mensaje =
                "Apreciado ${event.nombres} ${event.apellidos}, gracias por unirse a nuestra comunidad. Para acceder a su cuenta, por favor inicie sesión con su dirección de correo y su numero de cédula como contraseña.";

            DenunciasRepository repositoryCorreo =
                DenunciasRepository(networkService: NetworkServiceDenuncias());

            /*
            Map<String, dynamic>? correoSendVictims = await repositoryCorreo
                .sendEmailVictima(event.correo, asunto, mensaje);*/

            emit(RegistroFinalizadoVictimaFuncionario());

            
          } else {
            // emit(PermissionLocation());
            final status = await Permission.location.request();
            switch (status) {
              case PermissionStatus.granted:
                break;
              case PermissionStatus.denied:
              case PermissionStatus.restricted:
              case PermissionStatus.limited:
              case PermissionStatus.permanentlyDenied:
                openAppSettings();
              case PermissionStatus.provisional:
                // TODO: Handle this case.
            }
          }
        }
      }
    });
  }
}
