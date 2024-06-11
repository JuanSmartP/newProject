import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/models/municipio_model.dart';
import 'package:infancia/domain/network/canal_services.dart';
import 'package:infancia/domain/network/denuncias.dart';

import 'package:infancia/domain/repository/canal_repository.dart';
import 'package:infancia/domain/repository/denuncias_repository.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/canal/blocs/add_denuncia/bloc/adddenuncia_bloc.dart';

import 'package:infancia/ui/screens/canal/blocs/canal_atencion_bloc/bloc/canal_atencion_bloc.dart';
import 'package:infancia/ui/screens/canal/blocs/bloc/guardar_solicitud_bloc.dart';

String valueCiudadDenuncia = "";
String valueDepartamentoDenuncia = "";

String valueServidor = "1";
String valueParticular = "1";
String valueEntidad = "";

final myControllerCargo = TextEditingController();
final myControllerEntidad = TextEditingController();
final myControllerNombres = TextEditingController();
final myControllerCelular = TextEditingController();
final myControllerCorreo = TextEditingController();

final myControllerDescripcion = TextEditingController();

bool isPublico = true;
bool isParticular = true;

class AddCanalMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xFF6599fe),
          appBar: AppBar(
            leading: GestureDetector(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () => {
                Navigator.pop(
                  context,
                ),
                isPublico = true,
                isParticular = true,
                valueServidor = "1",
                valueParticular = "1",
                valueEntidad = "",
                valueCiudadDenuncia = "",
                valueDepartamentoDenuncia = "",
                myControllerCargo.text = "",
                myControllerCelular.text = "",
                myControllerNombres.text = "",
                myControllerDescripcion.text = ""
              },
            ),
            backgroundColor: const Color(0xFF6599fe),
            title: const Row(
              children: [
                // Image(
                //   height: 35,
                //   width: 35,
                //   fit: BoxFit.scaleDown,
                //   filterQuality: FilterQuality.high,
                //   image: AssetImage('images/corachon.png'),
                // ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'App Contigo Infancia',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontFamily: "Pluto",
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: Center(
            child: Container(
              child: SingleChildScrollView(
                child: FormSolicitud(context),
              ),
            ),
          ),
        ));
  }
}

class FormSolicitud extends StatefulWidget {
  BuildContext contextMain;

  FormSolicitud(this.contextMain);

  @override
  State<FormSolicitud> createState() => _FormSolicitudState(contextMain);
}

class _FormSolicitudState extends State<FormSolicitud> {
  BuildContext contextMain;
  final AdddenunciaBloc addDenunciaBloc = AdddenunciaBloc(
      repository:
          DenunciasRepository(networkService: NetworkServiceDenuncias()));

  final CanalAtencionBloc canalAtencionBloc = CanalAtencionBloc(
      repository: CanalRepository(canalService: CanalService()));

  final GuardarSolicitudBloc guardarSolicitudBloc = GuardarSolicitudBloc(
      repository: CanalRepository(canalService: CanalService()));

  _FormSolicitudState(this.contextMain);

  @override
  void initState() {
    super.initState();
    addDenunciaBloc.add((CargarCiudades()));
    canalAtencionBloc.add(getEntidades());
  }

  List<DropdownMenuItem<String>> dataServidor = [
    const DropdownMenuItem(child: Text("Si"), value: "1"),
    const DropdownMenuItem(child: Text("No"), value: "2"),
  ];

  List<DropdownMenuItem<String>> dataParticular = [
    const DropdownMenuItem(child: Text("Si"), value: "1"),
    const DropdownMenuItem(child: Text("No"), value: "2"),
  ];

