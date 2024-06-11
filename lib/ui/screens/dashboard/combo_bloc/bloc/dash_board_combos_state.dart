part of 'dash_board_combos_bloc.dart';

class DashBoardCombosState extends Equatable {
  const DashBoardCombosState();

  @override
  List<Object> get props => [];
}

class DashBoardCombosInitial extends DashBoardCombosState {}

class CargandoCombos extends DashBoardCombosState {
  const CargandoCombos();
}






class CombosCargados extends DashBoardCombosState {
  final List<DropdownMenuItem<String>> regionales;
  final List<DropdownMenuItem<String>> departamentos;
  final List<DropdownMenuItem<String>> municipios;
  final List<DropdownMenuItem<String>> listaPreguntasCaracterizacion;

  const CombosCargados(this.regionales, this.departamentos, this.municipios,
      this.listaPreguntasCaracterizacion);
}
