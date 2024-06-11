class Opcion {
  String opcionIdPregunta;
  String descripcionOpcion;
  String idPregunta;
  String idOpcion;
  String hereda;
  String heredaPregunta;
  String? heredaOpcionRespuesta;
  bool selecionado;
  bool visibilidadOpcion;

  Opcion(
      {required this.opcionIdPregunta,
      required this.descripcionOpcion,
      required this.idPregunta,
      required this.idOpcion,
      required this.hereda,
      required this.heredaPregunta,
      required this.heredaOpcionRespuesta,
      required this.selecionado,
      required this.visibilidadOpcion});
}
