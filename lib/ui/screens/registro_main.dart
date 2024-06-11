import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/network/registros_iniciales.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/registros_iniciles.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/cardlist_registros_funcionario.dart';
import 'package:infancia/ui/screens/registro/bloc/registros_funcionario_bloc.dart';

final myControllerIdVictimas = TextEditingController();

class RegistrosMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegistroInicialRepository registroInicialRepository =
        RegistroInicialRepository(
            networkService: NetworkServiceRegistroInicial());

    RegistrosFuncionarioBloc registrosFuncionarioBloc =
        RegistrosFuncionarioBloc(repository: registroInicialRepository);

//    ContactoAsaBloc contactoAsaBloc = ContactoAsaBloc(
    //      repository: ContactoAsaRepository(networkService: NetworkAppVersion()));

    registrosFuncionarioBloc.add(getRegistrosIniciales());
    //   contactoAsaBloc.add(getContactoNumber(regional: Preferences.regional));

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        /*floatingActionButton: FloatingActionButton(
          heroTag: "addVic",
            final addVictima = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddVictima()));

            registrosFuncionarioBloc.add(getRegistrosIniciales());
          },
          backgroundColor: Utils().getColorFromHex("#6699FF"),
          child: const Icon(Icons.add),
        ),*/
        resizeToAvoidBottomInset: false,
        body: Center(
            child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => registrosFuncionarioBloc,
            ),
            // BlocProvider(
            //   create: (context) => contactoAsaBloc,
            // ),
          ],
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                const Row(
                  children: [
                    // Image(
                    //   color: Color(0xffE0E0E0),
                    //   image: AssetImage('assets/imgs/phone.png'),
                    // ),
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /*
                              SearchWidget(
                                  text: query,
                                  onChanged: searchRedes,
                                  hintText: "Buscar redes"),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Image(
                        //   color: Color(0xffE0E0E0),
                        //   alignment: Alignment.bottomRight,
                        //   image: AssetImage('assets/imgs/phone.png'),
                        // ),
                      ],
                    )
                  ],
                ),
                Column(
                  
                  
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
                          "REGISTROS",
                          style: TextStyle(
                            fontFamily: 'poppins',
                              // color: Utils()
                              //     .getColorFromHex(Preferences.colorEntidad),
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        // Container(
                        //   width: 50,
                        //   height: 50,
                        //   child: BlocBuilder<ContactoAsaBloc, ContactoAsaState>(
                        //     builder: (context, state) {
                        //       return state is ContactoAsaData
                        //           ? FloatingActionButton(
                        //               shape: const CircleBorder(),
                        //               heroTag: "contactoWhat",
                        //               onPressed: () async {
                        //                 final link = WhatsAppUnilink(
                        //                   phoneNumber: '+57${state.numero}',
                        //                   text: state.mensaje,
                        //                 );
                        //                 var url = Uri.parse(link.toString());
                        //                 await launchUrl(url);
                        //               },
                        //               backgroundColor:
                        //                   Utils().getColorFromHex("#6699FF"),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        elevation: 10.0,
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Buscar",
                                      style: TextStyle(
                                          // color: Utils().getColorFromHex(
                                          //     Preferences.colorEntidad),
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  enabled: true,
                                  controller: myControllerIdVictimas,
                                  decoration: editTextDecoration(
                                      "Buscar por identificación", "", false),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => () {},
                                ),
                                BlocBuilder<RegistrosFuncionarioBloc,
                                    RegistrosFuncionarioState>(
                                  builder: (context, state) {
                                    return OutlinedButton(
                                      onPressed: () {
                                        // if (myControllerIdVictimas.text == "") {
                                        //   displayDialog(context, "Registro",
                                        //       "Debe escribir una identificación");
                                        // } else {
                                        //   registrosFuncionarioBloc.add(
                                        //       getRegistroInicialesByid(
                                        //           idVictima:
                                        //               myControllerIdVictimas
                                        //                   .text));
                                        // }
                                      },
                                      style: OutlinedButton.styleFrom(
                                          // backgroundColor: Utils()
                                          //     .getColorFromHex(
                                          //         Preferences.colorEntidad),
                                          side: const BorderSide(
                                              color: Colors.white, width: 2),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          minimumSize: const Size(170, 40)),
                                      child: const Text(
                                        'Buscar',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: "Pluto",
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  },
                                )
                              ],
                            )),
                      ),
                    ),

                    /*
                              //--- Añadir una victima (?) ----//
                              Card(
                                elevation: 12,
                                child: InkWell(
                                  onTap: () async {
                                    final addDenuncia = await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AddVictima()),
                                    );
                                    /*
                                    denunciasBloc
                                        .add(getDenuncias(usuario: Preferences.usuario));*/
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Image(
                                          color: Preferences.entidadUsuario == "8001860611"
                            ? Color(0xff014898)
                            : Color(0xffFF2B66),
                                          alignment: Alignment.bottomRight,
                                          image: AssetImage('images/addDenuncia.png'),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Agregar víctima",
                                          style: TextStyle(
                                            color: Preferences.entidadUsuario == "8001860611"
                            ? Color(0xff014898)
                            : Color(0xffFF2B66),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )*/
                    BlocBuilder<RegistrosFuncionarioBloc,
                        RegistrosFuncionarioState>(
                      builder: (context, state) {
                        if (state is RegistrosFuncionariosConsultando) {
                          return Center(
                            child: CircularProgressIndicator(
                              // color: Utils()
                              //     .getColorFromHex(Preferences.colorEntidad),
                            ),
                          );
                        } else if (state is RegistrosFuncionarioData) {
                          return CardListRegistroFuncionario(
                              state.registroFuncionarioData,
                              registrosFuncionarioBloc,
                              state.registrosBlur);
                        } else {
                          if (state is RegistrosFuncionarioNohay) {
                            return const Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Center(
                                  child: Column(children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("No hay personas registradas")
                                  ]),
                                ),
                              ],
                            );
                          } else {
                            return state is SinConexionRegistrosFuncionarios
                                ? const Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                      ),
                                    ],
                                  )
                                : const Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                        "Lo sentimos, las operaciones no están disponibles en este momento. Por favor, inténtalo más tarde."),
                                  );
                          }
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  InputDecoration editTextDecoration(
      String hint, String helperText, bool state) {
    return InputDecoration(
        helperText: helperText,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 3,
              // color: Utils().getColorFromHex(Preferences.colorEntidad )
                 ),
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

/*
  void searchRedes(String query) {
    final listFilterRedes = widget.hurtosData.where((red) {
      final title = red.nombre.toLowerCase();
      final search = query.toLowerCase();
      return title.contains(search);
    }).toList();

    setState(() {
      tempRedesApoyo = listFilterRedes;
      query = query;
    });
  }*/
}
