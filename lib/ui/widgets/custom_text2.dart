import 'package:flutter/material.dart';

class CustomText2 extends StatelessWidget {
  final Function changePassword;

  const CustomText2({
    super.key, required this.changePassword,
  });

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(context).width;
    return Padding(
      padding:   EdgeInsets.symmetric(vertical: screenW * 0.01),
      child: TextButton(
        onPressed: () {
          changePassword();
        },
        child: const Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(
              
              fontFamily: 'poppins',
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4581f5)),
        ),
      ),
    );
  }
}
