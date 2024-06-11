import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:infancia/domain/models/add_victima.dart';
import 'package:infancia/domain/models/blur_model.dart';
import 'package:infancia/domain/models/registro_victimas.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/registro/bloc/registros_funcionario_bloc.dart';

class CardListRegistroFuncionario extends StatelessWidget {
  final List<RegistroFuncionaroVictimas> registrosFuncionario;
  final List<BlurCampos> blurCampos;

  final RegistrosFuncionarioBloc registrosFuncionarioBloc;

  const CardListRegistroFuncionario(this.registrosFuncionario,
      this.registrosFuncionarioBloc, this.blurCampos, {super.key});

  @override
  Widget build(BuildContext context) {
    int validados = getValidadosCount(registrosFuncionario);
    return Flexible(
      child: Container(
      
        child: Stack(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: registrosFuncionario.length,
              itemBuilder: (BuildContext context, int index) {
                return RegistroFuncionarioCard(
                  registroInfo: registrosFuncionario[index],
                  registrosFuncionarioBloc: registrosFuncionarioBloc,
                  blurCampos: blurCampos,
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            //Añadir funcionario
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        shape: const CircleBorder(),
                        heroTag: "addVic",
                        onPressed: () async {
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddVictima()));
                      
                          registrosFuncionarioBloc.add(getRegistrosIniciales());
                        },
                        backgroundColor: Utils().getColorFromHex("#6699FF"),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    
                  ],
                ),
             
              ],
            ),

            //Mostrar grafico
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         FloatingActionButton(
            //           shape: const CircleBorder(),
            //           heroTag: "stats",
            //           onPressed: () {
            //             Navigator.of(context).push(MaterialPageRoute(
            //                 builder: (context) =>
            //                     // GraficaPage(registrosFuncionario, validados)
            //                     Container()));
            //           },
            //           backgroundColor: Utils().getColorFromHex("#6699FF"),
            //           child: const Icon(
            //             Icons.bar_chart,
            //             color: Colors.white,
            //           ),
            //         ),
            //         const SizedBox(height: 20)
            //       ],
            //     ),
            //     const SizedBox(width: 10)
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  int getValidadosCount(List<RegistroFuncionaroVictimas> registrosFuncionario) {
    int countValidadas = 0;
    for (int i = 0; i < registrosFuncionario.length; i++) {
      var registro = registrosFuncionario[i];
      if (registro.estado == "V") {
        countValidadas++;
      }
    }
    return countValidadas;
  }
}

//Card de Trata de personas
class RegistroFuncionarioCard extends StatelessWidget {
  final RegistroFuncionaroVictimas registroInfo;
  final RegistrosFuncionarioBloc registrosFuncionarioBloc;
  final List<BlurCampos> blurCampos;

  const RegistroFuncionarioCard(
      {super.key, required this.registroInfo,
      required this.registrosFuncionarioBloc,
      required this.blurCampos});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: const BorderSide(color: Colors.white, width: 3)
              
              ),
          elevation: 12.0,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Blur(
                      blur: getBlurValue(blurCampos, "txtNombreCompleto")
                          ? 0
                          : 4.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [ 
                          Flexible(
                            child: Text(
                              "${Utils.decodificarElemento(registroInfo.nombre!)} ${Utils.decodificarElemento(registroInfo.apellidos!)}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Utils().getColorFromHex(
                                      Preferences.colorEntidad)
                                      
                                      ),
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () async {
                          //     await Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               EditarVictimaFuncionario(
                          //                 registroFuncionaroVictimas:
                          //                     registroInfo,
                          //               )),
                          //     );
                          //     registrosFuncionarioBloc
                          //         .add(getRegistrosIniciales());
                          //   },
                          //   child: Icon(
                          //     Icons.edit,
                          //     color: Utils()
                          //         .getColorFromHex(Preferences.colorEntidad),
                          //   ),
                          // )
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Flexible(
                        child: Text(
                          "Identificación:",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Blur(
                            blur: getBlurValue(blurCampos, "txtIdentificacion")
                                ? 0
                                : 4.0,
                            child: Text(
                              '${registroInfo.id}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Flexible(
                        child: Text(
                          "Teléfono:",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Blur(
                            blur: getBlurValue(blurCampos, "txtIdentificacion")
                                ? 0
                                : 4.0,
                            child: Text(
                              registroInfo.celular!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            )
                            
                            ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Flexible(
                        child: Text(
                          "Municipio",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          '${registroInfo.nameMunicipio}, ${registroInfo.nameDepartamento}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              color: Utils()
                                  .getColorFromHex(Preferences.colorEntidad)),
                        ),
                      )
                    ],
                  ),
                  /*
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Estadoa:",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        '${getEstadoText(registroInfo.estado.toString())}',
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 12, color: Preferences.entidadUsuario == "8001860611"
                  ? Color(0xff005FCE)
                  : Color(0xffFF2B66)),
                      ),
                    )
                  ],
                ),*/
                  const SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Container()
                    // TextButton(
                    //   onPressed: registroInfo.estado == "V"
                    //       ? () async {
                    //           await Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => CaracterizacionMain(
                    //                       idVictima: registroInfo.id!,
                    //                     )),
                    //           );
                    //           registrosFuncionarioBloc
                    //               .add(getRegistrosIniciales());
                    //         }
                    //       : () async {
                    //           await Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => //MyListTest()
                    //                     EntrevistaMain(
                    //                       id: registroInfo.id!,
                    //                       names: registroInfo.nombre!,
                    //                       apellidos: registroInfo.apellidos!,
                    //                     )),
                    //           );
                    //           registrosFuncionarioBloc
                    //               .add(getRegistrosIniciales());
                    //         },
                    //   child: Text(
                    //     registroInfo.estado == "V"
                    //         ? "Caracterizado"
                    //         : "Caracterizar",
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       color: registroInfo.estado == "V"
                    //           ? Utils()
                    //               .getColorFromHex(Preferences.colorEntidad)
                    //           : Utils()
                    //               .getColorFromHex(Preferences.colorEntidad),
                    //     ),
                    //   ),
                  ])
                  /*
                    TextButton(
                        onPressed: () async {
                          final complete = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BeneficiosMain(
                                      idVictima: registroInfo.id!,
                                    )),
                          );
                          registrosFuncionarioBloc.add(getRegistrosIniciales());
                        },
                        child: Text(
                          "Beneficios",
                          style: TextStyle(
                            fontSize: 16,
                            color: Preferences.entidadUsuario == "8001860611"
                                ? Color(0xff014898)
                                : Color(0xffFF2B66),
                          ),
                        )),*/
                ],
              )),
        ),
      ),
    );
  }
}

