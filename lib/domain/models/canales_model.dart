class SolicituesModel {
  String idCanal;
  String pkDepartamento;
  String departamento;
  String pkMunicipio;
  String municipio;
  String servidorPublico;
  String? entidad;
  String? cargo;
  String particular;
  String? nombres;
  String celular;
  String correo;
  String descripcion;
  String? lat;
  String? long;
  String estado;
  String fechaRegistro;

  SolicituesModel.fromJson(Map json)
      : idCanal = json["idCanal"],
        pkDepartamento = json["pfk_departamento"],
        departamento = json["Departamento"],
        pkMunicipio = json["pfk_municipio"],
        municipio = json["Municipio"],
        servidorPublico = json["servidorPublico"],
        entidad = json["entidad"],
        cargo = json["cargo"],
        particular = json["particular"],
        nombres = json["nombres"],
        celular = json["celular"],
        correo = json["correo"],
        descripcion = json["descripcion"],
        lat = json["latitud"],
        long = json["longitud"],
        estado = json["estado"],
        fechaRegistro = json["fecha_registro"];
}
