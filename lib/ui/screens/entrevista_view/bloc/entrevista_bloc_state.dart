part of 'entrevista_bloc_bloc.dart';

sealed class EntrevistaBlocState extends Equatable {
  const EntrevistaBlocState();

  @override
  List<Object> get props => [];
}

//CARGANDO DATA
class LoadingData extends EntrevistaBlocState {
  @override
  List<Object> get props => [];
}

//DATA CARGADA
class DataLoadeed extends EntrevistaBlocState {
  DataLoadeed(this.data);


  final List<Informacion> data;

  @override
  List<Object> get props => [data];
}

//ERROR EN LA DATA
class ErrorData extends EntrevistaBlocState {
  @override
  List<Object> get props => [];
}
