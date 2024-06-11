import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/models/municipio_model.dart';
import 'package:infancia/domain/network/registro_services.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/registro_repository.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/registro/bloc_registro/bloc/registro_bloc.dart';
import 'package:infancia/ui/screens/registro/bloc_victima_registro/bloc/registro_victimas_funcionario_bloc.dart';

final myControllerID = TextEditingController();
final myControllerName = TextEditingController();
final myControllerLastName = TextEditingController();
final myControllerIdentitario = TextEditingController();
final myControllerNumber = TextEditingController();
final myControllerDireccion = TextEditingController();
final myControllerEmail = TextEditingController();
final myControllerDate = TextEditingController();

bool isChecked = false;

//Combos
String valueCiudadDenuncia = "";
String valueDepartamentoDenuncia = "";

String valueTipoConducta = "";
String valueTipo = "";
late var contextPage = null;

String valueDateRegistro = "";

class AddVictima extends StatefulWidget {
  @override
  State<AddVictima> createState() => _AddVictimaState();
}

class _AddVictimaState extends State<AddVictima> {
  final RegistroBloc registroBloc = RegistroBloc(
      registroRepository:
          RegistroRepository(networkService: NetworkServiceRegistro()));

  @override
  void initState() {
    super.initState();
    /*
    myControllerID.text = "";
    myControllerName.text = "";
    myControllerLastName.text = "";
    myControllerNumber.text = "";
    myControllerDireccion.text = "";
    myControllerIdentitario.text = "";
    myControllerEmail.text = "";
    valueCiudadDenuncia = "";
    valueDepartamentoDenuncia = "";
    valueTipo = "";*/
    registroBloc.add((CargarPaises()));
  }

  @override
  Widget build(BuildContext contextPageBuild) {
    contextPage = contextPageBuild;

    return  Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
              onTap: () => {Navigator.pop(contextPage)},
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          //leading: Icon(Icons.arrow_back_ios)
          backgroundColor:  const Color(0xFF80abff),
          actions: const [
            Icon(
              Icons.search,
              color: Colors.transparent,
            )
          ],
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Registro',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: "Pluto",
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => registroBloc,
            ),
            BlocProvider(
              create: (context) => RegistroVictimasFuncionarioBloc(),
            ),
          ],
          child: SingleChildScrollView(
            child: BlocListener<RegistroVictimasFuncionarioBloc,
                RegistroVictimasFuncionarioState>(
              listener: (context, state) async {
                if (state is FaltanCamposVictimaFuncionario) {
                  displayDialogCampos(
                      context, "Registro", "Faltan campos por llenar.");
                }

                if (state is RegistroFinalizadoVictimaFuncionario) {
                  /*
                  displayDialogCamposFinalizado(
                      context,
                      "Registrar información",
                      "Registro exitoso. ¿Desea pasar a la caracterización?");*/
                  /*
                  displayDialogCamposFinalizadoPasarCaracterizacion(
                      context,
                      "Registrar información",
                      "Registro exitoso. ¿Desea pasar a la caracterización?");
*/

                  // final complete = await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => //MyListTest()
                  //     //     EntrevistaMain(
                  //     //   id: myControllerID.text,
                  //     //   names: myControllerName.text,
                  //     //   apellidos: myControllerLastName.text,
                  //     // ),

                  //   ),

                  // );

                  myControllerID.text = "";
                  myControllerName.text = "";
                  myControllerLastName.text = "";
                  myControllerIdentitario.text = "";
                  myControllerNumber.text = "";
                  myControllerDireccion.text = "";
                  myControllerEmail.text = "";
                  valueCiudadDenuncia = "";
                  valueDepartamentoDenuncia = "";
                  valueTipo = "";

                  displayDialogCampos(
                      context, "Registro", "Registro Exitoso");


                      

                 
                }

                if (state is ExistePersonaVictimaFuncionario) {
                  displayDialogCampos(context, "Registro",
                      "Esta persona ya se encuentra registrada. Por favor verifique su información.");
                }
              },
              child: Card(
                  surfaceTintColor: Colors.white,
                  elevation: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                        width: MediaQuery.of(contextPage).size.width,
                        child: RegistroForm()),
                  )),
            ),
          ),
        ),
      );
    
  }

  void displayDialogCampos(BuildContext context, String title, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: Text(title),
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
                  onPressed: () => {Navigator.pop(context)},
                  child: const Text("Aceptar"))
            ],
          );
        });
  }

  void displayDialogCamposFinalizadoPasarCaracterizacion(
      BuildContext context, String title, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: Text(title),
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => //MyListTest()
                    //           EntrevistaMain(
                    //             id: myControllerID.text,
                    //             names: myControllerName.text,
                    //             apellidos: myControllerLastName.text,
                    //           )),
                    // );
                    //registrosFuncionarioBloc.add(getRegistrosIniciales());
                  },
                  child: const Text("Caracterizar")),
              TextButton(
                  onPressed: () =>
                      {Navigator.pop(context), Navigator.pop(contextPage)},
                  child: const Text("Cancelar"))
            ],
          );
        });
  }

  void displayDialogCamposFinalizado(
      BuildContext context, String title, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: Text(title),
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
                  onPressed: () =>
                      {Navigator.pop(context), Navigator.pop(contextPage)},
                  child: const Text("Aceptar"))
            ],
          );
        });
  }
}

