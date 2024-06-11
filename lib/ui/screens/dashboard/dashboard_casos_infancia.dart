import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:infancia/domain/models/conteo_casos_anual.dart';
import 'package:infancia/domain/network/dashboard_service.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/dashboard_repository.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/dashboard/combo_bloc/bloc/dash_board_combos_bloc.dart';
import 'package:infancia/ui/screens/dashboard/dashboar_bloc/bloc/dash_board_bloc.dart';
import 'package:infancia/ui/widgets/custom_loading.dart';
// import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
// import 'package:vesta_flutter/Blocs/DashBoard/dash_board_bloc.dart';
// import 'package:vesta_flutter/Blocs/DashBoardCombos/dash_board_combos_bloc.dart';
// import 'package:vesta_flutter/models/conteoCasos_anual.dart';
// import 'package:vesta_flutter/repositorry/dashboard_repository.dart';

// import '../../../Utils.dart';
// import '../../../network/dashboard_service.dart';
// import '../../../preferences.dart';

String valueYear = "2024";
String valueSegmento = "1";
String valueCodeSegemnto = "G";
String valueCaractetizacion = "22";
String valueAgresor = "122";

String valueRegional = "";
String valueDepartamento = "";
String valueMunicipio = "";

String textoTotal = "";

bool depa = false;
bool mun = false;
bool reg = false;

//Bools de criterios
bool violenciaLey = false;
bool otrasManifestaciones = false;
bool trataPersonas = false;
bool presuntoAgresor = false;
bool caracteri = true;

//ValuesSubcriterios
String valueCriterio = "1";
String valueVariables = "55";

