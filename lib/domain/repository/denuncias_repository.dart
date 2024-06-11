import 'package:infancia/domain/network/denuncias.dart';
import 'package:infancia/domain/preferences/preferences.dart';

class DenunciasRepository {
  final NetworkServiceDenuncias? networkService;

  DenunciasRepository({this.networkService});

  Future<Map<String, dynamic>?> getDenuncias(String user) async {
    switch (Preferences.perfil) {
      case "3":
        {
          return await networkService!
              .getDenunciasEquidadGeneroAdminByName(user);
        }
        

      case "5":
        {
          return await networkService!
              .getDenunciasAmenazasFuncionarioEquidadGenero(Preferences.id);
        }
        

      case "2":
        {
          return await networkService!.getDenuncias(user);
        }
        
    }
    //Aca le pregunto al network si el login es correcto y traigo la info

    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getDenunciasBuscarFecha(String fechaInicial,
      String fechaFinal, String regional, boolFecha) async {
    return await networkService!
        .getDenunciasBuscarFecha(fechaInicial, fechaFinal, regional, boolFecha);
  }

  Future<Map<String, dynamic>?> getFuncionariosUsuarios(
      String fechaInicial, String fechaFinal, String entidad, boolFecha) async {
    return await networkService!
        .getFuncionariosUsuarios(fechaInicial, fechaFinal, entidad, boolFecha);
  }

  Future<Map<String, dynamic>?> getBlur(String tipo, String formulario) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getBlur(tipo, formulario);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getDenunciaByNameFuncionario(
      String user) async {
    switch (Preferences.perfil) {
      case "3":
        {
          return await networkService!
              .getDenunciasEquidadGeneroAdminByName(user);
        }
        break;

      case "5":
        {
          return await networkService!
              .getDenunciasEquidadGeneroAdminByName(user);
        }
        break;

      case "2":
        {
          return await networkService!.getDenuncias(user);
        }
        break;
    }
    //Aca le pregunto al network si el login es correcto y traigo la info

    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getDenunciasFuncionarioId(String id) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!
        .getDenunciasAmenazasFuncionarioEquidadGenero(id);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getBloqueo() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getBloqueo();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getDenunciasSefamoro() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getDenunciasSemaforo();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getDuplasRegionales(String regional) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getDuplasRegionales(regional);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> sendEmail(
      String correo,
      String asunto,
      String mensaje,
      String nombres,
      String telefono,
      String direccion,
      String date) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.sendEmail(
      correo,
    );
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> sendEmailVictima(
    String correo,
    String asunto,
    String mensaje,
  ) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.sendEmailVictima(correo, asunto, mensaje);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getMunicipios() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getMunicipios();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  // Future<List<Municipio?>> getMunicipiosOffline() async {
  //   //Aca le pregunto al network si el login es correcto y traigo la info

  //   final database = await $FloorAppDatabase
  //       .databaseBuilder('appContigo_database.db')
  //       .build();
  //   var daoLugares = database.daoLugares;
  //   return await daoLugares.getMunicipiosAll();
  //   //return loginData!.map((e) => User.fromJson(e)).toList();
  // }

  Future<Map<String, dynamic>?> getMunicipiosRegional() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getMunicipiosRegional();
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getMunicipiosDepartemento(
      String departamento) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getMunicipiosDepartamento(departamento);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getEstadosColombia() async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.getEstadosColombia();

    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  // Future<List<Departamento?>> getEstadosColombiaOffline() async {
  //   //Aca le pregunto al network si el login es correcto y traigo la info

  //   //Consulto offline
  //   final database = await $FloorAppDatabase
  //       .databaseBuilder('appContigo_database.db')
  //       .build();
  //   var daoLugares = database.daoLugares;

  //   return await daoLugares.getDepartamentos("82");
  // }

  Future<Map<String, dynamic>?> getCorreosRuta(
      String tipoConducta, String estado, String municipio) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!
        .getCorreosRuta(tipoConducta, estado, municipio);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> guardarDenuncia(String insertDenuncia) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.insertDenuncia(insertDenuncia);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }

  //GUARDAR LAS DENUNCIA PARA LA DEFENSORIA

  Future<Map<String, dynamic>?> guardarDenunciaPreguntas(
      String respuestasInfo,
      String respuestasViolencia,
      String respuestaOtras,
      String respuestaTrata,
      String respuestaVulneracion,
      String respuestaGestion,
      String insertInfoProteccion,
      String insertInfoRecepcion,
      String insertInfoAgresor,
      String insertInfoVariables,
      String insertInfoTerapia) async {
    //Aca le pregunto al network si el login es correcto y traigo la info
    return await networkService!.guardarDenunciaPreguntas(
        respuestasInfo,
        respuestasViolencia,
        respuestaOtras,
        respuestaTrata,
        respuestaVulneracion,
        respuestaGestion,
        insertInfoProteccion,
        insertInfoRecepcion,
        insertInfoAgresor,
        insertInfoVariables,
        insertInfoTerapia);
    //return loginData!.map((e) => User.fromJson(e)).toList();
  }
}
