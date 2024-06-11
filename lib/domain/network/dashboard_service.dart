import 'dart:convert';
import 'package:http/http.dart';
import 'package:infancia/domain/network/service_endpoint.dart';
import 'package:infancia/domain/preferences/preferences.dart';

const baseURLTest =
    "https://www.bibloplus.com/~biblop/webservice/vestaTest/Consulta_General.php";

const baseDeDatosVestaGuardarCanalAtencion =
    "http://199.168.188.218/~biblop/webservice/vestaTest/Guardar_Canal_Atencion.php";

const baseURLAppContigoTestCanal =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/Guardar_Canal_Atencion_Test.php";

const baseURLCaracterizacionDashboard =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/Dashboard/vesta_endpoint_data_dashboard.php";

const baseURLCaracterizacionDashboardInfancia =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest/DashboardInfanciaA/vesta_entrevista_data_dashboard.php";

const solicitudesUrl =
    "https://www.bibloplus.com/~biblop/webservice/tokenTest//Dashboard/vesta_endpoint_data_solicitudes.php";

class DashBoardService {
  Future<Map<String, dynamic>?> getVariablesByYearAndMonth(
      String codigoPregunta,
      String year,
      String regional,
      String departamento,
      String municipio,
      bool reg,
      bool depa,
      bool mun) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var query = "";

    if (reg == false && depa == false && mun == false) {
      //Es general
      query = "SELECT \n" +
          "  COUNT(d.conta_denuncias) AS denuncias,\n" +
          "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
          "  v.textoPregunta AS pregunta,\n" +
          "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
          "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
          "FROM\n" +
          "  vesta_denuncias d \n" +
          "  LEFT JOIN vesta_denuncias_info_violencia v \n" +
          "    ON v.id_denuncia = d.conta_denuncias \n" +
          "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL\n" +
          "GROUP BY \n" +
          "MONTH(d.fecha_denuncia)";
    } else {
      if (reg) {
        //La regional seleccionada
        query = "SELECT \n" +
            "  COUNT(d.conta_denuncias) AS denuncias,\n" +
            "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
            "  v.textoPregunta AS pregunta,\n" +
            "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
            "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
            "FROM\n" +
            "  vesta_denuncias d \n" +
            "  LEFT JOIN vesta_denuncias_info_violencia v \n" +
            "    ON v.id_denuncia = d.conta_denuncias \n" +
            "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional = '$regional'\n" +
            "GROUP BY \n" +
            "MONTH(d.fecha_denuncia)";
        if (regional == "000") {
          //La consulta cambia. Ahora lo muestro un listado de regionales
          query = "SELECT \n" +
              "  reg.descripcion as nameVal,\n" +
              "  COUNT(d.conta_denuncias) AS denuncias,\n" +
              "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
              "  v.textoPregunta AS pregunta,\n" +
              "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
              "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
              "FROM\n" +
              "  vesta_denuncias d \n" +
              "  LEFT JOIN vesta_denuncias_info_violencia v \n" +
              "    ON v.id_denuncia = d.conta_denuncias \n" +
              "  INNER JOIN genp_regional reg ON reg.pk_regional = d.regional \n" +
              "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' \n" +
              "GROUP BY reg.descripcion";
        }
      }
      if (depa) {
        //Depa seleccionado
        query = "SELECT \n" +
            "  COUNT(d.conta_denuncias) AS denuncias,\n" +
            "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
            "  v.textoPregunta AS pregunta,\n" +
            "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
            "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
            "FROM\n" +
            "  vesta_denuncias d \n" +
            "  LEFT JOIN vesta_denuncias_info_violencia v \n" +
            "    ON v.id_denuncia = d.conta_denuncias \n" +
            "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL AND d.departamento = '$departamento'\n" +
            "GROUP BY \n" +
            "MONTH(d.fecha_denuncia)";

        if (departamento == "000") {
          //La consulta cambia. Ahora lo muestro un listado de departamentos
          query = "SELECT \n" +
              "  reg.NOMBRE as nameVal,\n" +
              "  COUNT(d.conta_denuncias) AS denuncias,\n" +
              "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
              "  v.textoPregunta AS pregunta,\n" +
              "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
              "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
              "FROM\n" +
              "  vesta_denuncias d \n" +
              "  LEFT JOIN vesta_denuncias_info_violencia v \n" +
              "    ON v.id_denuncia = d.conta_denuncias \n" +
              "  INNER JOIN genp_departamentos reg ON reg.PK_DEPARTAMENTO = d.departamento \n" +
              "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL\n" +
              "GROUP BY reg.NOMBRE";
        }
      }

      if (mun) {
        //Municipio seleccionado
        query = "SELECT \n" +
            "  COUNT(d.conta_denuncias) AS denuncias,\n" +
            "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
            "  v.textoPregunta AS pregunta,\n" +
            "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
            "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
            "FROM\n" +
            "  vesta_denuncias d \n" +
            "  LEFT JOIN vesta_denuncias_info_violencia v \n" +
            "    ON v.id_denuncia = d.conta_denuncias \n" +
            "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL AND d.departamento = '${municipio.split("_")[1]}' AND d.ciudad = '${municipio.split("_")[0]}'\n" +
            "GROUP BY \n" +
            "MONTH(d.fecha_denuncia)";
      }
    }

