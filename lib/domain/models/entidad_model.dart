class EntidadModel {
  String NIT;
  String nombre;

  EntidadModel.fromJson(Map json)
      : NIT = json["NIT"],
        nombre = json["NOMBRE"];
}
