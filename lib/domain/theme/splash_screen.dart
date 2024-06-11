import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infancia/ui/screens/login/login_screen.dart';
import 'package:infancia/ui/widgets/custom_loading.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  //   Future.delayed(const Duration(seconds: 3), () {
  //     Navigator.pushReplacementNamed(context, 'login');
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    return FlutterSplashScreen.fadeIn(
      duration: const Duration(seconds: 4),
      backgroundColor: const Color(0xFFb5ecff),
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
              width: 100,
              height: 100,
              'assets/imgs/logo_appContigo_infancia.svg'),
          CustomLoading(
             color: 0xFFffffff,
            screenH: screenH)
        ],
      ),
      nextScreen: const CustomLoginScreen(),
    );
  }
}