class DashboardAppNewInfancia extends StatefulWidget {
  @override
  State<DashboardAppNewInfancia> createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardAppNewInfancia> {
  final DashBoardBloc dashBoardBloc = DashBoardBloc(
    dashBoardService: DashBoardService(),
  );

  final DashBoardCombosBloc dashBoardCombosBloc = DashBoardCombosBloc(
      dashBoardRepository:
          DashBoardRepository(networkService: DashBoardService()));

  // @override
  // void initState() {
  //   super.initState();

  //   dashBoardBloc.add(getConteoCaracterizacion(
  //       year: valueYear,
  //       criterio: "C",
  //       segmento: valueCodeSegemnto,
  //       departamento: valueDepartamento,
  //       municipio: valueMunicipio,
  //       regional: valueRegional,
  //       pregunta: valueCaractetizacion,
  //       reg: reg,
  //       depa: depa));

  //   /*
  //   dashBoardBloc.add(getConteoCasosVariables(
  //       year: "2024",
  //       variable: "55",
  //       regional: "",
  //       departamento: "",
  //       municipio: "",
  //       reg: false,
  //       depa: false,
  //       mun: false,
  //       violenciaLey: true,
  //       violenciaOtras: false,
  //       trata: false));*/
  //   dashBoardCombosBloc.add(getCombos());
  // }

  @override
  void initState() {
    super.initState();
    dashBoardBloc.add(getConteoInfancia(
        year: valueYear, pregunta: '', opcion: '', forma_orden: ''));
  }

  //LISTA DE CRITERIOS
  List<DropdownMenuItem<String>> itemCriterios = [
    const DropdownMenuItem(
        value: "1",
        child: Text(
          "Violencia basada en genero ley 1257/2008",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "2",
        child: Text(
          "Otras manifestaciones violencias",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "3",
        child: Text(
          "Trata personas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "4",
        child: Text(
          "Presunto agresor",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "5",
        child: Text(
          "hola",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
  ];

  //LISTA DE AÑOS
  List<DropdownMenuItem<String>> itemsYear = [
    const DropdownMenuItem(
        value: "2024",
        child: Text(
          "2024",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    // const DropdownMenuItem(
    //     value: "2023",
    //     child: Text(
    //       "2023",
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xff202224),
    //         fontFamily: 'Nunito',
    //       ),
    //     )),
    // const DropdownMenuItem(
    //     value: "3",
    //     child: Text(
    //       "2022",
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xff202224),
    //         fontFamily: 'Nunito',
    //       ),
    //     )),
    // const DropdownMenuItem(
    //     value: "2021",
    //     child: Text(
    //       "2021",
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xff202224),
    //         fontFamily: 'Nunito',
    //       ),
    //     )),
    // const DropdownMenuItem(
    //     value: "2020",
    //     child: Text(
    //       "2020",
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xff202224),
    //         fontFamily: 'Nunito',
    //       ),
    //     )),
    // const DropdownMenuItem(
    //     value: "2019",
    //     child: Text(
    //       "2019",
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xff202224),
    //         fontFamily: 'Nunito',
    //       ),
    //     )),
    // const DropdownMenuItem(
    //     value: "2018",
    //     child: Text(
    //       "2018",
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xff202224),
    //         fontFamily: 'Nunito',
    //       ),
    //     )),
  ];

  //LISTA DE SEGMENTO
  List<DropdownMenuItem<String>> itemsSegmento = [
    const DropdownMenuItem(
        value: "1",
        child: Text(
          "General",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "2",
        child: Text(
          "Regional",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "3",
        child: Text(
          "Departamental",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "4",
        child: Text(
          "Municipal",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    /*
    const DropdownMenuItem(
        child: Text(
          "Casos a detalle",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        ),
        value: "5"),*/
  ];

  //LISTA DE SUBCRITERIOS
  List<DropdownMenuItem<String>> itemsVolenciaBasada = [
    const DropdownMenuItem(
        value: "55",
        child: Text(
          "Física",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "56A",
        child: Text(
          "Sexual",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "58",
        child: Text(
          "Patrinomial",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "57",
        child: Text(
          "Psicológica",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "59",
        child: Text(
          "Económica",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
  ];

  //Otras manifestaciones de violencia
  List<DropdownMenuItem<String>> itemsOtrasManifestaciones = [
    const DropdownMenuItem(
        value: "60",
        child: Text(
          "Volencia intrafamiliar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "61",
        child: Text(
          "Feminicidio tentativa",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "65",
        child: Text(
          "Inasistencia alimentaria",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "66",
        child: Text(
          "Violencia vicaria",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "67",
        child: Text(
          "Constreñimiento",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "68",
        child: Text(
          "Hostigamiento",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "69",
        child: Text(
          "Lesiones personales",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "70",
        child: Text(
          "VBG en el conflico armado",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "76",
        child: Text(
          "VBG/VPP por ejercicio liderazgo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
  ];

  List<DropdownMenuItem<String>> itemsTrataPersonas = [
    const DropdownMenuItem(
        value: "90",
        child: Text(
          "Caso de trata de personas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
  ];

  List<DropdownMenuItem<String>> itemsTrataPresuntoAgresor = [
    const DropdownMenuItem(
        value: "122",
        child: Text(
          "Grado de parentesco o afinidad",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "123",
        child: Text(
          "Servidores públicos/as y autoridades",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
  ];

  List<DropdownMenuItem<String>> itemsOrdenar = [
    const DropdownMenuItem(
        value: "1",
        child: Text(
          "Normal",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "2",
        child: Text(
          "Mayor",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
    const DropdownMenuItem(
        value: "3",
        child: Text(
          "Menor",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff202224),
            fontFamily: 'Nunito',
          ),
        )),
  ];

// Aqui empezamos a modificar para mostrar los datos de infancia
  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => dashBoardBloc,
        ),
        BlocProvider(
          create: (context) => dashBoardCombosBloc,
        ),
      ],
      child: BlocListener<DashBoardBloc, DashBoardState>(
        listener: (context, state) {
          if (state is ErrorConsulta) {
            Utils.displayDialogDenuncias(
                context, "Dashboard", "Ocurrio un error en la consulta", null);
          }
        },
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Año',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff606263),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: 122,
                                child: DropdownButtonFormField(
                                    borderRadius: BorderRadius.circular(20.0),
                                    icon: const RotationTransition(
                                      turns: AlwaysStoppedAnimation(
                                          0.25), // Cambia este valor para ajustar la rotación
                                      child: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Color(0xff6D62F7)),
                                    ),
                                    value: "2024",
                                    isExpanded: true,
                                    decoration: editTextDecorationDashboard(
                                        "Clase", "", false),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        // valueYear = newValue!;
                                        // if (caracteri || presuntoAgresor) {
                                        //   dashBoardBloc.add(getConteoCaracterizacion(
                                        //       year: valueYear,
                                        //       criterio: presuntoAgresor ? "A" : "C",
                                        //       segmento: valueCodeSegemnto,
                                        //       departamento: valueDepartamento,
                                        //       municipio: valueMunicipio,
                                        //       regional: valueRegional,
                                        //       pregunta: presuntoAgresor
                                        //           ? valueAgresor
                                        //           : valueCaractetizacion,
                                        //       reg: reg,
                                        //       depa: depa));
                                        // } else {
                                        //   dashBoardBloc.add(getConteoCasosVariables(
                                        //       year: valueYear,
                                        //       variable: valueVariables,
                                        //       regional: valueRegional,
                                        //       departamento: valueDepartamento,
                                        //       municipio: valueMunicipio,
                                        //       reg: reg,
                                        //       depa: depa,
                                        //       mun: mun,
                                        //       violenciaLey: violenciaLey,
                                        //       violenciaOtras: otrasManifestaciones,
                                        //       trata: trataPersonas));
                                        // }
                                      });
                                    },
                                    items: itemsYear),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 6,
                            ),
                            // Text(
                            //   'Segmento',
                            //   style: TextStyle(
                            //       fontSize: 12,
                            //       color: Color(0xff606263),
                            //       fontWeight: FontWeight.bold),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        // SizedBox(
                        //   width: 232,
                        //   child: DropdownButtonFormField(
                        //       icon: const RotationTransition(
                        //         turns: AlwaysStoppedAnimation(
                        //             0.25), // Cambia este valor para ajustar la rotación
                        //         child: Icon(Icons.arrow_forward_ios_outlined,
                        //             color: Color(0xff6D62F7)),
                        //       ),
                        //       value: "1",
                        //       isExpanded: true,
                        //       decoration: editTextDecorationDashboard(
                        //           "Clase", "", false),
                        //       onChanged: (String? newValue) {
                        //         setState(() {
                        //           valueSegmento = newValue!;
                        //           switch (valueSegmento) {
                        //             case "1":
                        //               //General
                        //               mun = false;
                        //               depa = false;
                        //               reg = false;
                        //               textoTotal = "";
                        //               valueCodeSegemnto = "G";

                        //               if (caracteri || presuntoAgresor) {
                        //                 dashBoardBloc.add(
                        //                     getConteoCaracterizacion(
                        //                         year: valueYear,
                        //                         criterio:
                        //                             presuntoAgresor ? "A" : "C",
                        //                         segmento: valueCodeSegemnto,
                        //                         departamento: valueDepartamento,
                        //                         municipio: valueMunicipio,
                        //                         regional: valueRegional,
                        //                         pregunta: valueCaractetizacion,
                        //                         reg: reg,
                        //                         depa: depa));
                        //               } else {
                        //                 dashBoardBloc.add(
                        //                     getConteoCasosVariables(
                        //                         year: valueYear,
                        //                         variable: valueVariables,
                        //                         regional: valueRegional,
                        //                         departamento: valueDepartamento,
                        //                         municipio: valueMunicipio,
                        //                         reg: reg,
                        //                         depa: depa,
                        //                         mun: mun,
                        //                         violenciaLey: violenciaLey,
                        //                         violenciaOtras:
                        //                             otrasManifestaciones,
                        //                         trata: trataPersonas));
                        //               }

                        //               break;
                        //             case "2":
                        //               //Regional
                        //               mun = false;
                        //               depa = false;
                        //               reg = true;
                        //               valueCodeSegemnto = "R";
                        //               valueRegional = "000";

                        //               if (caracteri || presuntoAgresor) {
                        //                 dashBoardBloc.add(
                        //                     getConteoCaracterizacion(
                        //                         year: valueYear,
                        //                         criterio:
                        //                             presuntoAgresor ? "A" : "C",
                        //                         segmento: valueCodeSegemnto,
                        //                         departamento: valueDepartamento,
                        //                         municipio: valueMunicipio,
                        //                         regional: valueRegional,
                        //                         pregunta: valueCaractetizacion,
                        //                         reg: reg,
                        //                         depa: depa));
                        //               } else {
                        //                 dashBoardBloc
                        //                     .add(getConteoCasosVariables(
                        //                   year: valueYear,
                        //                   variable: valueVariables,
                        //                   regional: valueRegional,
                        //                   departamento: valueDepartamento,
                        //                   municipio: valueMunicipio,
                        //                   reg: reg,
                        //                   depa: depa,
                        //                   mun: mun,
                        //                   violenciaLey: violenciaLey,
                        //                   violenciaOtras: otrasManifestaciones,
                        //                   trata: trataPersonas,
                        //                 ));
                        //               }

                        //               break;
                        //             case "3":
                        //               //Depar
                        //               mun = false;
                        //               depa = true;
                        //               reg = false;
                        //               valueCodeSegemnto = "D";
                        //               valueDepartamento = "000";

                        //               if (caracteri || presuntoAgresor) {
                        //                 dashBoardBloc.add(
                        //                     getConteoCaracterizacion(
                        //                         year: valueYear,
                        //                         criterio:
                        //                             presuntoAgresor ? "A" : "C",
                        //                         segmento: valueCodeSegemnto,
                        //                         departamento: valueDepartamento,
                        //                         municipio: valueMunicipio,
                        //                         regional: valueRegional,
                        //                         pregunta: valueCaractetizacion,
                        //                         reg: reg,
                        //                         depa: depa));
                        //               } else {
                        //                 dashBoardBloc.add(
                        //                     getConteoCasosVariables(
                        //                         year: valueYear,
                        //                         variable: valueVariables,
                        //                         regional: valueRegional,
                        //                         departamento: valueDepartamento,
                        //                         municipio: valueMunicipio,
                        //                         reg: reg,
                        //                         depa: depa,
                        //                         mun: mun,
                        //                         violenciaLey: violenciaLey,
                        //                         violenciaOtras:
                        //                             otrasManifestaciones,
                        //                         trata: trataPersonas));
                        //               }

                        //               break;
                        //             case "4":
                        //               //Mun
                        //               mun = true;
                        //               depa = false;
                        //               reg = false;
                        //               valueCodeSegemnto = "M";

                        //               break;
                        //           }
                        //         });
                        //       },
                        //       items: itemsSegmento),
                        // )
                      ],
                    ),
                  ],
                ),
                Visibility(
                    visible: reg,
                    child:
                        BlocBuilder<DashBoardCombosBloc, DashBoardCombosState>(
                      builder: (context, state) {
                        return state is CombosCargados
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Seleccionar regional',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff606263),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButtonFormField(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          icon: const RotationTransition(
                                            turns: AlwaysStoppedAnimation(
                                                0.25), // Cambia este valor para ajustar la rotación
                                            child: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Color(0xff6D62F7)),
                                          ),
                                          value: state.regionales[0].value,
                                          isExpanded: true,
                                          decoration:
                                              editTextDecorationDashboard(
                                                  "Clase", "", false),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              // Text myTextWidget = state
                                              //     .regionales
                                              //     .firstWhere((element) =>
                                              //         element.value == newValue)
                                              //     .child as Text;
                                              // textoTotal = myTextWidget.data!;
                                              // valueRegional = newValue!;

                                              // if (caracteri ||
                                              //     presuntoAgresor) {
                                              //   dashBoardBloc.add(
                                              //       getConteoCaracterizacion(
                                              //           year: valueYear,
                                              //           criterio:
                                              //               presuntoAgresor
                                              //                   ? "A"
                                              //                   : "C",
                                              //           segmento:
                                              //               valueCodeSegemnto,
                                              //           departamento:
                                              //               valueDepartamento,
                                              //           municipio:
                                              //               valueMunicipio,
                                              //           regional: valueRegional,
                                              //           pregunta:
                                              //               valueCaractetizacion!,
                                              //           reg: reg,
                                              //           depa: depa));
                                              // } else {
                                              //   dashBoardBloc.add(
                                              //       getConteoCasosVariables(
                                              //           year: valueYear,
                                              //           variable:
                                              //               valueVariables,
                                              //           regional: valueRegional,
                                              //           departamento:
                                              //               valueDepartamento,
                                              //           municipio:
                                              //               valueMunicipio,
                                              //           reg: reg,
                                              //           depa: depa,
                                              //           mun: mun,
                                              //           violenciaLey:
                                              //               violenciaLey,
                                              //           violenciaOtras:
                                              //               otrasManifestaciones,
                                              //           trata: trataPersonas));
                                              // }
                                            });
                                          },
                                          items: state.regionales),
                                    ),
                                  )
                                ],
                              )
                            : Container();
                      },
                    )),
                Visibility(
                    visible: depa,
                    child:
                        BlocBuilder<DashBoardCombosBloc, DashBoardCombosState>(
                      builder: (context, state) {
                        return state is CombosCargados
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Seleccionar departamento',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff606263),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButtonFormField(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          icon: const RotationTransition(
                                            turns: AlwaysStoppedAnimation(
                                                0.25), // Cambia este valor para ajustar la rotación
                                            child: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Color(0xff6D62F7)),
                                          ),
                                          value: state.departamentos[0].value,
                                          isExpanded: true,
                                          decoration:
                                              editTextDecorationDashboard(
                                                  "Clase", "", false),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              // Text myTextWidget = state
                                              //     .departamentos
                                              //     .firstWhere((element) =>
                                              //         element.value == newValue)
                                              //     .child as Text;
                                              // textoTotal = myTextWidget.data!;
                                              // valueDepartamento = newValue!;

                                              // if (caracteri ||
                                              //     presuntoAgresor) {
                                              //   dashBoardBloc.add(
                                              //       getConteoCaracterizacion(
                                              //           year: valueYear,
                                              //           criterio:
                                              //               presuntoAgresor
                                              //                   ? "A"
                                              //                   : "C",
                                              //           segmento:
                                              //               valueCodeSegemnto,
                                              //           departamento:
                                              //               valueDepartamento,
                                              //           municipio:
                                              //               valueMunicipio,
                                              //           regional: valueRegional,
                                              //           pregunta:
                                              //               valueCaractetizacion!,
                                              //           reg: reg,
                                              //           depa: depa));
                                              // } else {
                                              //   dashBoardBloc.add(
                                              //       getConteoCasosVariables(
                                              //           year: valueYear,
                                              //           variable:
                                              //               valueVariables,
                                              //           regional: valueRegional,
                                              //           departamento:
                                              //               valueDepartamento,
                                              //           municipio:
                                              //               valueMunicipio,
                                              //           reg: reg,
                                              //           depa: depa,
                                              //           mun: mun,
                                              //           violenciaLey:
                                              //               violenciaLey,
                                              //           violenciaOtras:
                                              //               otrasManifestaciones,
                                              //           trata: trataPersonas));
                                              // }
                                            });
                                          },
                                          items: state.departamentos),
                                    ),
                                  )
                                ],
                              )
                            : Container();
                      },
                    )),
                Visibility(
                    visible: mun,
                    child:
                        BlocBuilder<DashBoardCombosBloc, DashBoardCombosState>(
                      builder: (context, state) {
                        return state is CombosCargados
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Seleccionar municipio',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff606263),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButtonFormField(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          icon: const RotationTransition(
                                            turns: AlwaysStoppedAnimation(
                                                0.25), // Cambia este valor para ajustar la rotación
                                            child: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Color(0xff6D62F7)),
                                          ),
                                          value: state.municipios[1].value,
                                          isExpanded: true,
                                          decoration:
                                              editTextDecorationDashboard(
                                                  "Clase", "", false),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              // Text myTextWidget = state
                                              //     .municipios
                                              //     .firstWhere((element) =>
                                              //         element.value == newValue)
                                              //     .child as Text;
                                              // textoTotal = myTextWidget.data!;
                                              // //valueDepartamento = newValue!.split("_")[1];
                                              // valueMunicipio = newValue!;

                                              // if (caracteri ||
                                              //     presuntoAgresor) {
                                              //   dashBoardBloc.add(
                                              //       getConteoCaracterizacion(
                                              //           year: valueYear,
                                              //           criterio:
                                              //               presuntoAgresor
                                              //                   ? "A"
                                              //                   : "C",
                                              //           segmento:
                                              //               valueCodeSegemnto,
                                              //           departamento:
                                              //               valueMunicipio
                                              //                   .split("_")[1],
                                              //           municipio:
                                              //               valueMunicipio
                                              //                   .split("_")[0],
                                              //           regional: valueRegional,
                                              //           pregunta:
                                              //               valueCaractetizacion!,
                                              //           reg: reg,
                                              //           depa: depa));
                                              // } else {
                                              //   dashBoardBloc.add(
                                              //       getConteoCasosVariables(
                                              //           year: valueYear,
                                              //           variable:
                                              //               valueVariables,
                                              //           regional: valueRegional,
                                              //           departamento:
                                              //               valueDepartamento,
                                              //           municipio:
                                              //               valueMunicipio,
                                              //           reg: reg,
                                              //           depa: depa,
                                              //           mun: mun,
                                              //           violenciaLey:
                                              //               violenciaLey,
                                              //           violenciaOtras:
                                              //               otrasManifestaciones,
                                              //           trata: trataPersonas));
                                              // }
                                            });
                                          },
                                          items: state.municipios),
                                    ),
                                  )
                                ],
                              )
                            : Container();
                      },
                    )),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        // Text(
                        //   'Preguntas',
                        //   style: TextStyle(
                        //       fontSize: 12,
                        //       color: Color(0xff606263),
                        //       fontWeight: FontWeight.bold),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    //   child: SizedBox(
                    //     width: MediaQuery.of(context).size.width,
                    //     child: DropdownButtonFormField(
                    //         borderRadius: BorderRadius.circular(20.0),
                    //         icon: const RotationTransition(
                    //           turns: AlwaysStoppedAnimation(
                    //               0.25), // Cambia este valor para ajustar la rotación
                    //           child: Icon(Icons.arrow_forward_ios_outlined,
                    //               color: Color(0xff6D62F7)),
                    //         ),
                    //         value: "5",
                    //         isExpanded: true,
                    //         decoration:
                    //             editTextDecorationDashboard("Clase", "", false),
                    //         onChanged: (String? newValue) {
                    //           setState(() {
                    //             valueCriterio = newValue!;
                    //             switch (valueCriterio) {
                    //               case "1":
                    //                 violenciaLey = true;
                    //                 otrasManifestaciones = false;
                    //                 trataPersonas = false;
                    //                 presuntoAgresor = false;
                    //                 caracteri = false;

                    //                 break;
                    //               case "2":
                    //                 violenciaLey = false;
                    //                 otrasManifestaciones = true;
                    //                 trataPersonas = false;
                    //                 presuntoAgresor = false;
                    //                 caracteri = false;

                    //                 break;
                    //               case "3":
                    //                 violenciaLey = false;
                    //                 otrasManifestaciones = false;
                    //                 trataPersonas = true;
                    //                 presuntoAgresor = false;
                    //                 caracteri = false;

                    //                 break;f
                    //               case "4":
                    //                 violenciaLey = false;
                    //                 otrasManifestaciones = false;
                    //                 trataPersonas = false;
                    //                 presuntoAgresor = true;
                    //                 caracteri = false;
                    //                 break;
                    //               case "5":
                    //                 violenciaLey = false;
                    //                 otrasManifestaciones = false;
                    //                 trataPersonas = false;
                    //                 presuntoAgresor = false;
                    //                 caracteri = true;
                    //                 break;
                    //               default:
                    //             }
                    //             /*
                    //                 dashBoardBloc.add(getConteoCasosVariables(
                    //                     year: valueYear,
                    //                     variable: valueCriterio,
                    //                     regional: valueRegional,
                    //                     departamento: valueDepartamento,
                    //                     municipio: valueMunicipio,
                    //                     reg: reg,
                    //                     depa: depa,
                    //                     mun: mun));*/
                    //           });
                    //         },
                    //         items: itemCriterios),
                    //   ),
                    // )
                  ],
                ),
                //TODO DROPS AQUI
                Visibility(
                  visible: violenciaLey,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          // Text(
                          //   'Volencia basa en ley 1257/2008',
                          //   style: TextStyle(
                          //       fontSize: 12,
                          //       color: Color(0xff606263),
                          //       fontWeight: FontWeight.bold),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //   child: SizedBox(
                      //     width: MediaQuery.of(context).size.width,
                      //     child: DropdownButtonFormField(
                      //         borderRadius: BorderRadius.circular(20.0),
                      //         icon: const RotationTransition(
                      //           turns: AlwaysStoppedAnimation(
                      //               0.25), // Cambia este valor para ajustar la rotación
                      //           child: Icon(Icons.arrow_forward_ios_outlined,
                      //               color: Color(0xff6D62F7)),
                      //         ),
                      //         value: "55",
                      //         isExpanded: true,
                      //         decoration: editTextDecorationDashboard(
                      //             "Clase", "", false),
                      //         onChanged: (String? newValue) {
                      //           setState(() {
                      //             // valueVariables = newValue!;
                      //             // dashBoardBloc.add(getConteoCasosVariables(
                      //             //     year: valueYear,
                      //             //     variable: valueVariables,
                      //             //     regional: valueRegional,
                      //             //     departamento: valueDepartamento,
                      //             //     municipio: valueMunicipio,
                      //             //     reg: reg,
                      //             //     depa: depa,
                      //             //     mun: mun,
                      //             //     violenciaLey: violenciaLey,
                      //             //     violenciaOtras: otrasManifestaciones,
                      //             //     trata: trataPersonas));
                      //           });
                      //         },
                      //         items: itemsVolenciaBasada),
                      //   ),
                      // )
                    ],
                  ),
                ),
                Visibility(
                  visible: otrasManifestaciones,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Otras manifestaciones de violencia',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff606263),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField(
                              borderRadius: BorderRadius.circular(20.0),
                              icon: const RotationTransition(
                                turns: AlwaysStoppedAnimation(
                                    0.25), // Cambia este valor para ajustar la rotación
                                child: Icon(Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff6D62F7)),
                              ),
                              value: "60",
                              isExpanded: true,
                              decoration: editTextDecorationDashboard(
                                  "Clase", "", false),
                              onChanged: (String? newValue) {
                                setState(() {
                                  // valueVariables = newValue!;
                                  // dashBoardBloc.add(getConteoCasosVariables(
                                  //     year: valueYear,
                                  //     variable: valueVariables,
                                  //     regional: valueRegional,
                                  //     departamento: valueDepartamento,
                                  //     municipio: valueMunicipio,
                                  //     reg: reg,
                                  //     depa: depa,
                                  //     mun: mun,
                                  //     violenciaLey: violenciaLey,
                                  //     violenciaOtras: otrasManifestaciones,
                                  //     trata: trataPersonas));
                                });
                              },
                              items: itemsOtrasManifestaciones),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: trataPersonas,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Trata de personas',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff606263),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField(
                              borderRadius: BorderRadius.circular(20.0),
                              icon: const RotationTransition(
                                turns: AlwaysStoppedAnimation(
                                    0.25), // Cambia este valor para ajustar la rotación
                                child: Icon(Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff6D62F7)),
                              ),
                              value: "90",
                              isExpanded: true,
                              decoration: editTextDecorationDashboard(
                                  "Clase", "", false),
                              onChanged: (String? newValue) {
                                setState(() {
                                  // valueVariables = newValue!;
                                  // dashBoardBloc.add(getConteoCasosVariables(
                                  //     year: valueYear,
                                  //     variable: valueVariables,
                                  //     regional: valueRegional,
                                  //     departamento: valueDepartamento,
                                  //     municipio: valueMunicipio,
                                  //     reg: reg,
                                  //     depa: depa,
                                  //     mun: mun,
                                  //     violenciaLey: violenciaLey,
                                  //     violenciaOtras: otrasManifestaciones,
                                  //     trata: trataPersonas));
                                });
                              },
                              items: itemsTrataPersonas),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: presuntoAgresor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Presunto agresor',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff606263),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField(
                              borderRadius: BorderRadius.circular(20.0),
                              icon: const RotationTransition(
                                turns: AlwaysStoppedAnimation(
                                    0.25), // Cambia este valor para ajustar la rotación
                                child: Icon(Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff6D62F7)),
                              ),
                              value: "122",
                              isExpanded: true,
                              decoration: editTextDecorationDashboard(
                                  "Clase", "", false),
                              onChanged: (String? newValue) {
                                setState(() {
                                  // valueAgresor = newValue!;
                                  // valueCaractetizacion = valueAgresor;
                                  // dashBoardBloc.add(getConteoCaracterizacion(
                                  //     year: valueYear,
                                  //     criterio: "A",
                                  //     segmento: valueCodeSegemnto,
                                  //     departamento: valueDepartamento,
                                  //     municipio: valueMunicipio,
                                  //     regional: valueRegional,
                                  //     pregunta: valueCaractetizacion!,
                                  //     reg: reg,
                                  //     depa: depa));
                                });
                              },
                              items: itemsTrataPresuntoAgresor),
                        ),
                      )
                    ],
                  ),
                ),
                // BlocBuilder<DashBoardCombosBloc, DashBoardCombosState>(
                //   builder: (context, state) {
                //     return state is CombosCargados
                //         ? Visibility(
                //             visible: caracteri,
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 const Row(
                //                   children: [
                //                     SizedBox(
                //                       width: 20,
                //                     ),
                //                     Text(
                //                       'Opciones',
                //                       style: TextStyle(
                //                           fontSize: 12,
                //                           color: Color(0xff606263),
                //                           fontWeight: FontWeight.bold),
                //                     ),
                //                   ],
                //                 ),
                //                 const SizedBox(
                //                   height: 4,
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.symmetric(
                //                       horizontal: 16.0),
                //                   child: SizedBox(
                //                     width: MediaQuery.of(context).size.width,
                //                     child: DropdownButtonFormField(
                //                         borderRadius:
                //                             BorderRadius.circular(20.0),
                //                         icon: const RotationTransition(
                //                           turns: AlwaysStoppedAnimation(
                //                               0.25), // Cambia este valor para ajustar la rotación
                //                           child: Icon(
                //                               Icons.arrow_forward_ios_outlined,
                //                               color: Color(0xff6D62F7)),
                //                         ),
                //                         value: state
                //                             .listaPreguntasCaracterizacion[0]
                //                             .value,
                //                         isExpanded: true,
                //                         decoration: editTextDecorationDashboard(
                //                             "Clase", "", false),
                //                         onChanged: (String? newValue) {
                //                           setState(() {
                //                             // valueCaractetizacion = newValue!;
                //                             // dashBoardBloc.add(
                //                             //     getConteoCaracterizacion(
                //                             //         year: valueYear,
                //                             //         criterio: "C",
                //                             //         segmento: valueCodeSegemnto,
                //                             //         departamento:
                //                             //             valueDepartamento,
                //                             //         municipio: valueMunicipio,
                //                             //         regional: valueRegional,
                //                             //         pregunta:
                //                             //             valueCaractetizacion!,
                //                             //         reg: reg,
                //                             //         depa: depa));
                //                             // /*
                //                             //     dashBoardBloc.add(
                //                             //         getConteoCasosVariables(
                //                             //             year: valueYear,
                //                             //             variable:
                //                             //                 valueVariables,
                //                             //             regional: valueRegional,
                //                             //             departamento:
                //                             //                 valueDepartamento,
                //                             //             municipio:
                //                             //                 valueMunicipio,
                //                             //             reg: reg,
                //                             //             depa: depa,
                //                             //             mun: mun,
                //                             //             violenciaLey:
                //                             //                 violenciaLey,
                //                             //             violenciaOtras:
                //                             //                 otrasManifestaciones,
                //                             //             trata: trataPersonas));*/
                //                           });
                //                         },
                //                         items: state
                //                             .listaPreguntasCaracterizacion),
                //                   ),
                //                 )
                //               ],
                //             ),
                //           )
                //         : Container();
                //   },
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    //height: 484,
                    width: MediaQuery.of(context).size.width,
                    child: BlocBuilder<DashBoardBloc, DashBoardState>(
                      builder: (context, state) {
                        if (state is DataLoading) {
                          return Center(
                            child: CustomLoading(
                                color: 0xFF7d23df, screenH: screenH),
                          );
                        }
                        if (state is DataLoaded) {
                          final Map<String, dynamic> data = state.data;

                          final int totales = data['info']['totales'] ?? 1;

                          final ene = data['info']['data'][0];
                          final feb = data['info']['data'][1];
                          final mar = data['info']['data'][2];
                          final abr = data['info']['data'][3];
                          final may = data['info']['data'][4];
                          final jun = data['info']['data'][5];
                          final jul = data['info']['data'][6];
                          final ago = data['info']['data'][7];
                          final sep = data['info']['data'][8];
                          final oct = data['info']['data'][9];
                          final nov = data['info']['data'][10];
                          final dic = data['info']['data'][11];

                          return SizedBox(
                            height: 420,
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            'Total Casos',
                                            style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            '$totales',
                                            style: const TextStyle(
                                                fontFamily: 'poppins',
                                                fontSize: 20,
                                                color: Colors.purple),
                                          ),
                                        ),
                                      ],
                                    ),
                                    CustomRow(mes: 'Enero', data: ene['total']),
                                    CustomRow(
                                        mes: 'Febrero', data: feb['total']),
                                    CustomRow(mes: 'Marzo', data: mar['total']),
                                    CustomRow(mes: 'Abril', data: abr['total']),
                                    CustomRow(mes: 'Mayo', data: may['total']),
                                    CustomRow(mes: 'Junio', data: jun['total']),
                                    CustomRow(mes: 'Julio', data: jul['total']),
                                    CustomRow(
                                        mes: 'Agosto', data: ago['total']),
                                    CustomRow(
                                        mes: 'Septiembre', data: sep['total']),
                                    CustomRow(
                                        mes: 'Octubre', data: oct['total']),
                                    CustomRow(
                                        mes: 'Noviembre', data: nov['total']),
                                    CustomRow(
                                        mes: 'Diciembre', data: dic['total']),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        if (state is ErrorState) {
                          return const Center(
                              child: Text('Upps, something went wrong :('));
                        }

                        // return state is getGeneralResult
                        //     ? Card(
                        //         surfaceTintColor: Colors.white,
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(12.0),
                        //         ),
                        //         elevation: 10.0,
                        //         child: Padding(
                        //             padding: const EdgeInsets.only(
                        //                 left: 10,
                        //                 right: 10,
                        //                 bottom: 10,
                        //                 top: 10),
                        //             child: Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 children: [
                        //                   /*
                        //                   Row(
                        //                     children: [
                        //                       DropdownButtonFormField(
                        //                           borderRadius:
                        //                               BorderRadius.circular(
                        //                                   20.0),
                        //                           icon: RotationTransition(
                        //                             turns: AlwaysStoppedAnimation(
                        //                                 0.25), // Cambia este valor para ajustar la rotación
                        //                             child: Icon(
                        //                                 Icons
                        //                                     .arrow_forward_ios_outlined,
                        //                                 color:
                        //                                     Color(0xff6D62F7)),
                        //                           ),
                        //                           value: "1",
                        //                           isExpanded: true,
                        //                           decoration:
                        //                               editTextDecorationDashboard(
                        //                                   "Clase", "", false),
                        //                           onChanged:
                        //                               (String? newValue) {
                        //                             setState(() {
                        //                               valueYear =
                        //                                   newValue!; /*
                        //                               if (caracteri ||
                        //                                   presuntoAgresor) {
                        //                                 dashBoardBloc.add(getConteoCaracterizacion(
                        //                                     year: valueYear,
                        //                                     criterio:
                        //                                         presuntoAgresor
                        //                                             ? "A"
                        //                                             : "C",
                        //                                     segmento:
                        //                                         valueCodeSegemnto,
                        //                                     departamento:
                        //                                         valueDepartamento,
                        //                                     municipio:
                        //                                         valueMunicipio,
                        //                                     regional:
                        //                                         valueRegional,
                        //                                     pregunta: presuntoAgresor
                        //                                         ? valueAgresor
                        //                                         : valueCaractetizacion,
                        //                                     reg: reg,
                        //                                     depa: depa));
                        //                               } else {
                        //                                 dashBoardBloc.add(getConteoCasosVariables(
                        //                                     year: valueYear,
                        //                                     variable:
                        //                                         valueVariables,
                        //                                     regional:
                        //                                         valueRegional,
                        //                                     departamento:
                        //                                         valueDepartamento,
                        //                                     municipio:
                        //                                         valueMunicipio,
                        //                                     reg: reg,
                        //                                     depa: depa,
                        //                                     mun: mun,
                        //                                     violenciaLey:
                        //                                         violenciaLey,
                        //                                     violenciaOtras:
                        //                                         otrasManifestaciones,
                        //                                     trata:
                        //                                         trataPersonas));
                        //                               }*/
                        //                             });
                        //                           },
                        //                           items: itemsOrdenar)
                        //                     ],
                        //                   ),*/
                        //                   Row(
                        //                     children: [
                        //                       Container(
                        //                         width:
                        //                             44.0, // El ancho del círculo
                        //                         height:
                        //                             44.0, // La altura del círculo
                        //                         decoration: const BoxDecoration(
                        //                           shape: BoxShape
                        //                               .circle, // Establece la forma como círculo
                        //                           color: Color(
                        //                               0xff6D62F7), // Establece el color del círculo
                        //                         ),
                        //                       ),
                        //                       const SizedBox(
                        //                         width: 16,
                        //                       ),
                        //                       const Text(
                        //                         'Total ',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         textoTotal,
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       const Spacer(),
                        //                       Text(
                        //                         getSumaTotal(
                        //                             state.datoVarariables),
                        //                         style: const TextStyle(
                        //                             fontSize: 32,
                        //                             fontWeight: FontWeight.bold,
                        //                             fontFamily: 'Nunito',
                        //                             color: Color(0xff6D62F7)),
                        //                       )
                        //                     ],
                        //                   ),
                        //                   const SizedBox(
                        //                     height: 16,
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'Ene',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       const SizedBox(
                        //                         width: 10,
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "1"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables, "1"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'Feb',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       const SizedBox(
                        //                         width: 10,
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "2"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables, "2"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'Mar',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       const SizedBox(
                        //                         width: 10,
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "3"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables, "3"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'Abr',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "4"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables, "4"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'May',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "5"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables, "5"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'Jun',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "6"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables, "6"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'Jul',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "7"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables, "7"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'Ago',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "8"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables, "8"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'Sep',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "9"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables, "9"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'Oct',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "10"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables,
                        //                             "10"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'Nov',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "11"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables,
                        //                             "11"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         'Dic',
                        //                         style: TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                           child: GFProgressBar(
                        //                               lineHeight: 8,
                        //                               percentage: getPorcentaje(
                        //                                   state.datoVarariables,
                        //                                   "12"),
                        //                               backgroundColor:
                        //                                   Colors.white,
                        //                               progressBarColor:
                        //                                   const Color(
                        //                                       0xffE4E4FF))),
                        //                       Text(
                        //                         getCantidad(
                        //                             state.datoVarariables,
                        //                             "12"),
                        //                         style: const TextStyle(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito',
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ])))
                        //     : state is getGeneral
                        //         ? const Center(
                        //             child: SizedBox(
                        //               width: 50,
                        //               height: 50,
                        //               child: CircularProgressIndicator(),
                        //             ),
                        //           )
                        //         : state is getGeneralConteoCaracterizacion
                        //             ? Card(
                        //                 surfaceTintColor: Colors.white,
                        //                 color: Colors.white,
                        //                 shape: RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(12.0),
                        //                 ),
                        //                 elevation: 10.0,
                        //                 child: Padding(
                        //                     padding: const EdgeInsets.only(
                        //                         left: 10,
                        //                         right: 10,
                        //                         bottom: 10,
                        //                         top: 10),
                        //                     child: Column(
                        //                         crossAxisAlignment:
                        //                             CrossAxisAlignment.start,
                        //                         children: state.widgetConteo)))
                        //             : state is getGeneralResultTodas
                        //                 ? Container(
                        //                     child: Card(
                        //                         surfaceTintColor: Colors.white,
                        //                         shape: RoundedRectangleBorder(
                        //                           borderRadius:
                        //                               BorderRadius.circular(
                        //                                   12.0),
                        //                         ),
                        //                         elevation: 10.0,
                        //                         child: Padding(
                        //                             padding:
                        //                                 const EdgeInsets.only(
                        //                                     left: 10,
                        //                                     right: 10,
                        //                                     bottom: 10,
                        //                                     top: 10),
                        //                             child: Column(
                        //                                 crossAxisAlignment:
                        //                                     CrossAxisAlignment
                        //                                         .start,
                        //                                 children: state
                        //                                     .widgetConteo))),
                        //                   )
                        return Center(
                          child: Container(
                            child: const Text('Ups... '),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                /*
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SearchField<String>(
                        suggestions: listC
                            .map(
                              (e) => SearchFieldListItem<String>(
                                e,
                                item: e,
                                // Use child to show Custom Widgets in the suggestions
                                // defaults to Text widget
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(e),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SearchField<String>(
                      suggestions: listC
                          .map(
                            (e) => SearchFieldListItem<String>(
                              e,
                              item: e,
                              // Use child to show Custom Widgets in the suggestions
                              // defaults to Text widget
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(e),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getSumaTotal(List<ConteoAnualModel> datoVarariables) {
    int sum = 0;
    for (var item in datoVarariables) {
      sum = sum + int.parse(item.cantidad);
    }
    return Utils.formatearNumero(sum).toString();
  }

  double getPorcentaje(List<ConteoAnualModel> datoVarariables, String mes) {
    var suma = getSumaTotal(datoVarariables).replaceFirst(",", "");
    for (var item in datoVarariables) {
      if (item.mes == mes) {
        return (double.parse(item.cantidad) / double.parse(suma));
      }
    }
    return 0;
  }

  String getCantidad(List<ConteoAnualModel> datoVarariables, String mes) {
    for (var item in datoVarariables) {
      if (item.mes == mes) {
        return item.cantidad;
      }
    }
    return "0";
  }
}

class CustomRow extends StatelessWidget {
  final dynamic data;
  final String mes;

  const CustomRow({
    super.key,
    required this.data,
    required this.mes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 3), child: Text(mes)),
        Text(
          '$data',
          style: const TextStyle(
              fontFamily: 'poppins', fontSize: 16, color: Colors.purple),
        ),
      ],
    );
  }
}

InputDecoration editTextDecorationDashboard(
    String hint, String helperText, bool state) {
  return InputDecoration(
      helperText: helperText,
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
            width: 1, color: Utils().getColorFromHex(Preferences.colorEntidad)),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(width: 1, color: Color(0xff6D62F7)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(width: 1, color: Color(0xff6D62F7)),
      ),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 1,
          )),
      errorBorder: state
          ? const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: 2, color: Colors.red))
          : null,
      focusedErrorBorder: state
          ? const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 2, color: Colors.red))
          : null,
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 16, color: Color(0xFF6D62F7)),
      errorText: state ? "Campo obligatorio" : null);
}
