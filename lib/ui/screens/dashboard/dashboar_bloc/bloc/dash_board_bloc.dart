import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infancia/domain/models/conteo_casos_anual.dart';
// import 'package:infancia/domain/models/dash_caracte_model.dart';
// import 'package:infancia/domain/models/dashboard_infancia.dart';
import 'package:infancia/domain/network/dashboard_service.dart';
// import 'package:infancia/domain/repository/dashboard_repository.dart';
// import 'package:infancia/domain/theme/utils.dart';
// import 'package:vesta_flutter/Utils.dart';
// import 'package:vesta_flutter/models/dash_caracte_model.dart';
// import 'package:vesta_flutter/repositorry/dashboard_repository.dart';

// import '../../models/conteoCasos_anual.dart';

part 'dash_board_event.dart';
part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  final DashBoardService dashBoardService;

  DashBoardBloc({required this.dashBoardService}) : super(DashBoardInitial()) {
    on<getConteoInfancia>((event, emit) async {
      emit(DataLoading());

      try {
        final data = await dashBoardService.getCaracterizacionInfancia(
            event.year, event.pregunta, event.opcion, event.forma_orden);

        emit(DataLoaded(data: data!));
      } catch (e) {
        emit(ErrorState(error: e.toString()));

        print('??! ${e.toString()}');
      }

      // Map<String, dynamic>? conteoCaracterizacion =
      //     await dashBoardRepository.getConteoinfancia(
      //   event.year,
      //   event.pregunta,
      //   event.opcion,
      //   event.forma_orden,
      // );

      //         for (int i = 0; i < variableMap.length; i++) {
      //   //var conteoCaract = DasboardCaracter.fromJson(variableData[i]);
      //   //conteoFisicaList.add(conteoCaract);
      //   var dataCantidad = variableMap![i] as Map<String, dynamic>?;
      //   var rowWidget = Row(
      //     children: [
      //       Text(
      //         Utils.decodificarElemento(dataCantidad?["nameVal"]),
      //         style: const TextStyle(
      //           fontWeight: FontWeight.bold,
      //           color: Color(0xff202224),
      //           fontFamily: 'Nunito',
      //         ),d
      //       ),
      //       const Spacer(),
      //       Text(
      //         Utils.formatearNumero(int.parse(dataCantidad?["cant idad"])),
      //         style: const TextStyle(
      //           fontWeight: FontWeight.bold,
      //           color: Color(0xff202224),
      //           fontFamily: 'Nunito',
      //         ),
      //       )
      //     ],
      //   );
      //   widgetConteoTodas.add(rowWidget);
      // }
    });

    // on<getConteoCasosVariables>((event, emit) async {
    //   // TODO: implement event handler

    //   emit(getGeneral());

    //   Map<String, dynamic>? conteosCasos =
    //       await dashBoardRepository.getVariablesByYearAndMonth(
    //           event.variable,
    //           event.year,
    //           event.regional,
    //           event.departamento,
    //           event.municipio,
    //           event.reg,
    //           event.depa,
    //           event.mun,
    //           event.violenciaLey,
    //           event.violenciaOtras,
    //           event.trata);

    //   var variableMap = conteosCasos!["info"] as List<dynamic>;

    //   if (event.reg && event.regional == "000" ||
    //       event.depa && event.departamento == "000") {
    //     //Listado de todas departamento o municpio
    //     List<Widget> widgetConteoTodas = [];

    //     var widgetTotal = Row(
    //       children: [
    //         Container(
    //           width: 44.0, // El ancho del círculo
    //           height: 44.0, // La altura del círculo
    //           decoration: const BoxDecoration(
    //             shape: BoxShape.circle, // Establece la forma como círculo
    //             color: Color(0xff6D62F7), // Establece el color del círculo
    //           ),
    //         ),
    //         const SizedBox(
    //           width: 16,
    //         ),
    //         const Text(
    //           "Total",
    //           style: TextStyle(
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold,
    //             fontFamily: 'Nunito',
    //           ),
    //         ),
    //         const Spacer(),
    //         Text(
    //           getSumaTotalTodas(variableMap),
    //           style: const TextStyle(
    //               fontSize: 32,
    //               fontWeight: FontWeight.bold,
    //               fontFamily: 'Nunito',
    //               color: Color(0xff6D62F7)),
    //         )
    //       ],
    //     );

    //     widgetConteoTodas.add(widgetTotal);
    //     widgetConteoTodas.add(const SizedBox(
    //       height: 16,
    //     ));

    //     for (int i = 0; i < variableMap.length; i++) {
    //       //var conteoCaract = DasboardCaracter.fromJson(variableData[i]);
    //       //conteoFisicaList.add(conteoCaract);
    //       var dataCantidad = variableMap![i] as Map<String, dynamic>?;
    //       var rowWidget = Row(
    //         children: [
    //           Text(
    //             Utils.decodificarElemento(dataCantidad?["nameVal"]),
    //             style: const TextStyle(
    //               fontWeight: FontWeight.bold,
    //               color: Color(0xff202224),
    //               fontFamily: 'Nunito',
    //             ),
    //           ),
    //           const Spacer(),
    //           Text(
    //             Utils.formatearNumero(int.parse(dataCantidad?["cantidad"])),
    //             style: const TextStyle(
    //               fontWeight: FontWeight.bold,
    //               color: Color(0xff202224),
    //               fontFamily: 'Nunito',
    //             ),
    //           )
    //         ],
    //       );
    //       widgetConteoTodas.add(rowWidget);
    //     }

    //     emit(getGeneralResultTodas(widgetConteoTodas));
    //   } else {
    //     //Normal, listado mensual
    //     List<ConteoAnualModel> conteoFisicaList = [];
    //     for (int i = 0; i < variableMap.length; i++) {
    //       var conteovar = ConteoAnualModel.fromJson(variableMap[i]);
    //       conteoFisicaList.add(conteovar);
    //     }
    //     emit(getGeneralResult(conteoFisicaList));
    //   }
    // });

    // on<getConteoCaracterizacion>((event, emit) async {
    //   emit(getGeneral());

    //   Map<String, dynamic>? conteoCaracterizacion =
    //       await dashBoardRepository.getConteoCaracterizacion(
    //           event.criterio,
    //           event.segmento,
    //           event.year,
    //           event.departamento,
    //           event.municipio,
    //           event.regional,
    //           event.pregunta);

    //   if (event.reg && event.regional == "000" ||
    //       event.depa && event.departamento == "000") {
    //     //Obtener Todas de regional o departamento

    //     var variableStatus = conteoCaracterizacion!["Status"];
    //     if (variableStatus == "True") {
    //       var variableMap =
    //           conteoCaracterizacion!["info"] as Map<String, dynamic>?;
    //       var variableData = variableMap!["data"] as List<dynamic>;

    //       List<DasboardCaracter> conteoFisicaList = [];
    //       List<Widget> widgetConteo = [];

    //       var widgetTotal = Row(
    //         children: [
    //           Container(
    //             width: 44.0, // El ancho del círculo
    //             height: 44.0, // La altura del círculo
    //             decoration: const BoxDecoration(
    //               shape: BoxShape.circle, // Establece la forma como círculo
    //               color: Color(0xff6D62F7), // Establece el color del círculo
    //             ),
    //           ),
    //           const SizedBox(
    //             width: 16,
    //           ),
    //           const Text(
    //             "Total",
    //             style: TextStyle(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               fontFamily: 'Nunito',
    //             ),
    //           ),
    //           const Spacer(),
    //           Text(
    //             getSumaTotalTodasCaractetiza(variableData),
    //             style: const TextStyle(
    //                 fontSize: 32,
    //                 fontWeight: FontWeight.bold,
    //                 fontFamily: 'Nunito',
    //                 color: Color(0xff6D62F7)),
    //           )
    //         ],
    //       );

    //       widgetConteo.add(widgetTotal);
    //       widgetConteo.add(const SizedBox(
    //         height: 16,
    //       ));
    //       for (int i = 0; i < variableData.length; i++) {
    //         //var conteoCaract = DasboardCaracter.fromJson(variableData[i]);
    //         var dataCantidad = variableData![i] as Map<String, dynamic>?;

    //         //conteoFisicaList.add(conteoCaract);
    //         //Titulos
    //         var rowWidgetTituloReg = Row(
    //           children: [
    //             Text(
    //               Utils.decodificarElemento(
    //                   dataCantidad?["nombre_ubicacion"] ?? 'no'),
    //               style: const TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold,
    //                 color: Color(0xff202224),
    //                 fontFamily: 'Nunito',
    //               ),
    //             ),
    //           ],
    //         );
    //         widgetConteo.add(rowWidgetTituloReg);

    //         //Respuestas
    //         var variableDataRespuestas =
    //             dataCantidad!["opciones"] as List<dynamic>;

    //         for (int i = 0; i < variableDataRespuestas.length; i++) {
    //           var dataCantidad =
    //               variableDataRespuestas![i] as Map<String, dynamic>?;

    //           var rowWidgetRespuestas;
    //           if (event.criterio == 'A') {
    //             //Pongo el padding
    //             rowWidgetRespuestas = Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: Row(
    //                 children: [
    //                   Expanded(
    //                       child: Text(
    //                     Utils.decodificarElemento(
    //                         dataCantidad?["nombre_opcion"] ?? 'no'),
    //                     style: const TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                         color: Color(0xff202224),
    //                         fontFamily: 'Nunito'),
    //                   )),
    //                   const Spacer(),
    //                   Text(
    //                     Utils.formatearNumero(
    //                         dataCantidad?["cantidad"] ?? 'no'),
    //                     style: const TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       color: Color(0xff202224),
    //                       fontFamily: 'Nunito',
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             );
    //           } else {
    //             rowWidgetRespuestas = Row(
    //               children: [
    //                 const SizedBox(
    //                   width: 10,
    //                 ),
    //                 Text(
    //                     Utils.decodificarElemento(
    //                         dataCantidad?["nombre_opcion"] ?? 'no'),
    //                     style: const TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       color: Color(0xff202224),
    //                       fontFamily: 'Nunito',
    //                     ),
    //                     softWrap: true),
    //                 const Spacer(),
    //                 Text(
    //                   Utils.formatearNumero(dataCantidad?["cantidad"] ?? 'no'),
    //                   style: const TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Color(0xff202224),
    //                     fontFamily: 'Nunito',
    //                   ),
    //                 )
    //               ],
    //             );
    //           }

    //           widgetConteo.add(rowWidgetRespuestas);
    //         }
    //         widgetConteo.add(
    //           const SizedBox(
    //             height: 10,
    //           ),
    //         );
    //       }
    //       emit(getGeneralConteoCaracterizacion(widgetConteo));
    //     } else {
    //       emit(ErrorConsulta());
    //     }
    //   } else {
    //     var variableStatus = conteoCaracterizacion!["Status"];
    //     if (variableStatus == "True") {
    //       var variableMap =
    //           conteoCaracterizacion!["info"] as Map<String, dynamic>?;
    //       var variableData = variableMap!["data"] as List<dynamic>;

    //       List<DasboardCaracter> conteoFisicaList = [];
    //       List<Widget> widgetConteo = [];

    //       var widgetTotal = Row(
    //         children: [
    //           Container(
    //             width: 44.0, // El ancho del círculo
    //             height: 44.0, // La altura del círculo
    //             decoration: const BoxDecoration(
    //               shape: BoxShape.circle, // Establece la forma como círculo
    //               color: Color(0xff6D62F7), // Establece el color del círculo
    //             ),
    //           ),
    //           const SizedBox(
    //             width: 16,
    //           ),
    //           const Text(
    //             "Total",
    //             style: TextStyle(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               fontFamily: 'Nunito',
    //             ),
    //           ),
    //           const Spacer(),
    //           Text(
    //             event.criterio == 'A'
    //                 ? getSumaTotalAgresor(variableData)
    //                 : getSumaTotal(variableData),
    //             style: const TextStyle(
    //                 fontSize: 32,
    //                 fontWeight: FontWeight.bold,
    //                 fontFamily: 'Nunito',
    //                 color: Color(0xff6D62F7)),
    //           )
    //         ],
    //       );

    //       widgetConteo.add(widgetTotal);
    //       widgetConteo.add(const SizedBox(
    //         height: 16,
    //       ));
    //       //Controlo si es Agresor o normal
    //       if (event.criterio == 'A') {
    //         //Agresor
    //         for (int i = 0; i < variableData.length; i++) {
    //           //var conteoCaract = DasboardCaracter.fromJson(variableData[i]);
    //           var dataAgresor = variableData![i] as Map<String, dynamic>?;

    //           //conteoFisicaList.add(conteoCaract);
    //           var rowWidget = Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                     child: Text(
    //                   Utils.decodificarElemento(dataAgresor?["opcion"]),
    //                   style: const TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       color: Color(0xff202224),
    //                       fontFamily: 'Nunito'),
    //                 )),
    //                 const Spacer(),
    //                 Text(
    //                   Utils.formatearNumero(
    //                       int.parse(dataAgresor?["cantidad"])),
    //                   style: const TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Color(0xff202224),
    //                     fontFamily: 'Nunito',
    //                   ),
    //                 )
    //               ],
    //             ),
    //           );
    //           widgetConteo.add(rowWidget);
    //         }
    //       } else {
    //         //Normal
    //         for (int i = 0; i < variableData.length; i++) {
    //           var conteoCaract = DasboardCaracter.fromJson(variableData[i]);
    //           conteoFisicaList.add(conteoCaract);
    //           var rowWidget = Row(
    //             children: [
    //               Text(
    //                 Utils.decodificarElemento(conteoCaract.nombre_opcion),
    //                 style: const TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   color: Color(0xff202224),
    //                   fontFamily: 'Nunito',
    //                 ),
    //               ),
    //               const Spacer(),
    //               Text(
    //                 Utils.formatearNumero(conteoCaract.cantidad),
    //                 style: const TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   color: Color(0xff202224),
    //                   fontFamily: 'Nunito',
    //                 ),
    //               )
    //             ],
    //           );
    //           widgetConteo.add(rowWidget);
    //         }
    //       }

    //       emit(getGeneralConteoCaracterizacion(widgetConteo));
    //     } else {
    //       emit(ErrorConsulta());
    //     }
    //   }
    // });
  }
  // String getSumaTotal(List<dynamic> datoVarariables) {
  //   int sum = 0;
  //   for (int i = 0; i < datoVarariables.length; i++) {
  //     var conteoCaract = DasboardCaracter.fromJson(datoVarariables[i]);

  //     sum = sum + conteoCaract.cantidad;
  //   }
  //   return Utils.formatearNumero(sum).toString();
  // }

  // String getSumaTotalAgresor(List<dynamic> datoVarariables) {
  //   int sum = 0;
  //   for (int i = 0; i < datoVarariables.length; i++) {
  //     var dataCantidad = datoVarariables![i] as Map<String, dynamic>?;

  //     sum = sum + int.parse(dataCantidad?["cantidad"]);
  //   }
  //   return Utils.formatearNumero(sum).toString();
  // }

  // String getSumaTotalTodas(List<dynamic> datoVarariables) {
  //   int sum = 0;
  //   for (int i = 0; i < datoVarariables.length; i++) {
  //     var dataCantidad = datoVarariables![i] as Map<String, dynamic>?;

  //     sum = sum + int.parse(dataCantidad?["cantidad"]);
  //   }
  //   return Utils.formatearNumero(sum).toString();
  // }

  // String getSumaTotalTodasCaractetiza(List<dynamic> datoVarariables) {
  //   int sum = 0;
  //   for (int i = 0; i < datoVarariables.length; i++) {
  //     var dataCantidad = datoVarariables![i] as Map<String, dynamic>?;
  //     int total = dataCantidad?["total"];
  //     sum = sum + total;
  //   }
  //   return Utils.formatearNumero(sum).toString();
}
