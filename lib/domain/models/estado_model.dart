class Estado {
  String codigoPais;
  String codigoEstado;
  String nombreEstado;

  Estado(this.codigoPais, this.nombreEstado, this.codigoEstado);

  Estado.fromJson(Map json)
      : codigoPais = json["FK_PAIS"],
        codigoEstado = json["PK_DEPARTAMENTO"],
        nombreEstado = json["NOMBRE"];
}
