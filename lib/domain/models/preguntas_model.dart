class Preguntas {
  String idPregunta;
  String idGrupoPregunta;
  String idTipoPregunta;
  String pregunta;
  String? descripcionPregunta;
  String? heredaPregunta;

  Preguntas(this.idPregunta, this.idGrupoPregunta, this.idTipoPregunta,
      this.pregunta, this.descripcionPregunta, this.heredaPregunta);

  Preguntas.fromJson(Map json)
      : idPregunta = json["idpregunta"],
        idGrupoPregunta = json["grupoPregunta"],
        idTipoPregunta = json["tipopregunta"],
        pregunta = json["pregunta"],
        descripcionPregunta = json["descripcion"],
        heredaPregunta = json["hereda"];
}
