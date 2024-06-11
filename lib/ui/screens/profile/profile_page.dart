import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:infancia/domain/network/profile_network.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/profile_repository.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/profile/bloc/profile_bloc.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:vesta_flutter/Blocs/EliminarCuenta/eliminarcuenta_bloc.dart';
// import 'package:vesta_flutter/Blocs/Profile/profile_bloc.dart';
// import 'package:vesta_flutter/Blocs/ProfilePhoto/profilephoto_bloc.dart';
// import 'package:vesta_flutter/Utils.dart';
// import 'package:vesta_flutter/main.dart';
// import 'package:vesta_flutter/models/municipio_model.dart';
// import 'package:vesta_flutter/network/porfile_network.dart';
// import 'package:vesta_flutter/pages/Login/login_page.dart';
// import 'package:vesta_flutter/pages/MenuPerfil/profile_edit_page.dart';
// import 'package:vesta_flutter/preferences.dart';
// import 'package:vesta_flutter/repositorry/profile_repository.dart';

String valueCiudadResidencia = "";
String valueDepartamentoResidencia = "";

bool estadoCampos = false;

// XFile? xFileImage;
// ImagePicker imagePicker = ImagePicker();
bool fotoPerfil = false;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ProfileRepository? repository =
        ProfileRepository(networkService: NetworkServiceProfile());

    final ProfileBloc profileBloc = ProfileBloc(repository: repository);

    // final ProfilephotoBloc profilephotoBloc = ProfilephotoBloc();

    // final EliminarcuentaBloc eliminarcuentaBloc = EliminarcuentaBloc();

    profileBloc
        .add((CargarCiudadesProfile(departamento: Preferences.pkDepartamento)));

    final myControllerLastName = TextEditingController();
    myControllerLastName.text = Preferences.apellidos;
    final myControllerName = TextEditingController();
    myControllerName.text = Preferences.nombre;
    final myControllerNumber = TextEditingController();
    myControllerNumber.text = Preferences.celular;
    final myControllerDireccion = TextEditingController();
    myControllerDireccion.text = Preferences.direccion;
    valueCiudadResidencia = Preferences.pkMunicipio;
    valueDepartamentoResidencia = Preferences.pkDepartamento;
    estadoCampos = false;

    var textoPerfilEntidad = "";

    switch (Preferences.perfilEntidad) {
      case "1":
        textoPerfilEntidad = "Nacional";

        break;
      case "2":
        textoPerfilEntidad = "Departamental";

        break;
      case "3":
        textoPerfilEntidad = "Municipal";

        break;
      case "5":
        textoPerfilEntidad =
            "\nRegional ${Utils.decodificarElemento(Preferences.nameRegional)}";

        break;
      default:
    }

    return  Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: () {
                 Navigator.pop(context);
              }, icon: const Icon(
                color: Colors.white,
                Icons.arrow_back_ios)),
              centerTitle: true,
              toolbarHeight: 100,
              backgroundColor:
                  Utils().getColorFromHex(Preferences.colorEntidad),
              title: Preferences.perfil == "5"
                  ? Text(
                      "Perfil Funcionario $textoPerfilEntidad",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "Pluto",
                          fontWeight: FontWeight.bold),
                    )
                  : Preferences.perfil == "2"
                      ? const Text(
                          "Perfil Víctima",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "Pluto",
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "Perfil Administrador - $textoPerfilEntidad",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "Pluto",
                              fontWeight: FontWeight.bold),
                        ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Preferences.perfil == "2"
                      ? GestureDetector(
                          onTap: () async {
                            // final editData = await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ProfileEdit()),
                            // );
                            setState(() {
                              myControllerName.text = Preferences.nombre;
                              myControllerLastName.text = Preferences.apellidos;
                              myControllerNumber.text = Preferences.celular;
                              myControllerDireccion.text =
                                  Utils.decodificarElemento(
                                      Preferences.direccion);

                              valueDepartamentoResidencia =
                                  Preferences.pkDepartamento;
                              valueCiudadResidencia = Preferences.pkMunicipio;
                            });
                            profileBloc.add((CargarCiudadesProfile(
                                departamento: Preferences.pkDepartamento)));
                          },
                          child: const Icon(Icons.edit))
                      : Container(),
                )
              ],
            ),
            backgroundColor: Colors.white,
            body: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => profileBloc),
                  // BlocProvider(create: (context) => profilephotoBloc),
                  // BlocProvider(create: (context) => eliminarcuentaBloc),
                ],
                child: SingleChildScrollView(
                  child: SafeArea(
                      child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Column(
                        children: [
                          Container(
                              color: Utils()
                                  .getColorFromHex(Preferences.colorEntidad),
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // Preferences.perfil == "5"
                                  //     ? Text(
                                  //         "Perfil Funcionario $textoPerfilEntidad",
                                  //         style: const TextStyle(
                                  //             fontSize: 18,
                                  //             color: Colors.white,
                                  //             fontFamily: "Pluto",
                                  //             fontWeight: FontWeight.bold),
                                  //       )
                                  //     : Preferences.perfil == "2"
                                  //         ? const Text(
                                  //             "Perfil Víctima",
                                  //             style: TextStyle(
                                  //                 fontSize: 18,
                                  //                 color: Colors.white,
                                  //                 fontFamily: "Pluto",
                                  //                 fontWeight: FontWeight.bold),
                                  //           )
                                  //         : Text(
                                  //             "Perfil Administrador - $textoPerfilEntidad",
                                  //             style: const TextStyle(
                                  //                 fontSize: 18,
                                  //                 color: Colors.white,
                                  //                 fontFamily: "Pluto",
                                  //                 fontWeight: FontWeight.bold),
                                  //           ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // ignore: prefer_const_constructors
                                  Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children:   [

                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: const CircleAvatar(
                                          radius: 70,
                                          child: Image(
                                            fit: BoxFit.cover,
                                            image: AssetImage('assets/imgs/profile_user.png')),
                                        ),
                                      )
                                      // BlocBuilder<ProfilephotoBloc,
                                      //     ProfilephotoState>(
                                      //   builder: (context, state) {
                                      //     return Preferences.foto ==
                                      //             'No tiene'
                                      //         ? const CircleAvatar(
                                      //             radius: 80,
                                      //             backgroundImage: AssetImage(
                                      //                 'images/userimage.png'))
                                      //         : !fotoPerfil
                                      //             ? CircleAvatar(
                                      //                 radius: 80,
                                      //                 backgroundImage:
                                      //                     NetworkImage(
                                      //                         getRealURL(
                                      //                             Preferences
                                      //                                 .foto)))
                                      //             : state is ChangedPhoto
                                      //                 ? CircleAvatar(
                                      //                     radius: 80,
                                      //                     backgroundImage:
                                      //                         FileImage(File(
                                      //                             xFileImage!
                                      //                                 .path)))
                                      //                 : CircleAvatar(
                                      //                     radius: 80,
                                      //                     backgroundImage:
                                      //                         NetworkImage(
                                      //                             getRealURL(
                                      //                                 Preferences
                                      //                                     .foto)));
                                      //   },
                                      // ),
                                      // BlocBuilder<ProfilephotoBloc,
                                      //     ProfilephotoState>(
                                      //   builder: (context, state) {
                                      //     return state is ChangingPhoto
                                      //         ? Container(
                                      //             width: 50,
                                      //             height: 50,
                                      //             decoration: BoxDecoration(
                                      //                 border: Border.all(
                                      //                     color: Colors.white,
                                      //                     width: 1),
                                      //                 shape: BoxShape.circle,
                                      //                 color: Colors.white),
                                      //             child:
                                      //                 CircularProgressIndicator(
                                      //               color: Preferences
                                      //                           .entidadUsuario ==
                                      //                       "8001860611"
                                      //                   ? const Color(0xff014898)
                                      //                   : const Color(0xffFF2B66),
                                      //             ))
                                      //         : Preferences.perfil == "2"
                                      //             ? Visibility(
                                      //                 child: AddPhtoto(
                                      //                 profilephotoBloc:
                                      //                     profilephotoBloc,
                                      //               ))
                                      //             : Visibility(
                                      //                 visible: false,
                                      //                 child: AddPhtoto(
                                      //                   profilephotoBloc:
                                      //                       profilephotoBloc,
                                      //                 ));
                                      //   },
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    Preferences.usuario,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: "Pluto",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              enabled: estadoCampos,
                              controller: myControllerName,
                              decoration: editTextDecoration(
                                  Utils.decodificarElemento(
                                      Preferences.perfil != '3'
                                          ? Preferences.nombre
                                          : Preferences.nombreEntidad),
                                  false),
                              onChanged: (value) => () {},
                            ),
                          ),
                          Preferences.perfil != '3'
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    enabled: estadoCampos,
                                    controller: myControllerLastName,
                                    decoration: editTextDecoration(
                                        Preferences.apellidos, false),
                                    onChanged: (value) => () {},
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              enabled: estadoCampos,
                              controller: myControllerNumber,
                              decoration: editTextDecoration(
                                  Preferences.celular, false),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (value) => () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                return state is CiudadesDataProfile
                                    ? CombosResidenciaPerfil(
                                        listEstados: state.listEstadosDrop,
                                        listCiudades: state.listMunicipiosDrop,
                                      )
                                    : Container();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              enabled: estadoCampos,
                              controller: myControllerDireccion,
                              decoration: editTextDecoration(
                                  Utils.decodificarElemento(
                                      Preferences.direccion),
                                  false),
                              onChanged: (value) => () {},
                            ),
                          ),
                          Preferences.perfil == '2'
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // child: BlocBuilder<EliminarcuentaBloc,
                                    //     EliminarcuentaState>(
                                    //   builder: (context, state) {
                                    //     return state is DeletingState
                                    //         ? CircularProgressIndicator(
                                    //             color: Preferences
                                    //                         .entidadUsuario ==
                                    //                     "8001860611"
                                    //                 ? const Color(0xff014898)
                                    //                 : const Color(0xffFF2B66),
                                    //           )
                                    //         : OutlinedButton(
                                    //             onPressed: () {
                                    //               context
                                    //                   .read<
                                    //                       EliminarcuentaBloc>()
                                    //                   .add(DeleteAccount());
                                    //             },
                                    //             // ignore: sort_child_properties_last
                                    //             child: const Text(
                                    //               "Eliminar cuenta",
                                    //               style: TextStyle(
                                    //                 fontSize: 16,
                                    //                 color: Colors.white,
                                    //               ),
                                    //             ),
                                    //             style: OutlinedButton.styleFrom(
                                    //                 backgroundColor:
                                    //                     Colors.redAccent,
                                    //                 side: const BorderSide(
                                    //                     color: Colors.white,
                                    //                     width: 2),
                                    //                 shape: const RoundedRectangleBorder(
                                    //                     borderRadius:
                                    //                         BorderRadius.all(
                                    //                             Radius
                                    //                                 .circular(
                                    //                                     6))),
                                    //                 minimumSize:
                                    //                     const Size(150, 40)),
                                    //           );
                                    //   },
                                    // ),
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // FloatingButtonEdit(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
                )));
  }

  String getRealURL(String url) {
    List<String> urlSplit = url.split("/");

    return "http://proyectovesta.com/${urlSplit[6]}/${urlSplit[7]}/${urlSplit[8]}";
  }

  void displayDialogDenuncias(
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
                  onPressed: () => {Navigator.pop(context)},
                  child: const Text("Aceptar"))
            ],
          );
        });
  }

  // void displayDialogDenunciasEliminar(EliminarcuentaBloc eliminarcuentaBloc,
  //     BuildContext context, String title, String message) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           elevation: 5,
  //           title: Text(title),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(message),
  //               const SizedBox(
  //                 width: 10,
  //               )
  //             ],
  //           ),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   eliminarcuentaBloc.add(NoDelete());
  //                   //context.read<EliminarcuentaBloc>().add(NoDelete());
  //                 },
  //                 child: const Text("Cancelar")),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   eliminarcuentaBloc.add(
  //                       DeleteAccountNow()); /*
  //                   context.read<EliminarcuentaBloc>().add(DeleteAccountNow());*/
  //                 },
  //                 child: const Text("Aceptar")),
  //           ],
  //         );
  //       });
  // }
}

