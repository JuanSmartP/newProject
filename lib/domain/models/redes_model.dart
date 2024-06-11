class RedesApoyoModel {
  String nombre;
  String telefono;
  String celular;
  String direccion;
  String email;
  String latitud;
  String longitud;
  String horarioAm;
  String horarioPM;

  RedesApoyoModel.fromJson(Map json)
      : nombre = json["NOMBRE_SEDE"],
        telefono = json["TELEFONO"],
        celular = json["MOVIL"],
        direccion = json["DIRECCION"],
        email = json["EMAIL"],
        latitud = json["LATITUD"],
        longitud = json["LONGITUD"],
        horarioAm = json["HORARIO_AM1"],
        horarioPM = json["HORARIO_PM1"];
}
