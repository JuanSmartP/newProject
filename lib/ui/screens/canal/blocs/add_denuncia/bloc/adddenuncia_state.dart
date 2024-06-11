part of 'adddenuncia_bloc.dart';

abstract class AdddenunciaState extends Equatable {
  const AdddenunciaState();

  @override
  List<Object> get props => [];
}

class AdddenunciaInitial extends AdddenunciaState {}

class MunicipiosData extends AdddenunciaState {
  final List<DropdownMenuItem<String>> listEstados;
  final List<Municipios> listMunicipios;
  final List<DropdownMenuItem<String>> itemsPaises;
  final List<Estado> estadosTodos;
  const MunicipiosData(this.listEstados, this.listMunicipios, this.itemsPaises,
      this.estadosTodos);
}

class GetImage extends AdddenunciaState {
  final File Image;
  const GetImage(this.Image);
}
