class GrupoPreguntas {
  String idGrupo;
  String nombreGrupo;
  String estado;
  String entidad;
  String? idTipoConducta;

  GrupoPreguntas.fromJson(Map json)
      : idGrupo = json["idGrupo"],
        nombreGrupo = json["nombreGrupo"],
        estado = json["estado"],
        entidad = json["entidad"],
        idTipoConducta = json["idTipoConducta"];
}
