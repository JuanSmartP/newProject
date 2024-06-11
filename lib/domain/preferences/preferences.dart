
import 'package:shared_preferences/shared_preferences.dart';
 

class Preferences {
  static late SharedPreferences _prefs;

  static String _nombres = "";
  static String _apellidos = "";
  static String _email = "";
  static String _id = "";
  static String _perfil = "";
  static String _usuario = "";
  static String _celular = "";
  static String _pkDepartamento = "";
  static String _pkMuniciio = "";
  static String _direccion = "";
  static String _foto = "";
  static String _perfilEntidad = "";
  static String _nombreEntidad = "";
  static String _entidadUsuario = "";
  static String _regional = "";
  static String _nameRegional = "";
  static String _pkPais = "";
  static String _ColorEntidad = "";
  static String _conducta = "";

  static bool _offline = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get nombre {
    return _prefs.getString("name") ?? _nombres;
  }

  static set nombre(String name) {
    _nombres = name;
    _prefs.setString("name", name);
  }

  static String get apellidos {
    return _prefs.getString("apellidos") ?? _apellidos;
  }

  static set apellidos(String apellidos) {
    _apellidos = apellidos;
    _prefs.setString("apellidos", apellidos);
  }

  static String get email {
    return _prefs.getString("email") ?? _email;
  }

  static set email(String email) {
    _email = email;
    _prefs.setString("email", email);
  }

  static String get id {
    return _prefs.getString("id") ?? _id;
  }

  static set id(String id) {
    _id = id;
    _prefs.setString("id", id);
  }

  static String get perfil {
    return _prefs.getString("perfil") ?? _perfil;
  }

  static set perfil(String perfil) {
    _perfil = perfil;
    _prefs.setString("perfil", perfil);
  }

  static String get usuario {
    return _prefs.getString("usuario") ?? _usuario;
  }

  static set usuario(String usuario) {
    _usuario = usuario;
    _prefs.setString("usuario", usuario);
  }

  static String get celular {
    return _prefs.getString("celular") ?? _celular;
  }

  static set celular(String celular) {
    _celular = celular;
    _prefs.setString("celular", celular);
  }

  static String get pkDepartamento {
    return _prefs.getString("departamento") ?? _pkDepartamento;
  }

  static set pkDepartamento(String departamento) {
    _pkDepartamento = departamento;
    _prefs.setString("departamento", departamento);
  }

  static String get pkMunicipio {
    return _prefs.getString("municipio") ?? _pkMuniciio;
  }

  static set pkMunicipio(String municipio) {
    _pkMuniciio = municipio;
    _prefs.setString("municipio", municipio);
  }

  static String get direccion {
    return _prefs.getString("direccion") ?? _direccion;
  }

  static set direccion(String direccion) {
    _direccion = direccion;
    _prefs.setString("direccion", direccion);
  }

  static String get foto {
    return _prefs.getString("foto") ?? _foto;
  }

  static set foto(String foto) {
    _foto = foto;
    _prefs.setString("foto", foto);
  }

  static String get perfilEntidad {
    return _prefs.getString("perfilEntidad") ?? _perfilEntidad;
  }

  static set perfilEntidad(String perfilEntidad) {
    _perfilEntidad = perfilEntidad;
    _prefs.setString("perfilEntidad", perfilEntidad);
  }

  static String get nombreEntidad {
    return _prefs.getString("nombreEntidad") ?? _nombreEntidad;
  }

  static set nombreEntidad(String nombreEntidad) {
    _nombreEntidad = nombreEntidad;
    _prefs.setString("nombreEntidad", nombreEntidad);
  }

  static String get entidadUsuario {
    return _prefs.getString("entidadUsuario") ?? _entidadUsuario;
  }

  static set entidadUsuario(String entidadUsuario) {
    _entidadUsuario = nombreEntidad;
    _prefs.setString("entidadUsuario", entidadUsuario);
  }

  static String get regional {
    return _prefs.getString("regional") ?? _regional;
  }

  static set regional(String regional) {
    _regional = regional;
    _prefs.setString("regional", regional);
  }

  static String get nameRegional {
    return _prefs.getString("nameRegional") ?? _nameRegional;
  }

  static set nameRegional(String nameRegional) {
    _nameRegional = nameRegional;
    _prefs.setString("nameRegional", nameRegional);
  }

  static bool get offline {
    return _prefs.getBool("offline") ?? _offline;
  }

  static set offline(bool offline) {
    _offline = offline;
    _prefs.setBool("offline", offline);
  }

  static String get getPkPais {
    return _prefs.getString("pkpais") ?? _pkPais;
  }

  static set pkPais(String pkPais) {
    _pkPais = pkPais;
    _prefs.setString("pkpais", pkPais);
  }

  static String get colorEntidad {
    return _prefs.getString("colorEntidad") ?? _ColorEntidad;
  }

  static set colorEntidad(String colorEntidad) {
    _ColorEntidad = colorEntidad;
    _prefs.setString("colorEntidad", colorEntidad);
  }

  static String get conducta {
    return _prefs.getString("conducta") ?? _conducta;
  }

  static set conducta(String conducta) {
    _conducta = conducta;
    _prefs.setString("conducta", conducta);
  }

  static clearPreferences() {
    Preferences.perfil = "";
    Preferences.usuario = "";
    Preferences.nombre = "";
    Preferences.apellidos = "";
    Preferences.celular = "";
    Preferences.email = "";
    Preferences.id = "";
    Preferences.pkDepartamento = "";
    Preferences.pkMunicipio = "";
    Preferences.direccion = "";
    Preferences.foto = "";
    Preferences.perfilEntidad = "";
    Preferences.nombreEntidad = "";
    Preferences.entidadUsuario = "";
    Preferences.regional = "";
    Preferences.nameRegional = "";
    Preferences.pkPais = "";
    Preferences.colorEntidad = "";
    Preferences.conducta = "";
  }
}