class FloatingButtonEdit extends StatefulWidget {
  FloatingButtonEdit({Key? key}) : super(key: key);

  @override
  State<FloatingButtonEdit> createState() => _FloatingButtonEditState();
}

class _FloatingButtonEditState extends State<FloatingButtonEdit> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "edit",
      onPressed: () {
        setState(() {
          estadoCampos = true;
          print(estadoCampos);
        });
      },
      backgroundColor: Utils().getColorFromHex(Preferences.colorEntidad),
      child: const Icon(Icons.edit),
    );
  }
}

class CombosResidenciaPerfil extends StatefulWidget {
  CombosResidenciaPerfil(
      {required this.listEstados, required this.listCiudades});

  List<DropdownMenuItem<String>> listEstados = [];
  List<DropdownMenuItem<String>> listCiudades = [];

  @override
  State<CombosResidenciaPerfil> createState() => _CombosResidenciaPerfilState(
      listEstados: listEstados, listCiudades: listCiudades);
}

class _CombosResidenciaPerfilState extends State<CombosResidenciaPerfil> {
  var codigoCiudadResidencia;
  _CombosResidenciaPerfilState(
      {required this.listEstados, required this.listCiudades});
  List<DropdownMenuItem<String>> listEstados = [];
  List<DropdownMenuItem<String>> listCiudades = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
            value: valueDepartamentoResidencia,
            disabledHint: const Text("Magdalena"),
            decoration: editTextDecoration("Clase", false),
            onChanged: null,
            items: listEstados),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
            value: valueCiudadResidencia,
            disabledHint: const Text("Seleccionar ciudad"),
            hint: const Text("Estado"),
            decoration: editTextDecoration("Clase", false),
            onChanged: estadoCampos
                ? (value) {
                    valueCiudadResidencia = value.toString();
                    codigoCiudadResidencia = value;
                  }
                : null,
            items: listCiudades)
      ],
    );
    ;
  }
}

