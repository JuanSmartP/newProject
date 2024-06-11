part of 'dash_board_bloc.dart';

class DashBoardState extends Equatable {
  const DashBoardState();

  @override
  List<Object> get props => [];
}

class DashBoardInitial extends DashBoardState {}

class getGeneralResult extends DashBoardState {
  final List<ConteoAnualModel> datoVarariables;
  /*
  final List<DropdownMenuItem<String>> regionales;
  final List<DropdownMenuItem<String>> departamentos;
  final List<DropdownMenuItem<String>> municipios;*/

  const getGeneralResult(this.datoVarariables);
}

class DataLoading extends DashBoardState {}

class DataLoaded extends DashBoardState {
  final Map<String, dynamic> data;

  
   const DataLoaded({required this.data});
}

class ErrorState extends DashBoardState {
  final String error;

  const ErrorState({required this.error});
}



class getGeneralResultTodas extends DashBoardState {
  final List<Widget> widgetConteo;

  const getGeneralResultTodas(this.widgetConteo);
}

class getGeneralConteoCaracterizacion extends DashBoardState {
  final List<Widget> widgetConteo;

  const getGeneralConteoCaracterizacion(this.widgetConteo);
}

class ErrorConsulta extends DashBoardState {}
