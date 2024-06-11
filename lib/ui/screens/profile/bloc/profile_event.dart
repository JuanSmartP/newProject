part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class CargarCiudadesProfile extends ProfileEvent {
  String departamento;
  CargarCiudadesProfile({required this.departamento});
}

class CargarCiudadesProfileEdit extends ProfileEvent {
  CargarCiudadesProfileEdit();
}
