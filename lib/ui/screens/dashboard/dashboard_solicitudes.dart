// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:infancia/domain/theme/utils.dart';
// // import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
// // import 'package:searchfield/searchfield.dart';
// // import 'package:vesta_flutter/Blocs/DashBoard/dash_board_bloc.dart';
// // import 'package:vesta_flutter/Blocs/DashBoardCombos/dash_board_combos_bloc.dart';
// // import 'package:vesta_flutter/Blocs/DashboardCombosSolicitudes/dashboard_combos_solicitudes_bloc.dart';
// // import 'package:vesta_flutter/Blocs/DashboardSolicitudes/dash_board_solicitudes_bloc.dart';
// // import 'package:vesta_flutter/models/conteoCasos_anual.dart';
// // import 'package:vesta_flutter/models/dashboard_solicitud.dart';
// // import 'package:vesta_flutter/repositorry/dashboard_repository.dart';

// // import '../../../Utils.dart';
// // import '../../../network/dashboard_service.dart';
// // import '../../../preferences.dart';

// String valueYear = "2024";
// String valueSegmento = "1";
// String valueCodeSegemnto = "G";

// String valueRegional = "";
// String valueDepartamento = "";
// String valueMunicipio = "";

// String textoTotal = "";

// bool depa = false;
// bool mun = false;
// bool reg = false;

// //Bools de criterios
// bool violenciaLey = true;
// bool otrasManifestaciones = false;
// bool trataPersonas = false;
// bool presuntoAgresor = false;
// bool caracteri = false;

// //ValuesSubcriterios
// String valueCriterio = "1";
// String valueVariables = "55";

// class DashboardAppSolicitudes extends StatefulWidget {
//   @override
//   State<DashboardAppSolicitudes> createState() => _DashboardAppState();
// }

// class _DashboardAppState extends State<DashboardAppSolicitudes> {
//   // final DashBoardSolicitudesBloc dashBoardBloc = DashBoardSolicitudesBloc(
//   //     dashBoardRepository:
//   //         DashBoardRepository(networkService: DashBoardService()));

