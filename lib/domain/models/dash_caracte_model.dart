class DasboardCaracter {
  String opcion_id;
  String nombre_opcion;
  int cantidad;

  DasboardCaracter.fromJson(Map json)
      : opcion_id = json["opcion_id"],
        nombre_opcion = json["nombre_opcion"],
        cantidad = json["cantidad"];
}
