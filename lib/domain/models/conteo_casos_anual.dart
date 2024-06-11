class ConteoAnualModel {
  String casosMes;
  String cantidad;
  String porcentaje;
  String mes;

  ConteoAnualModel.fromJson(Map json)
      : cantidad = json["cantidad"],
        casosMes = json["denuncias"],
        porcentaje = json["porcentaje"],
        mes = json["mes_denuncia"];
}
