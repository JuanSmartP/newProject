import 'dart:convert'; // for the utf8.encode method

class User {
  String identificacion;
  String usuario;
  String? nombres;
  String? apellidos;
  String pass;
  String estado;
  String email;
  String telefono;
  String perfil;
  String direccion;
  String pkDepartamento;
  String pkMunicipio;
  String perfilEntidad;
  String? nombreEntidad;
  String entidadUsuario;
  String regional;
  String nameRegional;
  String? foto;
  String pkPais;
  String colorEntidad;
  String? conducta;

  User.fromJson(Map json)
      : identificacion = json["FK_TERCERO"],
        usuario = json["PK_USUARIO"],
        nombres = json["nombres"],
        apellidos = json["apellidos"],
        email = json["correo"],
        telefono = json["NUMERO"],
        estado = json["ACTIVO"],
        perfil = json["FK_PERFIL"],
        direccion = json["DIRECCION"],
        pkDepartamento = json["FK_DEPARTAMENTO"],
        pkMunicipio = json["FK_MUNICIPIO"],
        pass = json["CONTRASENIA"],
        perfilEntidad = json["perfil_entidad"],
        nombreEntidad = json["empresaName"],
        entidadUsuario = json["entidadUsuario"],
        regional = json["regional"],
        nameRegional = json["nameRegional"],
        pkPais = json["FK_PAIS"],
        colorEntidad = json["colorEntidad"],
        conducta = json["conducta"],
        foto = json["foto"];
        
}
