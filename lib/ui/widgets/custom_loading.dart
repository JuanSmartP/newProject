

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class CustomLoading extends StatelessWidget {
  final int color;
  const CustomLoading({
    super.key,
    required this.screenH, required this.color,
  });

  final double screenH;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: screenH * 0.02),
      child: LoadingAnimationWidget.twistingDots(
          leftDotColor:  Color(color),
          rightDotColor: const Color(0xFF2a71ff),
          size: 60),
    );
  }
}