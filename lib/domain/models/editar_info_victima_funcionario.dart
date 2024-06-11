import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/bloc/editar_victima_funcionario_bloc.dart';
import 'package:infancia/domain/models/municipio_model.dart';
import 'package:infancia/domain/models/registro_victimas.dart';
import 'package:infancia/domain/network/registro_services.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/registro_repository.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/registro/bloc_registro/bloc/registro_bloc.dart';
 
String valueCiudadResidencia = Preferences.pkMunicipio;

String valueCiudadDenuncia = "";
String valueDepartamentoDenuncia = "";

bool? isVictima = false;

bool? isCaracterizado = false;

RegistroFuncionaroVictimas? registroFuncionaroVictimas = null;

class EditarVictimaFuncionario extends StatelessWidget {
  final RegistroFuncionaroVictimas registroFuncionaroVictimas;
  const EditarVictimaFuncionario(
      {required this.registroFuncionaroVictimas, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext contextPage) {
    RegistroRepository? repository =
        RegistroRepository(networkService: NetworkServiceRegistro());

    final RegistroBloc registroBloc =
        RegistroBloc(registroRepository: repository);

    registroBloc.add((CargarPaises()));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Seguridad ciudadana',
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(
                  contextPage,
                );
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            backgroundColor: Utils().getColorFromHex(Preferences.colorEntidad),
            title: const Text(
              'Editar información',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => registroBloc),
                BlocProvider(
                    create: (context) => EditarVictimaFuncionarioBloc())
              ],
              child: SingleChildScrollView(
                child: SafeArea(
                    child: BlocListener<EditarVictimaFuncionarioBloc,
                        EditarVictimaFuncionarioState>(
                  listener: (context, state) {
                    if (state is InfoUpdatedVictimaFuncionario) {
                      displayDialogSuccess(
                          context,
                          "Editar información",
                          "Información editada y actualizada correctamente",
                          contextPage);
                      //contactoNewEdit = state.contacto;
                    }
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              onChanged: (value) {},
                              decoration: infoTextfield(
                                  "Identificación",
                                  registroFuncionaroVictimas.id.toString(),
                                  false,
                                  Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              onChanged: (value) {
                                registroFuncionaroVictimas.nombre = value;
                              },
                              decoration: infoTextfield(
                                  "Nombres",
                                  registroFuncionaroVictimas.nombre!,
                                  true,
                                  Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              onChanged: (value) {
                                registroFuncionaroVictimas.apellidos = value;
                              },
                              decoration: infoTextfield(
                                  "Apellidos",
                                  registroFuncionaroVictimas.apellidos!,
                                  true,
                                  Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              onChanged: (value) {
                                registroFuncionaroVictimas.nombreIdentitario =
                                    value;
                              },
                              decoration: infoTextfield(
                                  "Nombre identitario",
                                  registroFuncionaroVictimas.nombreIdentitario!,
                                  true,
                                  Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: infoTextfield(
                                  "Correo",
                                  registroFuncionaroVictimas.email!,
                                  true,
                                  Colors.black),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                registroFuncionaroVictimas.email = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              onChanged: (value) {
                                registroFuncionaroVictimas.celular = value;
                              },
                              decoration: infoTextfield(
                                  "Número celular",
                                  registroFuncionaroVictimas.celular!,
                                  true,
                                  Colors.black),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: BlocBuilder<RegistroBloc, RegistroState>(
                              builder: (context, state) {
                                return state is PaisesData
                                    ? /*CombosResidencia(
                    listCiudades: state.itemsCiudadesMagdalena,
                  )*/
                                    CombosLugarResidencia(
                                        listEstados: state.estadosColombia,
                                        listMunicipios: state.municipiosTodos)
                                    : Center(
                                        child: Column(
                                          children: [
                                            CircularProgressIndicator(
                                              color: Utils().getColorFromHex(
                                                  Preferences.colorEntidad),
                                            ),
                                            const Text("Cargando información...")
                                          ],
                                        ),
                                      );
                                ;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              onChanged: (value) {
                                registroFuncionaroVictimas.direccion = value;
                              },
                              decoration: infoTextfield(
                                  "Dirección",
                                  registroFuncionaroVictimas.direccion!,
                                  true,
                                  Colors.black),
                            ),
                          ),
                          /*
                          Row(
                            children: [
                              CheckBoxVictima(
                                  isVictimaState:
                                      registroFuncionaroVictimas.isVictima!),
                              Text("¿Es la persona víctima?"),
                            ],
                          ),*/
                          Preferences.perfil == "3" &&
                                  Preferences.perfilEntidad == "2"
                              ? Row(
                                  children: [
                                    CheckBoxVictimaCaracterizado(
                                        isCaracterizado:
                                            registroFuncionaroVictimas.estado!),
                                    const Text("¿Caracterizado?"),
                                  ],
                                )
                              : Container(),
                          BlocBuilder<EditarVictimaFuncionarioBloc,
                              EditarVictimaFuncionarioState>(
                            builder: (context, state) {
                              return state is UpdateingInfoVictimaFuncionario
                                  ? CircularProgressIndicator(
                                      color: Utils().getColorFromHex(
                                          Preferences.colorEntidad),
                                    )
                                  : OutlinedButton(
                                      onPressed: () {
                                        if (valueDepartamentoDenuncia != "") {
                                          registroFuncionaroVictimas
                                                  .departamento =
                                              valueDepartamentoDenuncia;
                                        }
                                        if (valueCiudadDenuncia != "") {
                                          registroFuncionaroVictimas.municipio =
                                              valueCiudadDenuncia;
                                        }
                                        if (isVictima!) {
                                          registroFuncionaroVictimas.isVictima =
                                              "Si";
                                        } else {
                                          registroFuncionaroVictimas.isVictima =
                                              "No";
                                        }

                                        if (isCaracterizado!) {
                                          registroFuncionaroVictimas.estado =
                                              "V";
                                        } else {
                                          registroFuncionaroVictimas.estado =
                                              "EV";
                                        }

                                        context
                                            .read<
                                                EditarVictimaFuncionarioBloc>()
                                            .add((UpdateRegistroVictimaFuncionario(
                                                registroFuncionaroVictimas:
                                                    registroFuncionaroVictimas)));
                                      },
                                      child: const Text(
                                        'Guardar cambios',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: "Pluto",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Utils()
                                              .getColorFromHex(
                                                  Preferences.colorEntidad),
                                          side: const BorderSide(
                                              color: Colors.white, width: 2),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          minimumSize: const Size(200, 50)),
                                    );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                )),
              )),
        ));
  }
}

class CheckBoxVictimaCaracterizado extends StatefulWidget {
  CheckBoxVictimaCaracterizado({super.key, required this.isCaracterizado});
  String isCaracterizado;

  @override
  State<CheckBoxVictimaCaracterizado> createState() =>
      _CheckBoxVictimaCaracterizadoState();
}

class _CheckBoxVictimaCaracterizadoState
    extends State<CheckBoxVictimaCaracterizado> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Utils().getColorFromHex(Preferences.colorEntidad);
    }
    return Utils().getColorFromHex(Preferences.colorEntidad);
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        fillColor: MaterialStateProperty.resolveWith(getColor),
        checkColor: Colors.white,
        value: widget.isCaracterizado == "V" ? true : false,
        onChanged: (bool? value) {
          setState(() {
            isCaracterizado = value;
            value == true
                ? widget.isCaracterizado = "V"
                : widget.isCaracterizado = "EV";
          });
        });
  }
}

