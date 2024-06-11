class BlurCampos {
  String id;
  String usuarioOEntidad;
  String idCampo;
  String valor;
  String idCampoTexto;
  String formulario;

  BlurCampos.fromJson(Map json)
      : id = json["id"],
        usuarioOEntidad = json["usuarioOEntidad"],
        idCampo = json["idCampo"],
        valor = json["valor"],
        idCampoTexto = json["idCampoTexto"],
        formulario = json["formulario"];
}
