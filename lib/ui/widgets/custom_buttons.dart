import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/ui/screens/login/bloc/login_bloc.dart';

class CustomButtonm extends StatelessWidget {
  // Victima 0xFFfb7c92

  // Funcionario 0xFF2a71ff
  final Function onPressed;
  final int buttonColor;
  const CustomButtonm({
    super.key,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidtg = MediaQuery.sizeOf(context).width;
    final screenH = MediaQuery.sizeOf(context).height;

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state is LoginLoading
            // ignore: prefer_const_constructors
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: screenWidtg * 0.0685),
                child: const CircularProgressIndicator(),
              )
            : SizedBox(
                width: screenWidtg * 0.4,
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenH * 0.05, top: 24),
                  child: ClipRRect(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        minimumSize: const Size(50, 50),
                        backgroundColor: Color(buttonColor),
                      ),
                      onPressed: () {
                        onPressed();
                      },
                      child: const Text(
                        'Ingresar',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
