import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final screnW = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NubeDos(),
          Padding(
            padding: EdgeInsets.only(top: screenH * 0.029),
            child: SvgPicture.asset('assets/imgs/nube2.svg')
            //  const Image(
            //   image: AssetImage('assets/imgs/vector(1).png'),
            // ),
          ),
          const NubeTres(),
          const ButtomImage()
        ],
      ),
    );
  }
}

class NubeDos extends StatelessWidget {
  const NubeDos({super.key});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final screnW = MediaQuery.sizeOf(context).width;

    return Stack(
      children: [

        Padding(
          padding: EdgeInsets.only(top: screenH * 0.06, left: screnW * 0.65),
          child: const Image(image: AssetImage('assets/imgs/nubedos.png')),
        ),
        Padding(
          padding: EdgeInsets.only(top: screenH * 0.070, left: screnW * 0.80),
          child:
            SvgPicture.asset('assets/imgs/logo_defensoria.svg')
        )
      ],
    );
  }
}

class NubeTres extends StatelessWidget {
  const NubeTres({super.key});

  @override
  Widget build(BuildContext context) {
    final screnW = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(
        left: screnW * 0.8,
      ),
      child: const Image(image: AssetImage('assets/imgs/nubetres.png')),
    );
  }
}

class ButtomImage extends StatelessWidget {
  const ButtomImage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final screnW = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(top: screenH * 0.41),
      child: SvgPicture.asset('assets/imgs/bottom_imgage.svg')
    );
  }
}
//javidevJ1
