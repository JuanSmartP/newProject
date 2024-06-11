class Municipios {
  String codigoMunicipios;
  String codigoDepartamento;
  String codigoRegional;
  String nombreMunicipio;
  String paisMunicipio;

  Municipios(this.codigoDepartamento, this.codigoMunicipios,
      this.nombreMunicipio, this.paisMunicipio, this.codigoRegional);

  Municipios.fromJson(Map json)
      : codigoMunicipios = json["PK_MUNICIPIO"],
        codigoDepartamento = json["FK_DEPARTAMENTO"],
        nombreMunicipio = json["NOMBRE"],
        codigoRegional = json["FK_REGIONAL"],
        paisMunicipio = json["FK_PAIS"];
}