class RegistroForm extends StatefulWidget {
  RegistroForm({Key? key}) : super(key: key);

  @override
  State<RegistroForm> createState() => _RegistroFormState();
}

class _RegistroFormState extends State<RegistroForm> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "13", child: Text("Cédula de ciudadania")),
      const DropdownMenuItem(value: "12", child: Text("Tarjeta de identidad")),
      const DropdownMenuItem(value: "22", child: Text("Cédula de extranjeria")),
      const DropdownMenuItem(value: "41", child: Text("Pasaporte")),
      const DropdownMenuItem(
          value: "42", child: Text("Tipo de documento Extranjero")),
      const DropdownMenuItem(
          value: "44", child: Text("Permiso especial de Permanencia")),
      const DropdownMenuItem(
          value: "45", child: Text("Tarjeta de Movilidad Fonteriza")),
      const DropdownMenuItem(
          value: "46", child: Text("Permiso de Proteccion Temporal")),
    ];
    String dateChosen = "";
    //String selectedValue = "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "Datos Personales",
          style: TextStyle(
              fontSize: 16,
              color: Utils().getColorFromHex(Preferences.colorEntidad),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
            hint: const Text("Tipo de identificación"),
            decoration: editTextDecoration("Clase", false, "Obligatorio"),
            onChanged: (String? newValue) {
              setState(() {
                valueTipo = newValue!;
              });

              print(valueTipo);
            },
            items: menuItems),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: myControllerID,
          decoration:
              editTextDecoration("Identificación", false, "Obligatorio"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          onChanged: (value) => () {
            setState(() {
              myControllerID.text = value.toString();
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: myControllerName,
          decoration: editTextDecoration("Nombres", false, "Obligatorio"),
          keyboardType: TextInputType.text,
          onChanged: (value) => () {
            setState(() {
              myControllerName.text = value.toString();
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: myControllerLastName,
          decoration: editTextDecoration("Apellidos", false, "Obligatorio"),
          keyboardType: TextInputType.text,
          onChanged: (value) => () {
            setState(() {
              myControllerLastName.text = value.toString();
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: myControllerIdentitario,
          decoration: editTextDecoration("Nombre Identitario", false, ""),
          keyboardType: TextInputType.text,
          onChanged: (value) => () {
            setState(() {
              myControllerLastName.text = value.toString();
            });
          },
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: TextField(
            controller: myControllerNumber,
            decoration: editTextDecoration("Teléfono celular", false, ""),
            maxLength: 10,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            onChanged: (value) => () {
              setState(() {
                myControllerNumber.text = value.toString();
              });
            },
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: myControllerEmail,
          decoration: editTextDecoration("Correo", false, ""),
          onChanged: (value) => () {},
        ),
        const SizedBox(
          height: 10,
        ),
        /*
        DateWidgetRegistro(myControllerDate: myControllerDate),
        SizedBox(
          height: 10,
        ),*/
        Text(
          "Datos de residencia",
          style: TextStyle(
              fontSize: 16,
              color: Utils().getColorFromHex(Preferences.colorEntidad),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<RegistroBloc, RegistroState>(
          builder: (context, state) {
            return state is PaisesData
                /*CombosResidencia(
                    listCiudades: state.itemsCiudadesMagdalena,
                  )*/
                ? CombosLugarResidencia(
                    listEstados: state.estadosColombia,
                    listMunicipios: state.municipiosTodos)
                : Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color:
                              Utils().getColorFromHex(Preferences.colorEntidad),
                        ),
                        const Text("Cargando información...")
                      ],
                    ),
                  );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: myControllerDireccion,
          decoration: editTextDecoration("Dirección", false, ""),
          keyboardType: TextInputType.text,
          onChanged: (value) => () {
            setState(() {
              myControllerDireccion.text = value.toString();
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        /*
        BlocBuilder<RegistroBloc, RegistroState>(
          builder: (context, state) {
            return state is PaisesData
                ? /*CombosResidencia(
                    listCiudades: state.itemsCiudadesMagdalena,
                  )*/
                ComboTipoConducta(listConductas: state.tipoConducta)
                : Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color: Preferences.entidadUsuario == "8001860611"
                ? Color(0xff014898)
                : Color(0xffFF2B66),
                        ),
                        Text("Cargando información...")
                      ],
                    ),
                  );
          },
        ),*/

/*
        Row(
          children: [
            CheckBoxRegistroFuncionario(),
            Text("Acepto Términos y Condiciones"),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                var url = Uri.parse(
                    'regis://proyectovesta.com/M_Terminos_Condiciones.jsp');

                launchUrl(url);
              },
              child: Text(
                'Ver',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                    color: Preferences.entidadUsuario == "8001860611"
                ? Color(0xff014898)
                : Color(0xffFF2B66),
                    fontFamily: "Pluto",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),*/
        BlocBuilder<RegistroVictimasFuncionarioBloc,
            RegistroVictimasFuncionarioState>(
          builder: (context, state) {
            return Center(
              child: CupertinoButton(
                color: Utils().getColorFromHex(Preferences.colorEntidad),
                onPressed: ()  {
                  context.read<RegistroVictimasFuncionarioBloc>().add(
                      (GuardarRegistroVictimaFuncionario(
                        
                          appIA: 'IA',
                          idTipo: valueTipo,
                          id: myControllerID.text,
                          nombres: myControllerName.text,
                          apellidos: myControllerLastName.text,
                          nombreIdentitario: myControllerIdentitario.text,
                          telefonoCelular: myControllerNumber.text,
                          correo: myControllerEmail.text,
                          fechaRegistro: myControllerDate.text,
                          tipoConducta: "9",
                          direccion: myControllerDireccion.text,
                          ciudad: valueCiudadDenuncia,
                          departamento: valueDepartamentoDenuncia)));

                          
                },
                child: const Text(
                  'Registrar',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: "Pluto",
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
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

class CheckBoxRegistroFuncionario extends StatefulWidget {
  CheckBoxRegistroFuncionario({Key? key}) : super(key: key);

  @override
  State<CheckBoxRegistroFuncionario> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBoxRegistroFuncionario> {
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
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        });
  }
}

class DateWidgetRegistro extends StatefulWidget {
  DateWidgetRegistro({required this.myControllerDate});
  var myControllerDate = TextEditingController();

  @override
  State<DateWidgetRegistro> createState() =>
      _DateWidgetRegistroState(myControllerDate: myControllerDate);
}

class _DateWidgetRegistroState extends State<DateWidgetRegistro> {
  var myControllerDate = TextEditingController();

  _DateWidgetRegistroState({required this.myControllerDate});
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: myControllerDate, //editing controller of this TextField
        decoration:
            editTextDecoration("Fecha de registro", false, "Obligatorio"),
        readOnly: true, //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(DateTime.now().year - 1),
              firstDate: DateTime(
                  1900), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(DateTime.now().year));

          // if (pickedDate != null) {
          //   print(
          //       pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          //   String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          //   print(
          //       formattedDate); //formatted date output using intl package =>  2021-03-16
          //   //you can implement different kind of Date Format here according to your requirement

          //   setState(() {
          //     myControllerDate.text = formattedDate;
          //     //set output date to TextField value.
          //     valueDateRegistro = formattedDate;
          //   });
          // } else {
          //   print("Date is not selected");
          // }
        });
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

class ComboTipoConducta extends StatefulWidget {
  ComboTipoConducta({required this.listConductas});

  List<DropdownMenuItem<String>> listConductas = [];

  @override
  State<ComboTipoConducta> createState() =>
      _ComboTipoConductaState(listConductas: listConductas);
}

class _ComboTipoConductaState extends State<ComboTipoConducta> {
  List<DropdownMenuItem<String>> listConductas = [];

  List<DropdownMenuItem<String>> listaCiudadSelected = [];

  String selectedValueConducta = "";

  _ComboTipoConductaState({required this.listConductas});

  void estadoConductaNuevo(codigoCondcuta) {
    setState(() {
      valueTipoConducta = codigoCondcuta;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (valueTipoConducta == "") {
      valueTipoConducta = listConductas[0].value!;
    }

    return Column(
      children: [
        DropdownButtonFormField(
            value: valueTipoConducta,
            disabledHint: const Text("Tipo de conducta"),
            hint: const Text("Tipo de conducta"),
            decoration: editTextDecoration("Clase", false, "Obligatorio"),
            onChanged: (estado) => {estadoConductaNuevo(estado)},
            items: listConductas),
        const SizedBox(
          height: 10,
        )
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

class CombosLugarResidencia extends StatefulWidget {
  CombosLugarResidencia({
    required this.listEstados,
    required this.listMunicipios,
  });

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
              value: item.codigoMunicipios, child: Text(item.nombreMunicipio)),
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
