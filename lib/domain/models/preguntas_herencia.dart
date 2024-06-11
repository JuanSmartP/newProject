class Herencia {
  String? idHerencia;
  String? idPreguntaHerencia;
  String? idGrupoPreguntaHerencia;
  String? idOpcionOpcion;
  String? idTipoPreguntaOpcion;
  String? idPreguntaOpcion;
  String? herenciaOpcion;

  Herencia.fromJson(Map json)
      : idHerencia = json["idHerencia"],
        idPreguntaHerencia = json["pregunta_hereda"],
        idGrupoPreguntaHerencia = json["idGrupoHerencia"],
        idOpcionOpcion = json["idOpcion"],
        idTipoPreguntaOpcion = json["idTipoPregunta"],
        herenciaOpcion = json["herenciaOpcion"],
        idPreguntaOpcion = json["idpregunta"];
}
