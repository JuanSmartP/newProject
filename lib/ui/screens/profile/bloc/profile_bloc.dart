import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infancia/domain/models/estado_model.dart';
import 'package:infancia/domain/models/municipio_model.dart';
import 'package:infancia/domain/repository/profile_repository.dart';
// import 'package:vesta_flutter/models/estado_model.dart';
// import 'package:vesta_flutter/models/municipio_model.dart';
// import 'package:vesta_flutter/network/porfile_network.dart';
// import 'package:vesta_flutter/preferences.dart';
// import 'package:vesta_flutter/repositorry/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileRepository repository})
      : super(ProfileInitial()) {
    on<CargarCiudadesProfile>((event, emit) async {
      Map<String, dynamic>? estados = await repository.getEstadosColombia();
      Map<String, dynamic>? municipiosList =
          await repository.getMunicipiosProfile(event.departamento);

      var estadosData = estados!["info"] as List<dynamic>;
      var municipisData = municipiosList!["info"] as List<dynamic>;

      List<DropdownMenuItem<String>> departamentosItems = [];
      for (int i = 0; i < estadosData.length; i++) {
        var pais = Estado.fromJson(estadosData[i]);
        var item = DropdownMenuItem(
            child: Text(pais.nombreEstado), value: pais.codigoEstado);
        departamentosItems.add(item);
      }
      List<DropdownMenuItem<String>> ciudadesItems = [];
      for (int i = 0; i < municipisData.length; i++) {
        var mun = Municipios.fromJson(municipisData[i]);
        var item = DropdownMenuItem(
            child: Text(mun.nombreMunicipio), value: mun.codigoMunicipios);
        ciudadesItems.add(item);
      }

/*
      List<Municipios> ciudadesItems = [];
      for (int i = 0; i < municipisData.length; i++) {
        var ciudad = Municipios.fromJson(municipisData[i]);
        ciudadesItems.add(ciudad);
      }
      */

      emit(CiudadesDataProfile(
          listEstadosDrop: departamentosItems,
          listMunicipiosDrop: ciudadesItems));
    });

    on<CargarCiudadesProfileEdit>((event, emit) async {
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

      emit(CiudadesDataProfileEdit(
          listEstados: departamentosItems, listMunicipios: ciudadesItems));
    });
  }
}
