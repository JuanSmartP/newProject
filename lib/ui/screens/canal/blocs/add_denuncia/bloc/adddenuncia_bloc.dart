import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infancia/domain/models/estado_model.dart';
import 'package:infancia/domain/models/municipio_model.dart';
import 'package:infancia/domain/network/registro_services.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/denuncias_repository.dart';
import 'package:infancia/domain/repository/registro_repository.dart';


part 'adddenuncia_event.dart';
part 'adddenuncia_state.dart';

class AdddenunciaBloc extends Bloc<AdddenunciaEvent, AdddenunciaState> {
  final DenunciasRepository repository;

  AdddenunciaBloc({required this.repository}) : super(AdddenunciaInitial()) {
    on<CargarCiudades>((event, emit) async {
      if (Preferences.offline) {
        //Cargo offline

        // List<Departamento?> deparColombia =
        //     await repository.getEstadosColombiaOffline();

        // List<Municipio?> municipiosList =
        //     await repository.getMunicipiosOffline();

        List<DropdownMenuItem<String>> departamentosItems = [];
        // for (int i = 0; i < deparColombia.length; i++) {
        //   //var pais = Estado.fromJson(estadosData[i]);
        //   var item = DropdownMenuItem(
        //       child: Text(deparColombia[i]!.NOMBRE),
        //       value: deparColombia[i]!.FK_DEPARTAMENTO);
        //   departamentosItems.add(item);
        // }

        List<Municipios> ciudadesItems = [];
        // for (int i = 0; i < municipiosList.length; i++) {
        //   var ciudad = Municipios(
        //       municipiosList[i]!.FK_DEPARTAMENTO,
        //       municipiosList[i]!.PK_MUNICIPIO,
        //       municipiosList[i]!.NOMBRE,
        //       municipiosList[i]!.FK_PAIS,
        //       municipiosList[i]!.FK_REGIONAL);
        //   ciudadesItems.add(ciudad);
        // }

        var registroRepository =
            RegistroRepository(networkService: NetworkServiceRegistro());

     //   List<Pais?> paises = await registroRepository.getPaisesOffline();
    //    List<Departamento?> estadosPaises =
        //    await registroRepository.getEstadosTodosOffLine();
//
        List<DropdownMenuItem<String>> paisesItems = [];
        // for (int i = 0; i < paises.length; i++) {
        //   //var pais = Paises.fromJson(paisesData[i]);
        //   var item = DropdownMenuItem(
        //       child: Text(paises[i]!.NOMBRE), value: paises[i]!.FK_PAIS);
        //   paisesItems.add(item);
        // }

        //Estados Colombia

        List<Estado> estadosItems = [];
        // for (int i = 0; i < estadosPaises.length; i++) {
        //   //var estado = Estado.fromJson(estadosDataPaises[i]);
        //   estadosItems.add(Estado(estadosPaises[i]!.FK_PAIS,
        //       estadosPaises[i]!.NOMBRE, estadosPaises[i]!.FK_DEPARTAMENTO));
        // }
        emit(MunicipiosData(
            departamentosItems, ciudadesItems, paisesItems, estadosItems));
      } else {
        //Cargo online
        Map<String, dynamic>? estados = await repository.getEstadosColombia();
        Map<String, dynamic>? municipiosList = await repository.getMunicipios();

        var estadosData = estados!["info"] as List<dynamic>;
        var municipisData = municipiosList!["info"] as List<dynamic>;

        List<DropdownMenuItem<String>> departamentosItems = [];
        for (int i = 0; i < estadosData.length; i++) {
          var pais = Estado.fromJson(estadosData[i]);
          var item = DropdownMenuItem(
              child: Text(pais.nombreEstado), value: pais.codigoEstado);
          departamentosItems.add(item);
        }

        List<Municipios> ciudadesItems = [];
        for (int i = 0; i < municipisData.length; i++) {
          var ciudad = Municipios.fromJson(municipisData[i]);
          ciudadesItems.add(ciudad);
        }

        var registroRepository =
            RegistroRepository(networkService: NetworkServiceRegistro());

        Map<String, dynamic>? paises = await registroRepository.getPaises();
        Map<String, dynamic>? estadosPaises =
            await registroRepository.getEstadosTodos();

        var paisesData = paises!["info"] as List<dynamic>;
        var estadosDataPaises = estadosPaises!["info"] as List<dynamic>;

        List<DropdownMenuItem<String>> paisesItems = [];
        // for (int i = 0; i < paisesData.length; i++) {
        //   var pais = Paises.fromJson(paisesData[i]);
        //   var item = DropdownMenuItem(
        //       child: Text(pais.nombrePais), value: pais.codigoPais);
        //   paisesItems.add(item);
        // }

        //Estados Colombia

        List<Estado> estadosItems = [];
        for (int i = 0; i < estadosDataPaises.length; i++) {
          var estado = Estado.fromJson(estadosDataPaises[i]);
          estadosItems.add(estado);
        }

        emit(MunicipiosData(
            departamentosItems, ciudadesItems, paisesItems, estadosItems));
      }
    });

    // on<EscogerFoto>((event, emit) async {
    //   File? imageGlobal;

    //   ImagePicker picker = ImagePicker();
    //   final image = await picker.pickImage(source: ImageSource.gallery);
    //   final imageTemp = File(image!.path);

    //   emit(GetImage(imageTemp));
    //   //Future<Uint8List>? fileInByte = image?.readAsBytes();
    // });
  }
}