  @override
  Widget build(BuildContext contextBuild) {
    return Container(
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => addDenunciaBloc,
            ),
            BlocProvider(
              create: (context) => canalAtencionBloc,
            ),
            BlocProvider(
              create: (context) => guardarSolicitudBloc,
            ),
          ],
          child: BlocListener<GuardarSolicitudBloc, GuardarSolicitudState>(
            listener: (context, state) {
              if (state is SolicitudGuardado) {
                Utils.displayDialogDenuncias(context, "Canal de atención",
                    "Solicitud enviada correctamente", contextMain);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AdddenunciaBloc, AdddenunciaState>(
                  builder: (context, state) {
                    return state is MunicipiosData
                        ? CombosLugarSolicitud(
                            listEstados: state.listEstados,
                            listMunicipios: state.listMunicipios,
                          )
                        : const Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CircularProgressIndicator(
                                      color: Colors.white),
                                  Text(
                                    "Cargando combos...",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ));
                  },
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "¿Es usted servidor público?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: SizedBox(
                    width: 100,
                    child: DropdownButtonFormField(
                        hint: const Text("Si"),
                        decoration:
                            editTextDecorationCombos("Clase", "", false),
                        onChanged: (String? newValue) {
                          setState(() {
                            valueServidor = newValue!;
                            if (valueServidor == '1') {
                              isPublico = true;
                            } else {
                              isPublico = false;
                            }
                          });
                        },
                        items: dataServidor),
                  ),
                ),
                Visibility(
                    visible: isPublico,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        controller: myControllerEntidad,
                        textAlign: TextAlign.left,
                        decoration:
                            editTextDecorationCombos("Entidad", "", false),
                        onChanged: (value) => () {
                          setState(() {
                            myControllerEntidad.text = value;
                          });
                        },
                      ),
                    )),
                Visibility(
                    visible: isPublico,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        controller: myControllerCargo,
                        textAlign: TextAlign.left,
                        decoration:
                            editTextDecorationCombos("Cargo", "", false),
                        onChanged: (value) => () {
                          setState(() {
                            myControllerCargo.text = value;
                          });
                        },
                      ),
                    )),
                const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "¿Es usted particular?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: SizedBox(
                    width: 100,
                    child: DropdownButtonFormField(
                        hint: const Text("Si"),
                        decoration:
                            editTextDecorationCombos("Clase", "", false),
                        onChanged: (String? newValue) {
                          setState(() {
                            valueParticular = newValue!;
                            if (valueParticular == '1') {
                              isParticular = true;
                            } else {
                              isParticular = false;
                            }
                          });
                        },
                        items: dataParticular),
                  ),
                ),
                Visibility(
                    visible: isParticular,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        keyboardType: TextInputType.name,
                        controller: myControllerNombres,
                        textAlign: TextAlign.left,
                        decoration:
                            editTextDecorationCombos("Nombres", "", false),
                        onChanged: (value) => () {
                          setState(() {
                            myControllerNombres.text = value;
                          });
                        },
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    maxLength: 10,
                    controller: myControllerCelular,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: editTextDecorationCombos("Celular", "", false),
                    onChanged: (value) => () {
                      setState(() {
                        myControllerCelular.text = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    controller: myControllerCorreo,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.emailAddress,
                    decoration: editTextDecorationCombos("Correo", "", false),
                    onChanged: (value) => () {
                      setState(() {
                        myControllerCorreo.text = value;
                      });
                    },
                  ),
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "¿En qué le podemos ayudar? ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    controller: myControllerDescripcion,
                    textAlign: TextAlign.left,
                    decoration: editTextDecorationCombos(
                        "Describe con detalles la situación", "", false),
                    onChanged: (value) => () {
                      setState(() {
                        myControllerNombres.text = value;
                      });
                    },
                  ),
                ),
                BlocBuilder<GuardarSolicitudBloc, GuardarSolicitudState>(
                  builder: (context, state) {
                    return state is SolicitudGuardando
                        ? const Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                CircularProgressIndicator(color: Colors.white),
                              ],
                            ),
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: CupertinoButton(
                                  color: const Color(0xFF004897),
                                  child: const Text(
                                    "Enviar",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  onPressed: () {
                                    
                                    guardarSolicitudBloc.add(guardarSolicitud(
                                      idDapartamento: valueDepartamentoDenuncia,
                                      idMunicipio: valueCiudadDenuncia,
                                      servidorPublico:
                                          valueServidor == '1' ? "Si" : "No",
                                      entidad: myControllerEntidad.text,
                                      cargo: myControllerCargo.text,
                                      particular:
                                          valueParticular == '1' ? "Si" : "No",
                                      nombres: myControllerNombres.text,
                                      celular: myControllerCelular.text,
                                      correo: myControllerCorreo.text,
                                      descripcion: myControllerDescripcion.text,
                                    ));
                                  }),
                            ),
                          );
                  },
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
    );
  }
}

