import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:infancia/domain/network/canal_services.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/canal_repository.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/canal/blocs/canal_atencion_bloc/bloc/canal_atencion_bloc.dart';
import 'package:infancia/ui/screens/canal/canal_main.dart';
import 'package:infancia/ui/widgets/cardlist_solicitudes.dart';
import 'package:infancia/ui/widgets/custom_loading.dart';

import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:vesta_flutter/Blocs/CanalAtencion/canal_atencion_bloc.dart';
// import 'package:vesta_flutter/Blocs/ContactoASa/contacto_asa_bloc.dart';
// import 'package:vesta_flutter/network/app_version_service.dart';
// import 'package:vesta_flutter/network/canal_service.dart';
// import 'package:vesta_flutter/pages/CanalAtencion/canal_main.dart';
// import 'package:vesta_flutter/pages/CanalAtencion/cardlist_solicitudes.dart';
// import 'package:vesta_flutter/preferences.dart';
// import 'package:vesta_flutter/repositorry/canal_repository.dart';
// import 'package:vesta_flutter/repositorry/contacto_asa_repository.dart';
// import 'package:whatsapp_unilink/whatsapp_unilink.dart';

// import '../../Utils.dart';

String valueRegional = "0";

var checkFecha = false;

final myControllerInicial = TextEditingController();
final myControllerFinal = TextEditingController();

var valueDateInicial = "";
var valueFechaFinal = "";

class CanalMain extends StatefulWidget {
  const CanalMain({super.key});

  @override
  State<CanalMain> createState() => _CanalMainState();
}

class _CanalMainState extends State<CanalMain> {
  final CanalAtencionBloc canalAtencionBloc = CanalAtencionBloc(
      repository: CanalRepository(canalService: CanalService()));

  // final ContactoAsaBloc contactoAsaBloc = ContactoAsaBloc(
  //     repository: ContactoAsaRepository(networkService: NetworkAppVersion()));

  @override
  void initState() {
    super.initState();
    //Consulto los canales
    myControllerInicial.text = "";
    myControllerFinal.text = "";
    checkFecha = false;
    canalAtencionBloc.add(getCanalesMain(
        regional: Preferences.regional,
        fechaInicial: "",
        fechaFinal: "",
        rangoFecha: false));
    // contactoAsaBloc.add(getContactoNumber(regional: Preferences.regional));
  }