Future<Uint8List> networkImageToBase64(String imageUrl) async {
  String urlLink =
      "http://proyectovesta.com/ProyectoVesta/Fotos/Usuario/629125d28dfb4.jpg";

  var url = Uri.parse(urlLink);
  http.Response response = await http.get(url);
  return response.bodyBytes;
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

class AddPhtoto extends StatefulWidget {
  // AddPhtoto({required this.profilephotoBloc, Key? key}) : super(key: key);

  // final ProfilephotoBloc profilephotoBloc;

  @override
  State<AddPhtoto> createState() => _AddPhtotoState();
}

class _AddPhtotoState extends State<AddPhtoto> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        /*
                        xFileImage = await imagePicker.pickImage(
                            source: ImageSource.camera);
                        if (xFileImage != null) {
                          setState(() {
                            isPictureAdded = true;
                          });
                        }*/
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 250,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () async {
                        // Navigator.pop(context);
                        // xFileImage = await imagePicker.pickImage(
                        //     source: ImageSource.camera);
                        // if (xFileImage != null) {
                        //   widget.profilephotoBloc
                        //       .add(UpdatePerfilPhoto(xFileImage: xFileImage));
                        //   setState(() {
                        //     fotoPerfil = true;
                        //   });
                        // }
                      },
                      child: const ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text("Desde la camara"),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);

                          fotoPerfil = true;

                          // xFileImage = await imagePicker.pickImage(
                          //     source: ImageSource.gallery);
                          // if (xFileImage != null) {
                          //   widget.profilephotoBloc
                          //       .add(UpdatePerfilPhoto(xFileImage: xFileImage));
                          //   setState(() {
                          //     fotoPerfil = true;
                          //   });
                          // }
                        },
                        child: const ListTile(
                          leading: Icon(Icons.photo),
                          title: Text("Desde el albúm"),
                        )),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: const ListTile(
                          leading: Icon(Icons.cancel),
                          title: Text("Cancelar"),
                        ))
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            shape: BoxShape.circle,
            color: Colors.white),
        child: Icon(
          Icons.edit,
          color: Utils().getColorFromHex(Preferences.colorEntidad),
        ),
      ),
    );
  }
}