    print(query);

    loginObj['query'] = query;

    try {
      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getVariablesByYearAndMonthOtras(
      String codigoPregunta,
      String year,
      String regional,
      String departamento,
      String municipio,
      bool reg,
      bool depa,
      bool mun) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var query = "";

    if (reg == false && depa == false && mun == false) {
      //Es general
      query = "SELECT \n" +
          "  COUNT(d.conta_denuncias) AS denuncias,\n" +
          "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
          "  v.textoPregunta AS pregunta,\n" +
          "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
          "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
          "FROM\n" +
          "  vesta_denuncias d \n" +
          "  LEFT JOIN vesta_denuncias_info_otras v \n" +
          "    ON v.id_denuncia = d.conta_denuncias \n" +
          "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL\n" +
          "GROUP BY \n" +
          "MONTH(d.fecha_denuncia)";
    } else {
      if (reg) {
        //La regional seleccionada
        query = "SELECT \n" +
            "  COUNT(d.conta_denuncias) AS denuncias,\n" +
            "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
            "  v.textoPregunta AS pregunta,\n" +
            "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
            "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
            "FROM\n" +
            "  vesta_denuncias d \n" +
            "  LEFT JOIN vesta_denuncias_info_otras v \n" +
            "    ON v.id_denuncia = d.conta_denuncias \n" +
            "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional = '$regional'\n" +
            "GROUP BY \n" +
            "MONTH(d.fecha_denuncia)";

        if (regional == "000") {
          //La consulta cambia. Ahora lo muestro un listado de regionales
          query = "SELECT \n" +
              "  reg.descripcion as nameVal,\n" +
              "  COUNT(d.conta_denuncias) AS denuncias,\n" +
              "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
              "  v.textoPregunta AS pregunta,\n" +
              "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
              "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
              "FROM\n" +
              "  vesta_denuncias d \n" +
              "  LEFT JOIN vesta_denuncias_info_otras v \n" +
              "    ON v.id_denuncia = d.conta_denuncias \n" +
              "  INNER JOIN genp_regional reg ON reg.pk_regional = d.regional \n" +
              "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' \n" +
              "GROUP BY reg.descripcion";
        }
      }
      if (depa) {
        //Depa seleccionado
        query = "SELECT \n" +
            "  COUNT(d.conta_denuncias) AS denuncias,\n" +
            "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
            "  v.textoPregunta AS pregunta,\n" +
            "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
            "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
            "FROM\n" +
            "  vesta_denuncias d \n" +
            "  LEFT JOIN vesta_denuncias_info_otras v \n" +
            "    ON v.id_denuncia = d.conta_denuncias \n" +
            "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL AND d.departamento = '$departamento'\n" +
            "GROUP BY \n" +
            "MONTH(d.fecha_denuncia)";
        if (departamento == "000") {
          //La consulta cambia. Ahora lo muestro un listado de departamentos
          query = "SELECT \n" +
              "  reg.NOMBRE as nameVal,\n" +
              "  COUNT(d.conta_denuncias) AS denuncias,\n" +
              "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
              "  v.textoPregunta AS pregunta,\n" +
              "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
              "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
              "FROM\n" +
              "  vesta_denuncias d \n" +
              "  LEFT JOIN vesta_denuncias_info_otras v \n" +
              "    ON v.id_denuncia = d.conta_denuncias \n" +
              "  INNER JOIN genp_departamentos reg ON reg.PK_DEPARTAMENTO = d.departamento \n" +
              "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL\n" +
              "GROUP BY reg.NOMBRE";
        }
      }

      if (mun) {
        //Municipio seleccionado
        query = "SELECT \n" +
            "  COUNT(d.conta_denuncias) AS denuncias,\n" +
            "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
            "  v.textoPregunta AS pregunta,\n" +
            "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
            "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
            "FROM\n" +
            "  vesta_denuncias d \n" +
            "  LEFT JOIN vesta_denuncias_info_otras v \n" +
            "    ON v.id_denuncia = d.conta_denuncias \n" +
            "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL AND d.departamento = '${municipio.split("_")[1]}' AND d.ciudad = '${municipio.split("_")[0]}'\n" +
            "GROUP BY \n" +
            "MONTH(d.fecha_denuncia)";
      }
    }

    print(query);

    loginObj['query'] = query;

    try {
      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getVariablesByYearAndMonthTrata(
      String codigoPregunta,
      String year,
      String regional,
      String departamento,
      String municipio,
      bool reg,
      bool depa,
      bool mun) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var query = "";

    if (reg == false && depa == false && mun == false) {
      //Es general
      query = "SELECT \n" +
          "  COUNT(d.conta_denuncias) AS denuncias,\n" +
          "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
          "  v.textoPregunta AS pregunta,\n" +
          "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
          "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
          "FROM\n" +
          "  vesta_denuncias d \n" +
          "  LEFT JOIN vesta_denuncias_info_trata v \n" +
          "    ON v.id_denuncia = d.conta_denuncias \n" +
          "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL\n" +
          "GROUP BY \n" +
          "MONTH(d.fecha_denuncia)";
    } else {
      if (reg) {
        //La regional seleccionada
        query = "SELECT \n" +
            "  COUNT(d.conta_denuncias) AS denuncias,\n" +
            "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
            "  v.textoPregunta AS pregunta,\n" +
            "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
            "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
            "FROM\n" +
            "  vesta_denuncias d \n" +
            "  LEFT JOIN vesta_denuncias_info_trata v \n" +
            "    ON v.id_denuncia = d.conta_denuncias \n" +
            "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional = '$regional'\n" +
            "GROUP BY \n" +
            "MONTH(d.fecha_denuncia)";
        if (regional == "000") {
          //La consulta cambia. Ahora lo muestro un listado de regionales
          query = "SELECT \n" +
              "  reg.descripcion as nameVal,\n" +
              "  COUNT(d.conta_denuncias) AS denuncias,\n" +
              "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
              "  v.textoPregunta AS pregunta,\n" +
              "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
              "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
              "FROM\n" +
              "  vesta_denuncias d \n" +
              "  LEFT JOIN vesta_denuncias_info_trata v \n" +
              "    ON v.id_denuncia = d.conta_denuncias \n" +
              "  INNER JOIN genp_regional reg ON reg.pk_regional = d.regional \n" +
              "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' \n" +
              "GROUP BY reg.descripcion";
        }
      }
      if (depa) {
        //Depa seleccionado
        query = "SELECT \n" +
            "  COUNT(d.conta_denuncias) AS denuncias,\n" +
            "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
            "  v.textoPregunta AS pregunta,\n" +
            "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
            "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
            "FROM\n" +
            "  vesta_denuncias d \n" +
            "  LEFT JOIN vesta_denuncias_info_trata v \n" +
            "    ON v.id_denuncia = d.conta_denuncias \n" +
            "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL AND d.departamento = '$departamento'\n" +
            "GROUP BY \n" +
            "MONTH(d.fecha_denuncia)";
        if (departamento == "000") {
          //La consulta cambia. Ahora lo muestro un listado de departamentos
          query = "SELECT \n" +
              "  reg.NOMBRE as nameVal,\n" +
              "  COUNT(d.conta_denuncias) AS denuncias,\n" +
              "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
              "  v.textoPregunta AS pregunta,\n" +
              "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
              "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
              "FROM\n" +
              "  vesta_denuncias d \n" +
              "  LEFT JOIN vesta_denuncias_info_trata v \n" +
              "    ON v.id_denuncia = d.conta_denuncias \n" +
              "  INNER JOIN genp_departamentos reg ON reg.PK_DEPARTAMENTO = d.departamento \n" +
              "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL\n" +
              "GROUP BY reg.NOMBRE";
        }
      }

      if (mun) {
        //Municipio seleccionado
        query = "SELECT \n" +
            "  COUNT(d.conta_denuncias) AS denuncias,\n" +
            "  SUM(CASE WHEN v.idOpcion = '1' THEN 1 ELSE 0 END) AS cantidad,\n" +
            "  v.textoPregunta AS pregunta,\n" +
            "  MONTH(d.fecha_denuncia) AS mes_denuncia,\n" +
            "  COALESCE( ROUND((SUM(CASE WHEN v.idOpcion = '1' THEN 1 END) / NULLIF(COUNT(d.conta_denuncias), 0)) * 100, 1), 0 ) AS porcentaje\n" +
            "FROM\n" +
            "  vesta_denuncias d \n" +
            "  LEFT JOIN vesta_denuncias_info_trata v \n" +
            "    ON v.id_denuncia = d.conta_denuncias \n" +
            "WHERE v.id_pregunta = '${codigoPregunta}' AND YEAR(d.fecha_denuncia) = '${year}' AND d.regional IS NOT NULL AND d.departamento = '${municipio.split("_")[1]}' AND d.ciudad = '${municipio.split("_")[0]}'\n" +
            "GROUP BY \n" +
            "MONTH(d.fecha_denuncia)";
      }
    }

    print(query);

    loginObj['query'] = query;

    try {
      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getPreguntasGeneral(
      String grupoPregunta) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var queryPreguntas =
        "SELECT *,preg.idGrupoPregunta grupoPregunta from vesta_entrevista_pregunta preg LEFT JOIN vesta_entrevista_pregunta_opcion op ON op.idPregunta = preg.idpregunta and op.idTipoPregunta = preg.tipopregunta and op.idGrupoPregunta = preg.idGrupoPregunta WHERE preg.idGrupoPregunta = '$grupoPregunta' GROUP BY preg.idpregunta ORDER BY preg.idPregunta, op.idOpcion";

    loginObj['query'] = queryPreguntas;

    print(queryPreguntas);

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
      //return ;
    }
  }

  Future<Map<String, dynamic>?> getGrupos(String entidad) async {
    var loginObj = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    var queryDenuncias =
        "SELECT * FROM genp_grupo_preguntas as e WHERE e.entidad = '$entidad' AND e.estado = 'Activo' ORDER BY e.idGrupo ASC";

    loginObj['query'] = queryDenuncias;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: loginObj);*/
      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: loginObj);

