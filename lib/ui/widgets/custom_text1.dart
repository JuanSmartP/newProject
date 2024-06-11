import 'package:flutter/material.dart';

class CustomText1 extends StatelessWidget {
  final String textValue;
  const CustomText1({
    super.key,
    required this.textValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Text(
        textValue,
        style: const TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF4581f5)),
      ),
    );
  }
}