class CombosLugarSolicitud extends StatefulWidget {
  CombosLugarSolicitud(
      {required this.listEstados, required this.listMunicipios});

  List<DropdownMenuItem<String>> listEstados = [];

  List<Municipios> listMunicipios = [];

  @override
  State<CombosLugarSolicitud> createState() => _CombosLugarSolicitudState(
      listEstados: listEstados, listCiudades: listMunicipios);
}

class _CombosLugarSolicitudState extends State<CombosLugarSolicitud> {
  List<DropdownMenuItem<String>> listEstados = [];
  List<Municipios> listCiudades = [];

  List<DropdownMenuItem<String>> listaCiudadSelected = [];

  bool disabledDropdownCiudad = true;

  String selectedValue = "";

  String? selectedValue2 = "";
  String? selectedCiudad = "";

  _CombosLugarSolicitudState(
      {required this.listEstados, required this.listCiudades});

  void getCiudadesByEstado() {
    listaCiudadSelected = [];
    for (Municipios item in listCiudades) {
      if (item.codigoDepartamento == selectedValue2) {
        listaCiudadSelected.add(
          DropdownMenuItem(
              child: Text(item.nombreMunicipio), value: item.codigoMunicipios),
        );
      }
    }
    selectedCiudad = listaCiudadSelected[0].value;
    print(selectedCiudad);
  }

  void estadoNuevo(codigoEstado) {
    setState(() {
      disabledDropdownCiudad = false;
      valueDepartamentoDenuncia = codigoEstado;
      selectedValue2 = codigoEstado;
    });
  }

  void estadoCiudad(codigoCiudad) {
    setState(() {
      valueCiudadDenuncia = codigoCiudad;
      selectedCiudad = codigoCiudad;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedValue == "") {
      selectedValue = listEstados[0].value!;
    }

    return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            DropdownButtonFormField(
                value: selectedValue,
                disabledHint: const Text("Indiqué el departamento"),
                hint: const Text("Indiqué el departamento"),
                decoration: editTextDecorationCombos("Clase", "", false),
                onChanged: (estado) =>
                    {estadoNuevo(estado), getCiudadesByEstado()},
                items: listEstados),
            DropdownButtonFormField(
                value: selectedCiudad,
                disabledHint: const Text("Indiqué el municipio"),
                hint: const Text("Indiqué el municipio"),
                decoration: editTextDecorationCombos("Clase", "", false),
                onChanged: disabledDropdownCiudad
                    ? null
                    : (ciudad) => estadoCiudad(ciudad),
                items: listaCiudadSelected)
          ],
        ));
  }
}

InputDecoration editTextDecorationCombos(
    String hint, String helperText, bool state) {
  return InputDecoration(
      helperText: helperText,
      filled: true,
      fillColor: Colors.white,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        borderSide: BorderSide(
          width: 3,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        borderSide: BorderSide(),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        borderSide: BorderSide(),
      ),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(
            width: 1,
          )),
      errorBorder: state
          ? const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(width: 2, color: Colors.red))
          : null,
      focusedErrorBorder: state
          ? const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(width: 2, color: Colors.red))
          : null,
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
      errorText: state ? "Campo obligatorio" : null);
}