bool getBlurValue(List<BlurCampos> blurCampos, String campoId) {
  if (blurCampos.isEmpty) {
    //Esvacio. No tiene blur ni de usuario ni de entidad
    return true;
  } else {
    for (var item in blurCampos) {
      if (item.idCampoTexto == campoId) {
        switch (item.valor) {
          case "True":
            return true;
          case "False":
            return false;
        }
      }
    }
    return true;
  }
}

String getName(String? nombre) {
  if (nombre == "null" ||
      nombre == "" ||
      nombre == null ||
      nombre.contains("null")) {
    return "No registra";
  } else {
    return nombre;
  }
}

String getEstadoText(String estado) {
  switch (estado) {
    case "EV":
      return "En validación";
    case "V":
      return "Validada";

    case "R":
      return "Rechazada";
    default:
      return "";
  }
}

String _decodificarElemento(String descripcion) {
  var decode = descripcion;

  decode = decode.replaceAll("_INTEc_", "?");
  decode = decode.replaceAll("_at_", "\u00e1");
  decode = decode.replaceAll("_et_", "\u00e9");
  decode = decode.replaceAll("_it_", "\u00ed");
  decode = decode.replaceAll("_ot_", "\u00f3");
  decode = decode.replaceAll("_ut_", "\u00fa");
  decode = decode.replaceAll("_At_", "\u00c1");
  decode = decode.replaceAll("_Et_", "\u00c9");
  decode = decode.replaceAll("_It_", "\u00cd");
  decode = decode.replaceAll("_Ot_", "\u00d3");
  decode = decode.replaceAll("_Ut_", "\u00da");
  decode = decode.replaceAll("\u00c3¡", "\u00e1");
  decode = decode.replaceAll("\u00c3©", "\u00e9");
  decode = decode.replaceAll("\u00c3\u00ad", "\u00ed");
  decode = decode.replaceAll("\u00c3³", "\u00f3");
  decode = decode.replaceAll("\u00c3\u0083\u00c2³", "\u00f3");
  decode = decode.replaceAll("\u00c3º", "\u00fa");
  decode = decode.replaceAll("\u00c3±", "\u00f1");
  decode = decode.replaceAll("\u00c3?", "\u00d1");
  decode = decode.replaceAll("_enie_", "\u00f1");
  decode = decode.replaceAll("_ENIE_", "\u00d1");
  decode = decode.replaceAll("&aacute;", "\u00e1");
  decode = decode.replaceAll("&eacute;", "\u00e9");
  decode = decode.replaceAll("&iacute;", "\u00ed");
  decode = decode.replaceAll("&oacute;", "\u00f3");
  decode = decode.replaceAll("&uacute;", "\u00fa");
  decode = decode.replaceAll("&Aacute;", "\u00c1");
  decode = decode.replaceAll("&Eacute;", "\u00c9");
  decode = decode.replaceAll("&Iacute;", "\u00cd");
  decode = decode.replaceAll("&Oacute;", "\u00d3");
  decode = decode.replaceAll("&Uacute;", "\u00da");
  decode = decode.replaceAll("&ntilde;", "\u00f1");
  decode = decode.replaceAll("&Ntilde;", "\u00d1");
  decode = decode.replaceAll("\u00c2", "");
  decode = decode.replaceAll("_CD_", "''");
  decode = decode.replaceAll("_dx_", "<");
  decode = decode.replaceAll("_bx_", ">");
  decode = decode.replaceAll("_PT_", ":");
  decode = decode.replaceAll("_M_", "+");
  decode = decode.replaceAll("_I_", "=");
  decode = decode.replaceAll("_BS_", "/");
  decode = decode.replaceAll("_CS_", "'");
  decode = decode.replaceAll("_P_", "%");
  decode = decode.replaceAll("_L_", "\\");
  decode = decode.replaceAll("_A_", "&");
  decode = decode.replaceAll("_Ord_", "°");
  decode = decode.replaceAll("\\n", "<br/>");
  decode = decode.replaceAll("<br>", "\n");
  decode = decode.replaceAll("<br/>", "\n");
  return decode;
}
