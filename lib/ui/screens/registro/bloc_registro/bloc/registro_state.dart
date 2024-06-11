part of 'registro_bloc.dart';

sealed class RegistroState extends Equatable {
  const RegistroState();
  
  @override
  List<Object> get props => [];
}

final class RegistroInitial extends RegistroState {}




class PaisesData extends RegistroState {
  List<Municipios> municipiosTodos;
  List<DropdownMenuItem<String>> tipoConducta;
  List<DropdownMenuItem<String>> estadosColombia;

  PaisesData(
      {required this.municipiosTodos,
      required this.estadosColombia,
      required this.tipoConducta});
}

class PaisesDataRegistro extends RegistroState {
  List<DropdownMenuItem<String>> itemsPaises;
  List<Estado> estadosTodos;
  List<Municipios> municipiosTodos;

  List<DropdownMenuItem<String>> itemsCiudadesMagdalena;
  List<DropdownMenuItem<String>> estadosColombia;

  PaisesDataRegistro({
    required this.itemsPaises,
    required this.estadosTodos,
    required this.municipiosTodos,
    required this.itemsCiudadesMagdalena,
    required this.estadosColombia,
  });
}

class EstadoData extends RegistroState {
  List<DropdownMenuItem<String>> itemsEstados;

  EstadoData({required this.itemsEstados});
}

class ResidenciaData extends RegistroState {
  final List<DropdownMenuItem<String>> listEstados;
  final List<Municipios> listMunicipios;
  const ResidenciaData(this.listEstados, this.listMunicipios);
}