//   // final DashboardCombosSolicitudesBloc dashBoardCombosBloc =
//   //     DashboardCombosSolicitudesBloc(
//   //         dashBoardRepository:
//   //             DashBoardRepository(networkService: DashBoardService()));

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   dashBoardBloc.add(getConteoSolicitudes(
//   //     year: "2024",
//   //     segmento: "G",
//   //     regional: "",
//   //     departamento: "",
//   //     municipio: "",
//   //     reg: false,
//   //     depa: false,
//   //   ));
//   //   dashBoardCombosBloc.add(getCombosSolicitudes());
//   // }

//   //LISTA DE CRITERIOS
//   List<DropdownMenuItem<String>> itemCriterios = [
//     const DropdownMenuItem(
//         child: Text(
//           "Violencia basada en genero ley 1257/2008",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "1"),
//     const DropdownMenuItem(
//         child: Text(
//           "Otras manifestaciones violencias",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "2"),
//     const DropdownMenuItem(
//         child: Text(
//           "Trata personas",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "3"),
//     const DropdownMenuItem(
//         child: Text(
//           "Presunto agresor",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "4"),
//     const DropdownMenuItem(
//         child: Text(
//           "Caracterización",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "5"),
//   ];

//   //LISTA DE AÑOS
//   List<DropdownMenuItem<String>> itemsYear = [
//     const DropdownMenuItem(
//         child: Text(
//           "2024",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "2024"),
//     const DropdownMenuItem(
//         child: Text(
//           "2023",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "2023"),
//     const DropdownMenuItem(
//         child: Text(
//           "2022",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "3"),
//     const DropdownMenuItem(
//         child: Text(
//           "2021",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "2021"),
//     const DropdownMenuItem(
//         child: Text(
//           "2020",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "2020"),
//     const DropdownMenuItem(
//         child: Text(
//           "2019",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "2019"),
//     const DropdownMenuItem(
//         child: Text(
//           "2018",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "2018"),
//   ];

//   //LISTA DE SEGMENTO
//   List<DropdownMenuItem<String>> itemsSegmento = [
//     const DropdownMenuItem(
//         child: Text(
//           "General",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "1"),
//     const DropdownMenuItem(
//         child: Text(
//           "Regional",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "2"),
//     const DropdownMenuItem(
//         child: Text(
//           "Departamental",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "3"),
//     const DropdownMenuItem(
//         child: Text(
//           "Municipal",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "4"),
//     /*
//     const DropdownMenuItem(
//         child: Text(
//           "Casos a detalle",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "5"),*/
//   ];

//   //LISTA DE SUBCRITERIOS
//   List<DropdownMenuItem<String>> itemsVolenciaBasada = [
//     const DropdownMenuItem(
//         child: Text(
//           "Física",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "55"),
//     const DropdownMenuItem(
//         child: Text(
//           "Sexual",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "56A"),
//     const DropdownMenuItem(
//         child: Text(
//           "Patrinomial",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "58"),
//     const DropdownMenuItem(
//         child: Text(
//           "Psicológica",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "57"),
//     const DropdownMenuItem(
//         child: Text(
//           "Económica",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "59"),
//   ];

//   //Otras manifestaciones de violencia
//   List<DropdownMenuItem<String>> itemsOtrasManifestaciones = [
//     const DropdownMenuItem(
//         child: Text(
//           "Volencia intrafamiliar",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "60"),
//     const DropdownMenuItem(
//         child: Text(
//           "Feminicidio tentativa",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "61"),
//     const DropdownMenuItem(
//         child: Text(
//           "Inasistencia alimentaria",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "65"),
//     const DropdownMenuItem(
//         child: Text(
//           "Violencia vicaria",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "66"),
//     const DropdownMenuItem(
//         child: Text(
//           "Constreñimiento",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "67"),
//     const DropdownMenuItem(
//         child: Text(
//           "Hostigamiento",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "68"),
//     const DropdownMenuItem(
//         child: Text(
//           "Lesiones personales",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "69"),
//     const DropdownMenuItem(
//         child: Text(
//           "VBG en el conflico armado",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "70"),
//     const DropdownMenuItem(
//         child: Text(
//           "VBG/VPP por ejercicio liderazgo",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "76"),
//   ];

//   List<DropdownMenuItem<String>> itemsTrataPersonas = [
//     const DropdownMenuItem(
//         child: Text(
//           "Caso de trata de personas",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "90"),
//   ];

//   List<DropdownMenuItem<String>> itemsTrataPresuntoAgresor = [
//     const DropdownMenuItem(
//         child: Text(
//           "Grado de parentesco o afinidad",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "122"),
//     const DropdownMenuItem(
//         child: Text(
//           "Servidores públicos/as y autoridades",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xff202224),
//             fontFamily: 'Nunito',
//           ),
//         ),
//         value: "123"),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         // BlocProvider(
//         //   create: (context) => dashBoardBloc,
//         // ),
//         // BlocProvider(
//         //   create: (context) => dashBoardCombosBloc,
//         // ),
//       ],
//       child: BlocListener<DashBoardSolicitud•esBloc, DashBoardSolicitudesState>(
//         listener: (context, state) {
//           if (state is ErrorConsultaSolicitudes) {
//             Utils.displayDialogDenuncias(
//                 context, "Dashboard", "Ocurrio un error en la consulta", null);
//           }
//         },
//         child: Container(
//           color: Colors.white,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: 8,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             SizedBox(
//                               width: 6,
//                             ),
//                             Text(
//                               'Año',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   color: Color(0xff606263),
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 4,
//                         ),
//                         Container(
//                           width: 122,
//                           child: DropdownButtonFormField(
//                               borderRadius: BorderRadius.circular(20.0),
//                               icon: RotationTransition(
//                                 turns: AlwaysStoppedAnimation(
//                                     0.25), // Cambia este valor para ajustar la rotación
//                                 child: Icon(Icons.arrow_forward_ios_outlined,
//                                     color: Color(0xff6D62F7)),
//                               ),
//                               value: "2024",
//                               isExpanded: true,
//                               decoration: editTextDecorationDashboard(
//                                   "Clase", "", false),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   valueYear = newValue!;

//                                   dashBoardBloc.add(getConteoSolicitudes(
//                                     year: valueYear,
//                                     segmento: valueCodeSegemnto,
//                                     regional: valueRegional,
//                                     departamento: valueDepartamento,
//                                     municipio: valueMunicipio,
//                                     reg: false,
//                                     depa: false,
//                                   ));
//                                 });
//                               },
//                               items: itemsYear),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       width: 8,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             SizedBox(
//                               width: 6,
//                             ),
//                             Text(
//                               'Segmento',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   color: Color(0xff606263),
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 4,
//                         ),
//                         Container(
//                           width: 232,
//                           child: DropdownButtonFormField(
//                               icon: RotationTransition(
//                                 turns: AlwaysStoppedAnimation(
//                                     0.25), // Cambia este valor para ajustar la rotación
//                                 child: Icon(Icons.arrow_forward_ios_outlined,
//                                     color: Color(0xff6D62F7)),
//                               ),
//                               value: "1",
//                               isExpanded: true,
//                               decoration: editTextDecorationDashboard(
//                                   "Clase", "", false),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   valueSegmento = newValue!;
//                                   switch (valueSegmento) {
//                                     case "1":
//                                       //General
//                                       mun = false;
//                                       depa = false;
//                                       reg = false;
//                                       textoTotal = "";
//                                       valueCodeSegemnto = "G";

//                                       dashBoardBloc.add(getConteoSolicitudes(
//                                         year: valueYear,
//                                         segmento: valueCodeSegemnto,
//                                         regional: valueRegional,
//                                         departamento: valueDepartamento,
//                                         municipio: valueMunicipio,
//                                         reg: reg,
//                                         depa: depa,
//                                       ));

//                                       break;
//                                     case "2":
//                                       //Regional
//                                       mun = false;
//                                       depa = false;
//                                       reg = true;
//                                       valueCodeSegemnto = "R";
//                                       valueRegional = "000";

//                                       dashBoardBloc.add(getConteoSolicitudes(
//                                         year: valueYear,
//                                         segmento: valueCodeSegemnto,
//                                         regional: valueRegional,
//                                         departamento: valueDepartamento,
//                                         municipio: valueMunicipio,
//                                         reg: reg,
//                                         depa: depa,
//                                       ));

//                                       break;
//                                     case "3":
//                                       //Depar
//                                       mun = false;
//                                       depa = true;
//                                       reg = false;
//                                       valueCodeSegemnto = "D";
//                                       valueDepartamento = "000";

//                                       dashBoardBloc.add(getConteoSolicitudes(
//                                         year: valueYear,
//                                         segmento: valueCodeSegemnto,
//                                         regional: valueRegional,
//                                         departamento: valueDepartamento,
//                                         municipio: valueMunicipio,
//                                         reg: reg,
//                                         depa: depa,
//                                       ));

//                                       break;
//                                     case "4":
//                                       //Mun
//                                       mun = true;
//                                       depa = false;
//                                       reg = false;
//                                       valueCodeSegemnto = "M";

//                                       break;
//                                   }
//                                 });
//                               },
//                               items: itemsSegmento),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 Visibility(
//                     visible: reg,
//                     child: BlocBuilder<DashboardCombosSolicitudesBloc,
//                         DashboardCombosSolicitudesState>(
//                       builder: (context, state) {
//                         return state is CombosCargadosSolicitudes
//                             ? Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Text(
//                                         'Seleccionar regional',
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             color: Color(0xff606263),
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 4,
//                                   ),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 16.0),
//                                     child: Container(
//                                       width: MediaQuery.of(context).size.width,
//                                       child: DropdownButtonFormField(
//                                           borderRadius:
//                                               BorderRadius.circular(20.0),
//                                           icon: RotationTransition(
//                                             turns: AlwaysStoppedAnimation(
//                                                 0.25), // Cambia este valor para ajustar la rotación
//                                             child: Icon(
//                                                 Icons
//                                                     .arrow_forward_ios_outlined,
//                                                 color: Color(0xff6D62F7)),
//                                           ),
//                                           value: state.regionales[0].value,
//                                           isExpanded: true,
//                                           decoration:
//                                               editTextDecorationDashboard(
//                                                   "Clase", "", false),
//                                           onChanged: (String? newValue) {
//                                             setState(() {
//                                               Text myTextWidget = state
//                                                   .regionales
//                                                   .firstWhere((element) =>
//                                                       element.value == newValue)
//                                                   .child as Text;
//                                               textoTotal = myTextWidget.data!;
//                                               valueRegional = newValue!;

//                                               dashBoardBloc
//                                                   .add(getConteoSolicitudes(
//                                                 year: valueYear,
//                                                 segmento: valueCodeSegemnto,
//                                                 regional: valueRegional,
//                                                 departamento: valueDepartamento,
//                                                 municipio: valueMunicipio,
//                                                 reg: reg,
//                                                 depa: depa,
//                                               ));
//                                             });
//                                           },
//                                           items: state.regionales),
//                                     ),
//                                   )
//                                 ],
//                               )
//                             : Container();
//                       },
//                     )),
//                 Visibility(
//                     visible: depa,
//                     child: BlocBuilder<DashboardCombosSolicitudesBloc,
//                         DashboardCombosSolicitudesState>(
//                       builder: (context, state) {
//                         return state is CombosCargadosSolicitudes
//                             ? Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Text(
//                                         'Seleccionar departamento',
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             color: Color(0xff606263),
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 4,
//                                   ),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 16.0),
//                                     child: Container(
//                                       width: MediaQuery.of(context).size.width,
//                                       child: DropdownButtonFormField(
//                                           borderRadius:
//                                               BorderRadius.circular(20.0),
//                                           icon: RotationTransition(
//                                             turns: AlwaysStoppedAnimation(
//                                                 0.25), // Cambia este valor para ajustar la rotación
//                                             child: Icon(
//                                                 Icons
//                                                     .arrow_forward_ios_outlined,
//                                                 color: Color(0xff6D62F7)),
//                                           ),
//                                           value: state.departamentos[0].value,
//                                           isExpanded: true,
//                                           decoration:
//                                               editTextDecorationDashboard(
//                                                   "Clase", "", false),
//                                           onChanged: (String? newValue) {
//                                             setState(() {
//                                               Text myTextWidget = state
//                                                   .departamentos
//                                                   .firstWhere((element) =>
//                                                       element.value == newValue)
//                                                   .child as Text;
//                                               textoTotal = myTextWidget.data!;
//                                               valueDepartamento = newValue!;

//                                               dashBoardBloc
//                                                   .add(getConteoSolicitudes(
//                                                 year: valueYear,
//                                                 segmento: valueCodeSegemnto,
//                                                 regional: valueRegional,
//                                                 departamento: valueDepartamento,
//                                                 municipio: valueMunicipio,
//                                                 reg: reg,
//                                                 depa: depa,
//                                               ));
//                                             });
//                                           },
//                                           items: state.departamentos),
//                                     ),
//                                   )
//                                 ],
//                               )
//                             : Container();
//                       },
//                     )),
//                 Visibility(
//                     visible: mun,
//                     child: BlocBuilder<DashboardCombosSolicitudesBloc,
//                         DashboardCombosSolicitudesState>(
//                       builder: (context, state) {
//                         return state is CombosCargadosSolicitudes
//                             ? Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Text(
//                                         'Seleccionar municipio',
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             color: Color(0xff606263),
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 4,
//                                   ),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 16.0),
//                                     child: Container(
//                                       width: MediaQuery.of(context).size.width,
//                                       child: DropdownButtonFormField(
//                                           borderRadius:
//                                               BorderRadius.circular(20.0),
//                                           icon: RotationTransition(
//                                             turns: AlwaysStoppedAnimation(
//                                                 0.25), // Cambia este valor para ajustar la rotación
//                                             child: Icon(
//                                                 Icons
//                                                     .arrow_forward_ios_outlined,
//                                                 color: Color(0xff6D62F7)),
//                                           ),
//                                           value: state.municipios[1].value,
//                                           isExpanded: true,
//                                           decoration:
//                                               editTextDecorationDashboard(
//                                                   "Clase", "", false),
//                                           onChanged: (String? newValue) {
//                                             setState(() {
//                                               Text myTextWidget = state
//                                                   .municipios
//                                                   .firstWhere((element) =>
//                                                       element.value == newValue)
//                                                   .child as Text;
//                                               textoTotal = myTextWidget.data!;
//                                               valueDepartamento =
//                                                   newValue!.split("_")[1];
//                                               valueMunicipio =
//                                                   newValue!.split("_")[0];

//                                               dashBoardBloc
//                                                   .add(getConteoSolicitudes(
//                                                 year: valueYear,
//                                                 segmento: valueCodeSegemnto,
//                                                 regional: valueRegional,
//                                                 departamento: valueDepartamento,
//                                                 municipio: valueMunicipio,
//                                                 reg: reg,
//                                                 depa: depa,
//                                               ));
//                                             });
//                                           },
//                                           items: state.municipios),
//                                     ),
//                                   )
//                                 ],
//                               )
//                             : Container();
//                       },
//                     )),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Container(
//                     //height: 484,
//                     width: MediaQuery.of(context).size.width,
//                     child: BlocBuilder<DashBoardSolicitudesBloc,
//                         DashBoardSolicitudesState>(
//                       builder: (context, state) {
//                         return state is getGeneralResultSolicitudes
//                             ? Card(
//                                 surfaceTintColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                                 elevation: 10.0,
//                                 child: Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 10,
//                                         right: 10,
//                                         bottom: 10,
//                                         top: 10),
//                                     child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Container(
//                                                 width:
//                                                     44.0, // El ancho del círculo
//                                                 height:
//                                                     44.0, // La altura del círculo
//                                                 decoration: BoxDecoration(
//                                                   shape: BoxShape
//                                                       .circle, // Establece la forma como círculo
//                                                   color: Color(
//                                                       0xff6D62F7), // Establece el color del círculo
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 16,
//                                               ),
//                                               Text(
//                                                 'Total ',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               Text(
//                                                 textoTotal,
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               Spacer(),
//                                               Text(
//                                                 state.total,
//                                                 style: TextStyle(
//                                                     fontSize: 32,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontFamily: 'Nunito',
//                                                     color: Color(0xff6D62F7)),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 16,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Ene',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "1",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes, "1"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Feb',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "2",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes, "2"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Mar',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "3",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes, "3"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Abr',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "4",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes, "4"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'May',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "5",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes, "5"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Jun',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "6",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes, "6"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Jul',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "7",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes, "7"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Ago',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "8",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes, "8"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Sep',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "9",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes, "9"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Oct',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "10",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes,
//                                                     "10"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Nov',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "11",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes,
//                                                     "11"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Dic',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   child: GFProgressBar(
//                                                       lineHeight: 8,
//                                                       percentage: getPorcentaje(
//                                                           state.datoSolicitudes,
//                                                           "12",
//                                                           int.parse(
//                                                               state.total)),
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       progressBarColor:
//                                                           Color(0xffE4E4FF))),
//                                               Text(
//                                                 getCantidad(
//                                                     state.datoSolicitudes,
//                                                     "12"),
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ])))
//                             : state is getGeneralSolicitudes
//                                 ? Center(
//                                     child: Container(
//                                       width: 50,
//                                       height: 50,
//                                       child: CircularProgressIndicator(),
//                                     ),
//                                   )
//                                 : Container();
//                       },
//                     ),
//                   ),
//                 ),
//                 /*
//                     Padding(
//                       padding: EdgeInsets.all(12.0),
//                       child: SearchField<String>(
//                         suggestions: listC
//                             .map(
//                               (e) => SearchFieldListItem<String>(
//                                 e,
//                                 item: e,
//                                 // Use child to show Custom Widgets in the suggestions
//                                 // defaults to Text widget
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text(e),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     ),
//                     SearchField<String>(
//                       suggestions: listC
//                           .map(
//                             (e) => SearchFieldListItem<String>(
//                               e,
//                               item: e,
//                               // Use child to show Custom Widgets in the suggestions
//                               // defaults to Text widget
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(e),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//                           .toList(),
//                     )*/
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   String getSumaTotal(List<ConteoAnualModel> datoVarariables) {
//     int sum = 0;
//     for (var item in datoVarariables) {
//       sum = sum + int.parse(item.cantidad);
//     }
//     return Utils.formatearNumero(sum).toString();
//   }

//   double getPorcentaje(
//       List<DasboardSolicitudes> datoVarariables, String mes, int total) {
//     //var suma = getSumaTotal(datoVarariables).replaceFirst(",", "");
//     if (total == 0) {
//       return 0;
//     } else {
//       for (var item in datoVarariables) {
//         if (item.numero_mes == int.parse(mes)) {
//           return (double.parse(item.cantidad.toString()) /
//               double.parse(total.toString()));
//         }
//       }
//     }

//     return 0;
//   }

//   String getCantidad(List<DasboardSolicitudes> datoVarariables, String mes) {
//     for (var item in datoVarariables) {
//       if (item.numero_mes == int.parse(mes)) {
//         return item.cantidad.toString();
//       }
//     }
//     return "0";
//   }
// }

// InputDecoration editTextDecorationDashboard(
//     String hint, String helperText, bool state) {
//   return InputDecoration(
//       helperText: helperText,
//       filled: true,
//       fillColor: Colors.white,
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(8)),
//         borderSide: BorderSide(
//             width: 1, color: Utils().getColorFromHex(Preferences.colorEntidad)),
//       ),
//       disabledBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(8)),
//         borderSide: BorderSide(width: 1, color: Color(0xff6D62F7)),
//       ),
//       enabledBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(8)),
//         borderSide: BorderSide(width: 1, color: Color(0xff6D62F7)),
//       ),
//       border: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//           borderSide: BorderSide(
//             width: 1,
//           )),
//       errorBorder: state
//           ? const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               borderSide: BorderSide(width: 2, color: Colors.red))
//           : null,
//       focusedErrorBorder: state
//           ? const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(4)),
//               borderSide: BorderSide(width: 2, color: Colors.red))
//           : null,
//       hintText: hint,
//       hintStyle: const TextStyle(fontSize: 16, color: Color(0xFF6D62F7)),
//       errorText: state ? "Campo obligatorio" : null);
// }
