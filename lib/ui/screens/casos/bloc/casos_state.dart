part of 'casos_bloc.dart';

sealed class CasosState extends Equatable {
  const CasosState();
  
  @override
  List<Object> get props => [];
}


//DATA CARGANDO
class CasosLoadindData extends CasosState {


  @override
  List<Object> get props => [];
}


//DATA CARGADA

class CasosLoadedData extends CasosState {
  CasosLoadedData(this.data);

  final List<Info> data;

  @override
  List<Object> get props => [data];
}


//ERROR EN LA DATA

class ErrorState extends CasosState{
  ErrorState(this.error);

  final String error;

  List<Object> get props => [error];


}