part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class CargandoCiudadesProfile extends ProfileState {}

class CiudadesDataProfile extends ProfileState {
  final List<DropdownMenuItem<String>> listEstadosDrop;
  final List<DropdownMenuItem<String>> listMunicipiosDrop;

  CiudadesDataProfile(
      {required this.listEstadosDrop, required this.listMunicipiosDrop});
}

class CiudadesDataProfileEdit extends ProfileState {
  final List<DropdownMenuItem<String>> listEstados;
  final List<Municipios> listMunicipios;

  CiudadesDataProfileEdit(
      {required this.listEstados, required this.listMunicipios});
}
