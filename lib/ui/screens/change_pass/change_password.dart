import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/change_password/bloc/changepassword_bloc.dart';

final myControllerPassword = TextEditingController();
final myControllerRepeatPassword = TextEditingController();
final myControllerNewPassword = TextEditingController();

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Seguridad ciudadana',
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 70,
              leading: GestureDetector(
                onTap: () => {
                  myControllerPassword.text = "",
                  myControllerRepeatPassword.text = "",
                  myControllerNewPassword.text = "",
                  Navigator.pop(
                    context,
                  )
                },
                child:  IconButton(onPressed: () {
                  Navigator.pop(context);
                  
                }, icon: const Icon(
                  color: Colors.white,
                  Icons.arrow_back_ios_new_outlined))
              ),
              backgroundColor:
                 Colors.blue,
              title: const Text(
                'Cambio de contraseña',
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: BlocProvider(
                create: (context) => ChangepasswordBloc(),
                child: BlocListener<ChangepasswordBloc, ChangepasswordState>(
                    listener: (context, state) {
                      if (state is PasswordNoIguales) {
                        displayDialog(context, "Cambio de contraseña",
                            "Las contraseñas no coinciden.");
                      }

                      if (state is PasswordNoValida) {
                        displayDialog(context, "Cambio de contraseña",
                            "La contraseña nueva no cumple con los criterios.");
                      }

                      if (state is PasswordNoIgual) {
                        displayDialog(context, "Cambio de contraseña",
                            "Las contraseñas no coinciden con tu contraseña actual.");
                      }

                      if (state is PasswordChnaged) {
                        displayDialogSuccess(context, "Cambio de contraseña",
                            "Contraseña cambiada correctamente.");
                        myControllerNewPassword.text = "";
                        myControllerPassword.text = "";
                        myControllerRepeatPassword.text = "";
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Esta nueva contraseña debe tener:"),
                          const Text("• Igual o más de 6 caracteres."),
                          const Text("• Por lo menos una letra mayuscula."),
                          const Text("• Un numero."),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: myControllerPassword,
                            obscureText: true,
                            decoration: editTextDecoration("Contraseña", false),
                            onChanged: (value) => () {
                              setState(() {
                                myControllerPassword.text = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: myControllerRepeatPassword,
                            obscureText: true,
                            decoration:
                                editTextDecoration("Repetir contraseña", false),
                            onChanged: (value) => () {
                              setState(() {
                                myControllerRepeatPassword.text = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: myControllerNewPassword,
                            obscureText: true,
                            decoration: editTextDecoration(
                              "Nueva contraseña",
                              false,
                            ),
                            onChanged: (value) => () {
                              setState(() {
                                myControllerNewPassword.text = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<ChangepasswordBloc, ChangepasswordState>(
                            builder: (context, state) {
                              return state is CambiandoPassword?
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Center(
                                      child: OutlinedButton(
                                        onPressed: () => {
                                          context
                                              .read<ChangepasswordBloc>()
                                              .add(ChangePasswordToNew(
                                                  oldPassword:
                                                      myControllerPassword.text,
                                                  repeatOldPassword:
                                                      myControllerRepeatPassword
                                                          .text,
                                                  newPassword:
                                                      myControllerNewPassword
                                                          .text))
                                        },
                                        style: OutlinedButton.styleFrom(
                                            backgroundColor:Colors.blue,
                                            side: const BorderSide(
                                                color: Colors.white, width: 2),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            minimumSize: const Size(200, 50)),
                                        child: const Text(
                                          'Cambiar contraseña',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontFamily: "Pluto",
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    );

                              ;
                            },
                          )
                        ],
                      ),
                    )),
              ),
            )));
  }
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

void displayDialog(BuildContext context, String title, String message) {
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
                onPressed: () => Navigator.pop(context),
                child: const Text("Aceptar"))
          ],
        );
      });
}

void displayDialogSuccess(BuildContext context, String title, String message) {
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
                onPressed: () => Navigator.pop(context),
                child: const Text("Aceptar"))
          ],
        );
      });
}
