import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infancia/domain/models/estado_model.dart';
import 'package:infancia/domain/models/municipio_model.dart';
import 'package:infancia/domain/network/registros_iniciales.dart';
import 'package:infancia/domain/repository/registro_repository.dart';
import 'package:infancia/domain/repository/registros_iniciles.dart';
// import 'package:vesta_flutter/models/empresa_conducta_model.dart';
// import 'package:vesta_flutter/models/estado_model.dart';
// import 'package:vesta_flutter/models/municipio_model.dart';
// import 'package:vesta_flutter/models/pais_model.dart';
// import 'package:vesta_flutter/models/tipo_soluciones.dart';
// import 'package:vesta_flutter/network/registros_iniciales_service.dart';
// import 'package:vesta_flutter/repositorry/registro_repository.dart';
// import 'package:vesta_flutter/repositorry/registros_iniciales_repository.dart';

part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  RegistroRepository registroRepository;

  RegistroBloc({required this.registroRepository}) : super(RegistroInitial()) {
    on<CargarPaises>((event, emit) async {
      Map<String, dynamic>? ciudades = await registroRepository.getCiudades();

      final List<Municipios> dataCiudades = [];

      Map<String, dynamic>? estadosColombia =
          await registroRepository.getEstadosColombia();
      RegistroInicialRepository repository = RegistroInicialRepository(
          networkService: NetworkServiceRegistroInicial());

      Map<String, dynamic>? getTipoDeConducta =
          await repository.getTipoConducta();

      var tipoDeConductasData = getTipoDeConducta!["info"] as List<dynamic>;

      //Consulto los tipo de conducta para llenar los combos

      // List<EmpresaConducta> entidadConducta = [];
      // for (int i = 0; i < tipoDeConductasData.length; i++) {
      //   var conductas = EmpresaConducta.fromJson(tipoDeConductasData[i]);
      //   entidadConducta.add(conductas);
      // }

      // List<String> listaConductas =
      //     entidadConducta[0].tipoConducta.split("<:-:>");

      // //Obtengo lis tipo de conducta de los combos
      // Map<String, dynamic>? tipoConductasEmpresa =
      //     await repository.getTipoConductaEmpresa(armarIn(listaConductas));

      // List<DropdownMenuItem<String>> conductasItems = [];
      // for (int i = 0; i < tiposConductaData.length; i++) {
      //   var conducta = TipoConducta.fromJson(tiposConductaData[i]);
      //   var item = DropdownMenuItem(
      //       child: Text(conducta.nombre), value: conducta.codigo);
      //   conductasItems.add(item);
      // }

      var ciudadesData = ciudades!["info"] as List<dynamic>;
      var estadosColombiaData = estadosColombia!["info"] as List<dynamic>;
      // var tiposConductaData = tipoConductasEmpresa!["info"] as List<dynamic>;
      //   Estados Colombia
      List<DropdownMenuItem<String>> estadosDeparamentosColombia = [];
      for (int i = 0; i < estadosColombiaData.length; i++) {
        var estado = Estado.fromJson(estadosColombiaData[i]);
        var item = DropdownMenuItem(
            child: Text(estado.nombreEstado), value: estado.codigoEstado);
        estadosDeparamentosColombia.add(item);
      }

      List<Municipios> ciudadesItems = [];
      for (int i = 0; i < ciudadesData.length; i++) {
        var ciudad = Municipios.fromJson(ciudadesData[i]);
        ciudadesItems.add(ciudad);
      }

      final List<DropdownMenuItem<String>> tipoConducata = [];

      emit(PaisesData(
          municipiosTodos: ciudadesItems,
          estadosColombia: estadosDeparamentosColombia,
          tipoConducta: tipoConducata));
    });

    on<CargarPaisesRegistro>((event, emit) async {
      Map<String, dynamic>? paises = await registroRepository.getPaises();
      Map<String, dynamic>? estados =
          await registroRepository.getEstadosTodos();
      Map<String, dynamic>? ciudades = await registroRepository.getCiudades();
      Map<String, dynamic>? ciudadesMagdalena =
          await registroRepository.getMunicipios();
      Map<String, dynamic>? estadosColombia =
          await registroRepository.getEstadosColombia();

      var paisesData = paises!["info"] as List<dynamic>;
      var estadosData = estados!["info"] as List<dynamic>;
      var ciudadesData = ciudades!["info"] as List<dynamic>;
      var magdalenaData = ciudadesMagdalena!["info"] as List<dynamic>;
      var estadosColombiaData = estadosColombia!["info"] as List<dynamic>;

      List<DropdownMenuItem<String>> paisesItems = [];
      // for (int i = 0; i < paisesData.length; i++) {
      //   var pais = Paises.fromJson(paisesData[i]);
      //   var item = DropdownMenuItem(
      //       child: Text(pais.nombrePais), value: pais.codigoPais);
      //   paisesItems.add(item);
      // }

      List<DropdownMenuItem<String>> ciudadesMagdalenaItems = [];
      // for (int i = 0; i < magdalenaData.length; i++) {
      //   var pais = Municipios.fromJson(magdalenaData[i]);
      //   var item = DropdownMenuItem(
      //       child: Text(pais.nombreMunicipio), value: pais.codigoMunicipios);
      //   ciudadesMagdalenaItems.add(item);
      // }

      //Estados Colombia
      List<DropdownMenuItem<String>> estadosDeparamentosColombia = [];
      // for (int i = 0; i < estadosColombiaData.length; i++) {
      //   var estado = Estado.fromJson(estadosColombiaData[i]);
      //   var item = DropdownMenuItem(
      //       child: Text(estado.nombreEstado), value: estado.codigoEstado);
      //   estadosDeparamentosColombia.add(item);
      // }

      // List<Estado> estadosItems = [];
      // for (int i = 0; i < estadosData.length; i++) {
      //   var estado = Estado.fromJson(estadosData[i]);
      //   estadosItems.add(estado);
      // }

      // List<Municipios> ciudadesItems = [];
      // for (int i = 0; i < ciudadesData.length; i++) {
      //   var ciudad = Municipios.fromJson(ciudadesData[i]);
      //   ciudadesItems.add(ciudad);
      // }

      // emit(PaisesDataRegistro(
      //   itemsPaises: paisesItems,
      //   estadosTodos: estadosItems,
      //   municipiosTodos: ciudadesItems,
      //   itemsCiudadesMagdalena: ciudadesMagdalenaItems,
      //   estadosColombia: estadosDeparamentosColombia,
      // ));
    });

    on<CargarEstadosPaises>((event, emit) async {
      Map<String, dynamic>? estados =
          await registroRepository.getEstados(event.pais);

      var estadosData = estados!["info"] as List<dynamic>;
      // List<DropdownMenuItem<String>> estadosItems = [];
      // for (int i = 0; i < estadosData.length; i++) {
      //   var estado = Estado.fromJson(estadosData[i]);
      //   var item = DropdownMenuItem(
      //       child: Text(estado.nombreEstado), value: estado.codigoEstado);
      //   estadosItems.add(item);
      // }

      // emit(EstadoData(itemsEstados: estadosItems));
    });
  }

  String armarIn(List<String> entidadConducta) {
    String insq = "('";

    for (var i = 0; i < entidadConducta.length; i++) {
      if (entidadConducta.length == 1) {
        insq = "$insq${entidadConducta[i]}')";
      } else {
        if (i == entidadConducta.length - 1) {
          insq = "$insq${entidadConducta[i]}')";
        } else {
          insq = "$insq${entidadConducta[i]}','";
        }
      }
    }

    return insq;
  }
}