class CheckBoxVictima extends StatefulWidget {
  CheckBoxVictima({super.key, required this.isVictimaState});
  String isVictimaState;

  @override
  State<CheckBoxVictima> createState() => _CheckBoxVictimaState();
}

class _CheckBoxVictimaState extends State<CheckBoxVictima> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Utils().getColorFromHex(Preferences.colorEntidad);
    }
    return Utils().getColorFromHex(Preferences.colorEntidad);
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        fillColor: MaterialStateProperty.resolveWith(getColor),
        checkColor: Colors.white,
        value: widget.isVictimaState == "Si" ? true : false,
        onChanged: (bool? value) {
          setState(() {
            isVictima = value;
            value == true
                ? widget.isVictimaState = "Si"
                : widget.isVictimaState = "No";
          });
        });
  }
}

class CombosLugarResidencia extends StatefulWidget {
  CombosLugarResidencia(
      {super.key, required this.listEstados, required this.listMunicipios});

  List<DropdownMenuItem<String>> listEstados = [];

  List<Municipios> listMunicipios = [];

  @override
  State<CombosLugarResidencia> createState() => _CombosLugarResidenciaState(
      listEstados: listEstados, listCiudades: listMunicipios);
}

class _CombosLugarResidenciaState extends State<CombosLugarResidencia> {
  List<DropdownMenuItem<String>> listEstados = [];
  List<Municipios> listCiudades = [];

