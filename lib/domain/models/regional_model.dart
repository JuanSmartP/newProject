class Regional {
  String codigoRegional;
  String codigoPais;
  String descripcion;

  Regional.fromJson(Map json)
      : codigoRegional = json["pk_regional"],
        codigoPais = json["pfk_pais"],
        descripcion = json["descripcion"];
}
