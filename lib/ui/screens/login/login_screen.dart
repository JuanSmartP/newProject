import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/ui/screens/login/bloc/login_bloc.dart';
import 'package:infancia/ui/screens/screens.dart';
import 'package:infancia/ui/widgets/login_background.dart';

import '../../widgets/widgets.dart';

 

final email = TextEditingController();

final password = TextEditingController();

class CustomLoginScreen extends StatelessWidget {
  const CustomLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFb5ecff),
      body: Preferences.id.isNotEmpty
          ? const HomeScreen()
          : Stack(
              children: [
                const LoginBackground(),
                SingleChildScrollView(
                  child: BlocProvider(
                    create: (context) => LoginBloc(),
                    child: BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          email.text = "";
                          password.text = "";
                          Navigator.pushReplacementNamed(context, 'home');
                        }

                        if (state is EmptyFields) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Iniciar Sesion'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                      'Asegurate de escribir tu correo y contraseña'),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Aceptar',
                                        style: TextStyle(color: Colors.blue),
                                      ))
                                ],
                              ),
                            ),
                          );
                        }

                        if (state is LoginFails) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Iniciar Sesion'),
                              // ignore: avoid_unnecessary_containers
                              content: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                        'Usuario o contraseña incorrectos'),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);

                                          // ignore: prefer_const_constructors
                                        },
                                        child: const Text(
                                          'Aceptar',
                                          style: TextStyle(color: Colors.blue),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        if (state is LoginBlock) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Iniciar Sesion'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                      "Este usuario aún no se encuentra activo. Favor comunicarse con nosotros para más información a: \n\ninfo@proyectovesta.com"),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);

                                        // ignore: prefer_const_constructors
                                      },
                                      child: const Text(
                                        'Aceptar',
                                        style: TextStyle(color: Colors.blue),
                                      ))
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      child: const LoginBody(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// LoginBody(screenHeight: screenHeight, screenWidth: screenWidth),

class LoginBody extends StatefulWidget {
  const LoginBody({
    super.key,
  });

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool _isEnable = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tooltip(
          message: 'Preguntas Frecuentes',
          child: Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.09, right: screenWidth * 0.85),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'pf');
                },
                icon: const Icon(
                  size: 30,
                  color: Color( 0xFF2a71ff),
                  
                  Icons.info_outline)),
          ),
        ),

        Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.09, bottom: screenHeight * 0.05),
            // ignore: prefer_const_constructors
            child: SvgPicture.asset(
                width: 70,
                height: 70,
                'assets/imgs/logo_appContigo_infancia.svg')),
        // Padding(
        //   padding: EdgeInsets.only(bottom: widget.screenHeight * 0.1),
        //   child: const Text(
        //     'Infancia y adolescencia',
        //     style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'poppins',
        //         fontSize: 22,
        //         color: Colors.white),
        //   ),
        // ),
        const CustomText1(textValue: 'Iniciar sesión'),
        CustomInput(
          textHint: 'Correo',
          textObscure: false,
          controller: email,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,  ),
          child: TextField(
            controller: password,
            obscureText: _isEnable,
            decoration: InputDecoration(
              fillColor: const Color(0xFFffffff),
              filled: true,
              suffixIcon: dsdasa(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12)),
              hintText: 'Contraseña',
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
          ),
        ),
        // CustomText2(changePassword: () {
        //   Navigator.pushNamed(context, 'change_password');
        // }),

        CustomButtonm(
            buttonColor: 0xFF2a71ff,
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (context) => const Dialog(
              //     child: CustomDialogAlert(message: 'El boton funciona'),
              //   ),
              // );

              context.read<LoginBloc>().add(
                  LoginSubmitted(username: email.text, pass: password.text));
            }),
        // GestureDetector(
        //   onTap: () {
        //       showDialog(
        //       context: context,
        //       builder: (context) => const Dialog(
        //         child: CustomDialogAlert(message: 'El boton funciona'),
        //       ),
        //     );

        //   },
        //   child: Container(
        //     width: 70,
        //     child: const Card(
        //       child: Text('Ingresar'),
        //     ),
        //   ),
        // ),

        // TextButton(
        //     onPressed: () {
        //       showDialog(
        //         context: context,
        //         builder: (context) => const Dialog(
        //           child: CustomDialogAlert(message: 'El boton funciona'),
        //         ),
        //       );
        //     },
        //     child: Text('ingresar')),
        // ElevatedButton(-
        //   onPressed: ()  {

        //   },
        //   child: const Text(
        //     'Ingresar',
        //     style: TextStyle(
        //       fontFamily: 'poppins',
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        // CustomButtonm(
        //   buttonColor: 0xFF4581f5,
        //   onPressed: () {
        //     context
        //         .read<LoginBloc>()
        //         .add(LoginSubmitted(username: email.text, pass: password.text));
        //   },
        // ),
        CustomText3(text: '#NosUnenTusDerechos', widget: widget),
        CustomText3(text: '#NiñezConDerechos', widget: widget),
        const CustomSolicitudes()
      ],
    );
  }

  Widget dsdasa() {
    return IconButton(
        onPressed: () {
          setState(() {
            _isEnable = !_isEnable;
          });
        },
        icon: _isEnable
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off));
  }
}

class CustomText3 extends StatelessWidget {
  final String text;
  const CustomText3({
    super.key,
    required this.widget,
    required this.text,
  });

  final LoginBody widget;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    return Padding(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.symmetric(vertical: screenH * 0.01),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'poppins',
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color(0xFF4581f5),
        ),
      ),
    );
  }
}
