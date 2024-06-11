import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/network/verificarID_service.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/verificarIID_repository.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/entrevista/entrevista_main.dart';
import 'package:infancia/ui/screens/victima/bloc/verificar_victima_bloc.dart';
import 'package:infancia/ui/widgets/registros_main.dart';
// import 'package:vesta_flutter/Utils.dart';
// import 'package:vesta_flutter/network/verificarID_service.dart';
// import 'package:vesta_flutter/pages/MainMenu/Denuncias/add_denuncia_defensoria.dart';
// import 'package:vesta_flutter/preferences.dart';
// import 'package:vesta_flutter/repositorry/verificarID_repository.dart';

// import '../../../Blocs/VerificarVictima/verificar_victima_bloc.dart';
// import '../../MenuPerfil/change_password_page.dart';

final myControllerVictimaID = TextEditingController();

class ExisteVictimaDenuncia extends StatefulWidget {
  @override
  State<ExisteVictimaDenuncia> createState() => _ExisteVictimaDenunciaState();
}

class _ExisteVictimaDenunciaState extends State<ExisteVictimaDenuncia> {
  VerificarVictimaBloc verificarVictimaBloc = VerificarVictimaBloc(
      verificarIDRepository:
          VerificarIDRepository(networkService: VerificarIDService()));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            
            centerTitle: true,
            title: const Text(
              "Verificar víctima",
              style: TextStyle(color: Colors.white),
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                );
                myControllerVictimaID.text = "";
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.blue
          ),
          backgroundColor: const Color(0xffF9F9F9),
          body: BlocProvider(
              create: (context) => verificarVictimaBloc,
              child: BlocListener<VerificarVictimaBloc, VerificarVictimaState>(
                listener: (context, state) {
                  if (state is UserNotExist) {
                    Utils.displayDialogCampos(context, "Verificación víctima",
                        "Esta víctima no esta registrada. Puede registrarlo en la sección de Registros.");
                  }

                  if (state is UserBloqueo) {
                    Utils.displayDialogCampos(context, "Verificación víctima",
                        "Lo sentimos, las operaciones no están disponibles en este momento. Por favor, inténtalo más tarde.");
                  }

                  if (state is UserVictimaSinConexion) {
                    Utils.displayDialogCampos(context, "Mensaje",
                        "Lo sentimos, no se ha detectado una conexión a internet estable. \n\nSin embargo, puede aprovechar y activar el modo offline en configuración para registrar un caso de manera local y posteriormente subirlo al retomar la conexión.");
                  }

                  if (state is UserNotExistUsuario) {
                    Utils.displayDialogCampos(context, "Verificación víctima",
                        "Esta víctima esta registrada pero no cuenta con usuario.");
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      !Preferences.offline
                          ? const Text(
                              "A continuación digita la identificación de la persona para verificar si se encuentra registrado.",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      Preferences.offline
                          ? const Text(
                              "Estás en modo offline. En este modo, puedes dirigirte a registrar el caso sin buscar a la persona.",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      !Preferences.offline
                          ? TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              enabled: true,
                              controller: myControllerVictimaID,
                              decoration:
                                  editTextDecoration("Buscar", "", false),
                              onChanged: (value) => () {},
                            )
                          : Container(),
                      BlocBuilder<VerificarVictimaBloc, VerificarVictimaState>(
                        builder: (context, state) {
                          return state is ConsultandoUsuario
                              ? const Center(child: CircularProgressIndicator())
                              : OutlinedButton(
                                  onPressed: () {
                                    if (Preferences.offline) {
                                      //Offline
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>

                                      //   ),
                                      // );
                                    } else {
                                      //Online
                                      if (myControllerVictimaID.text == "") {
                                        displayDialog(context, "Casos",
                                            "Debe escribir una identificación");
                                      } else {
                                        verificarVictimaBloc.add(getUserExist(
                                            id: myControllerVictimaID.text));
                                      }
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Utils().getColorFromHex(
                                          Preferences.colorEntidad),
                                      side: const BorderSide(
                                          color: Colors.white, width: 2),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      minimumSize: const Size(170, 40)),
                                  child: Text(
                                    Preferences.offline
                                        ? 'Continuar'
                                        : "Buscar",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: "Pluto",
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                        },
                      ),
                      BlocBuilder<VerificarVictimaBloc, VerificarVictimaState>(
                        builder: (context, state) {
                          return state is UserData
                              ? Card(
                                  surfaceTintColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11.0),
                                  ),
                                  elevation: 10.0,
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.userdata.id.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Utils().getColorFromHex(
                                                    Preferences.colorEntidad)),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Nombres: ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                state.userdata.nombre
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                state.userdata.apellidos
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          MaterialButton(
                                              color: Utils().getColorFromHex(
                                                  Preferences.colorEntidad),
                                              onPressed: () {
                                                /*
                                                if (Preferences
                                                        .entidadUsuario ==
                                                    '8001860611') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddDenunciaFormDefensoria(
                                                                state
                                                                    .userdata)),
                                                  );
                                                } else {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddDenunciaForm(
                                                                state
                                                                    .userdata)),
                                                  );
                                                }*/
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EntrevistaMain(
                                                              id: state
                                                                  .userdata.id!,
                                                              names: state
                                                                  .userdata
                                                                  .nombre!,
                                                              apellidos: state
                                                                  .userdata
                                                                  .apellidos!)),
                                                );
                                              },
                                              child: const Text(
                                                "Continuar",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ))
                                        ],
                                      )))
                              : Container();
                        },
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}

InputDecoration editTextDecoration(String hint, String helperText, bool state) {
  return InputDecoration(
      helperText: helperText,
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
