class PreguntasOpciones {
  String idPregunta;
  String idGrupoPregunta;
  String idTipoPregunta;
  String pregunta;
  String? descripcionPregunta;
  String? heredaPregunta;
  String? idOpcion;
  String? descripcionOpcion;
  String? heredaOpcion;
  String? heredaPreguntaOpcion;
  String? heredaOpcionRespuesta;
  String? textoOpcion;
  bool visibilidadOpcion;

  PreguntasOpciones.fromJson(Map json)
      : idPregunta = json["idpregunta"],
        idGrupoPregunta = json["grupoPregunta"],
        idTipoPregunta = json["tipopregunta"],
        pregunta = json["pregunta"],
        descripcionPregunta = json["descripcion"],
        heredaPregunta = json["hereda"],
        idOpcion = json["idOpcion"],
        descripcionOpcion = json["textoOpcion"],
        heredaOpcion = json["heredaOpcion"],
        heredaPreguntaOpcion = json["pregunta_hereda"] == null
            ? "No registra"
            : json["pregunta_hereda"],
        heredaOpcionRespuesta = json["heredaOpcionRespuesta"],
        visibilidadOpcion = true,
        textoOpcion = json["campoTexto"];
}