  List<DropdownMenuItem<String>> dataRegionales = [
    const DropdownMenuItem(value: "0", child: Text("Todas")),
    const DropdownMenuItem(value: "1", child: Text("Amazonas")),
    const DropdownMenuItem(value: "2", child: Text("Antioquia")),
    const DropdownMenuItem(value: "3", child: Text("Arauca")),
    const DropdownMenuItem(value: "4", child: Text("Atlántico")),
    const DropdownMenuItem(value: "5", child: Text("Bogotá")),
    const DropdownMenuItem(value: "6", child: Text("Bajo Cauca Antioqueño")),
    const DropdownMenuItem(value: "7", child: Text("Bolívar")),
    const DropdownMenuItem(value: "8", child: Text("Boyacá")),
    const DropdownMenuItem(value: "9", child: Text("Caldas")),
    const DropdownMenuItem(value: "10", child: Text("Caquetá")),
    const DropdownMenuItem(value: "11", child: Text("Casanare")),
    const DropdownMenuItem(value: "12", child: Text("Cauca")),
    const DropdownMenuItem(value: "13", child: Text("Cesar")),
    const DropdownMenuItem(value: "14", child: Text("Córdoba")),
    const DropdownMenuItem(value: "15", child: Text("Cundinamarca")),
    const DropdownMenuItem(value: "16", child: Text("Guaina")),
    const DropdownMenuItem(value: "17", child: Text("Guajira")),
    const DropdownMenuItem(value: "18", child: Text("Guaviare")),
    const DropdownMenuItem(value: "19", child: Text("Huila")),
    const DropdownMenuItem(value: "20", child: Text("Magdalena")),
    const DropdownMenuItem(value: "21", child: Text("Magdalena Medio")),
    const DropdownMenuItem(value: "22", child: Text("Meta")),
    const DropdownMenuItem(value: "23", child: Text("Nariño")),
    const DropdownMenuItem(value: "24", child: Text("Norte de Santander")),
    const DropdownMenuItem(value: "25", child: Text("Ocaña")),
    const DropdownMenuItem(value: "26", child: Text("Pacífico")),
    const DropdownMenuItem(value: "27", child: Text("Putumayo")),
    const DropdownMenuItem(value: "28", child: Text("Quindio")),
    const DropdownMenuItem(value: "29", child: Text("Risaralda")),
    const DropdownMenuItem(
        value: "30", child: Text("San Andres y Providencia")),
    const DropdownMenuItem(value: "31", child: Text("Santander")),
    const DropdownMenuItem(value: "32", child: Text("Soacha")),
    const DropdownMenuItem(value: "33", child: Text("Sucre")),
    const DropdownMenuItem(value: "34", child: Text("Sur de Bolívar")),
    const DropdownMenuItem(value: "35", child: Text("Sur de Córdoba")),
    const DropdownMenuItem(value: "36", child: Text("Urabá")),
    const DropdownMenuItem(value: "37", child: Text("Tolima")),
    const DropdownMenuItem(value: "38", child: Text("Tumaco")),
    const DropdownMenuItem(value: "39", child: Text("Valle del Cauca")),
    const DropdownMenuItem(value: "40", child: Text("Vaupés")),
    const DropdownMenuItem(value: "41", child: Text("Vichada")),
    const DropdownMenuItem(value: "42", child: Text("Chocó")),
    const DropdownMenuItem(value: "61", child: Text("Ipiales")),
  ];

  @override
  Widget build(BuildContext context) {

  final screenH = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => canalAtencionBloc,
          ),
          // BlocProvider(
          //   create: (context) => contactoAsaBloc,
          // ),
        ],
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Solicitudes",
                  style: TextStyle(
                      // color: Utils().getColorFromHex(Preferences.colorEntidad),
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                /*
                GestureDetector(
                  child: Icon(Icons.filter_alt),
                  onTap: () => {
                    Navigator.pop(
                      context,
                    ),
                  },
                ),*/
                // Container(
                //   width: 50,
                //   height: 50,
                //   child: BlocBuilder<ContactoAsaBloc, ContactoAsaState>(
                //     builder: (context, state) {
                //       return state is ContactoAsaData
                //           ? FloatingActionButton(
                //               shape: const CircleBorder(),
                //               mini: true,
                //               heroTag: "addVic",
                //               onPressed: () async {
                //                 final link = WhatsAppUnilink(
                //                   phoneNumber: '+57${state.numero}',
                //                   text: state.mensaje,
                //                 );
                //                 var url = Uri.parse(link.toString());
                //                 await launchUrl(url);
                //               },
                //               backgroundColor: Utils()
                //                   .getColorFromHex(Preferences.colorEntidad),
                //               child: const Icon(
                //                 Icons.headphones,
                //                 color: Colors.white,
                //               ),
                //             )
                //           : Container();
                //     },
                //   ),
                // ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            Preferences.perfil == '3'
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: DropdownButtonFormField(
                        value: "0",
                        hint: const Text("Regional"),
                        decoration:
                            editTextDecorationCombos("Clase", "", false),
                        onChanged: (String? newValue) {
                          setState(() {
                            valueRegional = newValue!;
                            if (newValue == "0") {
                              canalAtencionBloc.add(getCanalesMain(
                                  regional: "No tiene",
                                  fechaInicial: myControllerInicial.text,
                                  fechaFinal: myControllerFinal.text,
                                  rangoFecha: checkFecha));
                            } else {
                              canalAtencionBloc.add(getCanalesMain(
                                  regional: valueRegional,
                                  fechaInicial: myControllerInicial.text,
                                  fechaFinal: myControllerFinal.text,
                                  rangoFecha: checkFecha));
                            }
                          });
                        },
                        items: dataRegionales),
                  )
                : Container(),
            Preferences.perfil == '3'
                ? Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          DateWidgetInicialSolicitud(
                            myControllerDateSeguiente: myControllerInicial,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Visibility(
                              visible: checkFecha,
                              child: DateWidgetFinalSolicitudes(
                                myControllerDateSeguiente: myControllerFinal,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                              value: checkFecha,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkFecha = value!;
                                });
                              }),
                          const Text("Rango de fechas")
                        ],
                      )
                    ],
                  )
                : Container(),
            BlocBuilder<CanalAtencionBloc, CanalAtencionState>(
              builder: (context, state) {
                if (state is CargangoSolicitudes) {
                  return CustomLoading( color: 0xFF6599fe, screenH: screenH);
                } else if (state is SolicitudesData) {
                  return CardListSolicitudes(
                      state.solicitudesData,
                      canalAtencionBloc,
                      Preferences.perfil == '3'
                          ? valueRegional
                          : Preferences.regional,
                      state.registrosBlurList);
                } else {
                  if (state is SolicitudesNoHay) {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        // ignore: avoid_unnecessary_containers
                        Container(
                          child: const Center(
                            child: Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text("No tiene solicitudes disponibles")
                            ]),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return state is SolicitudesNoConexion
                        ? Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                  child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Fallo de conexión"),
                                    Image(
                                      image: AssetImage(
                                          'images/network-signal.png'),
                                      width: 30.0,
                                      height: 30.0,
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          )
                        : Container();
                  }
                }
              },
            ),
          ],
        )),
      ),
    );
  }
}

