import 'package:flutter/material.dart';


class CustomInput extends StatelessWidget {

  final TextEditingController controller;
  
  final bool textObscure;
  final String textHint;
  final IconData? iconSuffix;
  const CustomInput({
    super.key,
    required this.textHint,
    this.iconSuffix,
    required this.textObscure, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: 24),
      child: TextField(
        controller: controller ,
        keyboardType: TextInputType.emailAddress,
        obscureText: textObscure,
        decoration: InputDecoration(
          fillColor: const Color(0xFFffffff),
          filled: true,
          suffixIcon: IconButton(onPressed: () {}, icon: Icon(iconSuffix)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          hintText: textHint,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        onChanged: (value) {
    
          
        },
      ),
    );
  }
}