  List<DropdownMenuItem<String>> listaCiudadSelected = [];

  bool disabledDropdownCiudad = true;

  String selectedValue = "";

  String? selectedValue2 = "";
  String? selectedCiudad = "";

  _CombosLugarResidenciaState(
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

    return Column(
      children: [
        DropdownButtonFormField(
            value: selectedValue,
            disabledHint: const Text("Departamento"),
            hint: const Text("Departamento"),
            decoration: editTextDecoration("Clase", false, "Obligatorio"),
            onChanged: (estado) => {estadoNuevo(estado), getCiudadesByEstado()},
            items: listEstados),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
            value: selectedCiudad,
            disabledHint: const Text("Ciudad o municipio"),
            hint: const Text("Ciudad o municipio"),
            decoration: editTextDecoration("Clase", false, "Obligatorio"),
            onChanged: disabledDropdownCiudad
                ? null
                : (ciudad) => estadoCiudad(ciudad),
            items: listaCiudadSelected)
      ],
    );
  }

  InputDecoration editTextDecoration(String hint, bool state, String helpText) {
    return InputDecoration(
        helperText: helpText,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 4,
              color: Utils().getColorFromHex(Preferences.colorEntidad)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 2, color: Color(0xffB6B1B7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 2,
              color: Utils().getColorFromHex(Preferences.colorEntidad)),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 1,
            )),
        errorBorder: state
            ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 2, color: Colors.red))
            : null,
        focusedErrorBorder: state
            ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 2, color: Colors.red))
            : null,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
        errorText: state ? "Campo obligatorio" : null);
  }
}

void displayDialogSuccess(BuildContext context, String title, String message,
    BuildContext contextPage) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: Row(
            children: [Text(title)],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(contextPage);
                },
                child: const Text("Aceptar"))
          ],
        );
      });
}

void popPage(BuildContext context) {
  Navigator.pop(context);
}

InputDecoration editTextDecoration(String hint, bool state) {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
            width: 3, color: Utils().getColorFromHex(Preferences.colorEntidad)),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 2, color: Color(0xffB6B1B7)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 2, color: Color(0xffB6B1B7)),
      ),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
          )),
      errorBorder: state
          ? const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 2, color: Colors.red))
          : null,
      focusedErrorBorder: state
          ? const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 2, color: Colors.red))
          : null,
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
      errorText: state ? "Campo obligatorio" : null);
}

InputDecoration infoTextfield(
    String labelText, String placeholder, bool enable, Color color) {
  return InputDecoration(
      labelStyle:
          TextStyle(color: Utils().getColorFromHex(Preferences.colorEntidad)),
      enabled: enable,
      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: placeholder,
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        borderSide: BorderSide(
            width: 3, color: Utils().getColorFromHex(Preferences.colorEntidad)),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        borderSide: BorderSide(
            width: 2, color: Utils().getColorFromHex(Preferences.colorEntidad)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        borderSide: BorderSide(
            width: 2, color: Utils().getColorFromHex(Preferences.colorEntidad)),
      ),
      hintStyle:
          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(
            width: 1,
          )));
}
