class RegistroFuncionaroVictimas {
  String? nombre;
  String? apellidos;
  String? id;
  String? fechaNacimiento;
  String? celular;
  String? direccion;
  String? estado;
  String? email;
  //Datos otros
  String? sexo;
  String? estadoCivil;
  String? escolaridad;
  String? genero;
  String? departamento;
  String? municipio;
  String? nameDepartamento;
  String? nameMunicipio;
  String? comuna;
  String? barrio;
  String? area;
  //Detalels adicionales
  String? etnia;
  String? estrato;
  String? victimaConflicto;
  String? discapacidad;
  String? nivelSisben;
  String? capacidades;
  String? personaProtegida;

  String? eps;
  String? estatusMigratorio;
  String? ruv;
  String? isVictima;
  String nombreIdentitario;

  RegistroFuncionaroVictimas.fromJson(Map json)
      : nombre = json["nombres"],
        apellidos = json["apellidos"],
        nombreIdentitario = json["nombreIdentitario"],
        id = json["pk_tercero"],
        fechaNacimiento = json["fecha_nacimiento"],
        celular = json["numero"],
        direccion = json["direccion"],
        estado = json["estadoR"],
        email = json["mail"],
        sexo = json["sexo"],
        estadoCivil = json["estado_civil"],
        escolaridad = json["escolaridad"],
        genero = json["genero"],
        departamento = json["dept"],
        municipio = json["mun"],
        nameDepartamento = json['deptName'],
        nameMunicipio = json['munName'],
        comuna = json["comuna"],
        barrio = json["barrio"],
        area = json["area"],
        etnia = json["etnia"],
        estrato = json["estrato"],
        victimaConflicto = json["victima_conflicto"],
        discapacidad = json["discapacidad"],
        nivelSisben = json["nivel_sisben"],
        capacidades = json["capacidad_excepcional"],
        personaProtegida = json["persona_protegida"],
        eps = json["eps_victima"],
        estatusMigratorio = json["estatus_migratorio_victima"],
        isVictima = json["victimaTF"],
        ruv = json["ruv"];
}
