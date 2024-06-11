import 'package:flutter/material.dart';

class CustomSolicitudes extends StatelessWidget {
  const CustomSolicitudes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final screenW = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'solicitudes');
      },
      child: Padding(
        padding: EdgeInsets.only(left: screenW * 0.7),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          width: screenW * 0.22,
          height: screenH * 0.1,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(color: Color(0xFF004897), Icons.message),
              Text(
                'Solicitudes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004897)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