      print(response.body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
      //return ;
    }
  }

  Future<Map<String, dynamic>?> getMunicipios() async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query =
        "SELECT CONCAT(mun.NOMBRE, ', ', dep.NOMBRE) AS NOMBRE, mun.PK_MUNICIPIO, mun.FK_DEPARTAMENTO, mun.FK_PAIS, mun.FK_REGIONAL\n" +
            "FROM genp_municipios mun\n" +
            "INNER JOIN genp_departamentos dep ON mun.FK_DEPARTAMENTO = dep.PK_DEPARTAMENTO\n" +
            "WHERE mun.FK_PAIS = '${Preferences.getPkPais}'\n AND mun.FK_REGIONAL IS NOT NULL " +
            "ORDER BY mun.NOMBRE ASC";

    alertasObjt['query'] = query;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getDepartamentos() async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query =
        "SELECT * FROM  genp_departamentos WHERE FK_PAIS = '${Preferences.getPkPais}' ORDER BY NOMBRE ASC";
    alertasObjt['query'] = query;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getRegionales() async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    final query =
        "SELECT * FROM  genp_regional WHERE pfk_pais = '${Preferences.getPkPais}' ORDER BY descripcion ASC";
    alertasObjt['query'] = query;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/

      final response = await post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getCaracterizacion(
      String citerio,
      String segmento,
      String year,
      String departamento,
      String ciudad,
      String regional,
      String idPregunta) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    alertasObjt['criterio'] = citerio;
    alertasObjt['segmento'] = segmento;
    alertasObjt['year'] = year;
    alertasObjt['departamento'] = departamento;
    alertasObjt['ciudad'] = ciudad;
    alertasObjt['region'] = regional;
    alertasObjt['pregunta'] = idPregunta;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/

      final response = await post(Uri.parse(baseURLCaracterizacionDashboard),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;

      
    } catch (e) {
      print(e);
    }
  }

  //Peticion de infancia
 
  Future<Map<String, dynamic>?> getCaracterizacionInfancia(
    String year,
    String pregunta,
    String opcion,
    String orden,
  ) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    alertasObjt['year'] = year;
    alertasObjt['pregunta'] = pregunta;
    alertasObjt['opcion'] = opcion;
    alertasObjt['forma_orden'] = orden;

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/

      final response = await post(
          Uri.parse(baseURLCaracterizacionDashboardInfancia),
          headers: {"Accept": "application/json"},
          body: alertasObjt);
      print(response.body);
      
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getSolicitudes(
    String segmento,
    String year,
    String departamento,
    String ciudad,
    String regional,
  ) async {
    var alertasObjt = new Map<String, dynamic>();

    NetworkServiceEndpoint endpoint = NetworkServiceEndpoint();

    var url = await endpoint.getEndPoint(
        Preferences.entidadUsuario, "Select", "Consulta");

    alertasObjt['segmento'] = segmento;
    alertasObjt['year'] = year;
    alertasObjt['departamento'] = departamento;
    alertasObjt['municipio'] = ciudad;
    alertasObjt['region'] = regional;
    alertasObjt['tipo_solicitud'] = "CANAL";

    try {
      /*
      final response = await post(Uri.parse(baseURLTest),
          headers: {"Accept": "application/json"}, body: alertasObjt);*/

      final response = await post(Uri.parse(solicitudesUrl),
          headers: {"Accept": "application/json"}, body: alertasObjt);
      print(response.body);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }
}