class DateWidgetInicialSolicitud extends StatefulWidget {
  DateWidgetInicialSolicitud({required this.myControllerDateSeguiente});
  var myControllerDateSeguiente = TextEditingController();

  @override
  State<DateWidgetInicialSolicitud> createState() =>
      _DateWidgetInicialSolicitudWidgetState(
          myControllerDateSiguiente: myControllerDateSeguiente);
}

class _DateWidgetInicialSolicitudWidgetState
    extends State<DateWidgetInicialSolicitud> {
  var myControllerDateSiguiente = TextEditingController();

  _DateWidgetInicialSolicitudWidgetState(
      {required this.myControllerDateSiguiente});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.35,
        child: TextField(
            controller: widget
                .myControllerDateSeguiente, //editing controller of this TextField
            decoration: editTextDecorationCombos("Fecha inicial", "", false),
            readOnly:
                true, //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.utc(2000, 01,
                      01), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(DateTime.now().year, 12, 31, 0, 0));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  widget.myControllerDateSeguiente.text = formattedDate;
                  //set output date to TextField value.
                  valueDateInicial = formattedDate;
                });
              } else {
                print("Date is not selected");
              }
            }));
  }
}

class DateWidgetFinalSolicitudes extends StatefulWidget {
  DateWidgetFinalSolicitudes({required this.myControllerDateSeguiente});
  var myControllerDateSeguiente = TextEditingController();

  @override
  State<DateWidgetFinalSolicitudes> createState() =>
      _DateWidgetFinalSolicitudesWidgetState(
          myControllerDateSiguiente: myControllerDateSeguiente);
}

class _DateWidgetFinalSolicitudesWidgetState
    extends State<DateWidgetFinalSolicitudes> {
  var myControllerDateSiguiente = TextEditingController();

  _DateWidgetFinalSolicitudesWidgetState(
      {required this.myControllerDateSiguiente});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.35,
        child: TextField(
            controller: widget
                .myControllerDateSeguiente, //editing controller of this TextField
            decoration: editTextDecorationCombos("Fecha final", "", false),
            readOnly:
                true, //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.utc(2000, 01,
                      01), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(DateTime.now().year, 12, 31, 0, 0));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  widget.myControllerDateSeguiente.text = formattedDate;
                  //set output date to TextField value.
                  valueDateInicial = formattedDate;
                });
              } else {
                print("Date is not selected");
              }
            }));
  }
}
