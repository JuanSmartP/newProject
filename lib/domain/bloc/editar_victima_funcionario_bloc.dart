// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infancia/domain/models/registro_victimas.dart';
// import 'package:vesta_flutter/models/registro_victimas.dart';
// import 'package:vesta_flutter/network/contactos_service.dart';
// import 'package:vesta_flutter/repositorry/contacto_repository.dart';

part 'editar_victima_funcionario_event.dart';
part 'editar_victima_funcionario_state.dart';

class EditarVictimaFuncionarioBloc
    extends Bloc<EditarVictimaFuncionarioEvent, EditarVictimaFuncionarioState> {
  EditarVictimaFuncionarioBloc() : super(EditarVictimaFuncionarioInitial()) {
    on<UpdateRegistroVictimaFuncionario>((event, emit) async {
      // TODO: implement event handler

      emit(UpdateingInfoVictimaFuncionario());

      var updateDir = "UPDATE `ter_direcciones`\n" +
          " SET `FK_DEPARTAMENTO` = '${event.registroFuncionaroVictimas.departamento}',\n" +
          "  `FK_MUNICIPIO` = '${event.registroFuncionaroVictimas.municipio}',\n" +
          "  `DIRECCION` = '${event.registroFuncionaroVictimas.direccion}'\n" +
          "WHERE `FK_TERCERO` = '${event.registroFuncionaroVictimas.id}'\n" +
          "    AND `FK_TIPO_DIR` = '1';";

      var updateOthers = "UPDATE `terceros_usuarios`\n" +
          "SET `nombres` = '${event.registroFuncionaroVictimas.nombre}',\n" +
          "  `apellidos` = '${event.registroFuncionaroVictimas.apellidos}',\n" +
          "  `nombreIdentitario` = '${event.registroFuncionaroVictimas.nombreIdentitario}'\n" +
          //  "  `fk_genero` = ${generoValue},\n" +
          //"`victimaTF` = '${event.registroFuncionaroVictimas.isVictima}',\n" +
          //"  `ruv` = '${event.registroFuncionaroVictimas.ruv}'\n" +
          "WHERE `pk_tercero` = '${event.registroFuncionaroVictimas.id}';";

      var updateTelefono =
          "UPDATE `ter_telefonos` SET `NUMERO`= '${event.registroFuncionaroVictimas.celular}'\n" +
              "WHERE `FK_TERCERO`= '${event.registroFuncionaroVictimas.id}'";

      var updateEmail =
          "UPDATE `ter_web_mail` SET `WEB_O_MAIL`= '${event.registroFuncionaroVictimas.email}'  WHERE `FK_TERCERO`= '${event.registroFuncionaroVictimas.id}'";

      var vestaDetalles =
          "UPDATE `vesta_detalles_registro` SET `estado`= '${event.registroFuncionaroVictimas.estado}' WHERE `pfk_tercero` = '${event.registroFuncionaroVictimas.id}'";

      // ContactosRepository alertasTempranasRepository =
      //     ContactosRepository(networkService: NetworkServiceContactos());

      // Map<String, dynamic>? updateResponseDir =
      //     await alertasTempranasRepository.updateFav(updateDir);

      // Map<String, dynamic>? updateResponseOthers =
      //     await alertasTempranasRepository.updateFav(updateOthers);

      // Map<String, dynamic>? updateResponseTelefono =
      //     await alertasTempranasRepository.updateFav(updateTelefono);

      // Map<String, dynamic>? updateResponseEmail =
      //     await alertasTempranasRepository.updateFav(updateEmail);

      // Map<String, dynamic>? updateResponseDetalles =
      //     await alertasTempranasRepository.updateFav(vestaDetalles);

      emit(InfoUpdatedVictimaFuncionario());
    });
  }
}
