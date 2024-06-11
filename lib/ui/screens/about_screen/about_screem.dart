import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:vesta_flutter/preferences.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF6599fe),
        toolbarHeight: 100,
        leading: IconButton(
          color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              width: 40,
              height: 40,
              image: AssetImage('assets/imgs/new_logo.png')
              ),
            Text(
              'Infancia y Adolescencia',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'poppins',
                  color: Colors.white),
            ),
          ],
        ),
      ),
      // appBar: AppBar(
      //   centerTitle: true,
      //   leading: IconButton(
      //       onPressed: () {},
      //       icon: const Icon(color: Colors.black, Icons.arrow_back_ios)),

      //   //leading: Icon(Icons.arrow_back_ios)
      //   backgroundColor: Colors.white,
      //   actions: const [
      //     Icon(
      //       Icons.search,
      //       color: Colors.transparent,
      //     )
      //   ],
      //   title: const Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Image(
      //           height: 150,
      //           width: 150,
      //           fit: BoxFit.scaleDown,
      //           filterQuality: FilterQuality.high,
      //           image: AssetImage('assets/imgs/logonew.png')),
      //       SizedBox(
      //         width: 5,
      //       ),
      //     ],
      //   ),
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  const Row(
                    children: [],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Card(
                      color: Colors.white,
                        surfaceTintColor: Colors.white,
                        elevation: 12,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Acerca de',
                                    style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.grey,
                                        fontFamily: "Pluto",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Text(
                                      'App Contigo infancia',
                                      style: TextStyle(
                                          fontSize: 26,
                                          color: Color(0xffB081E6),
                                          fontFamily: "Pluto",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '#NiñezConDerechos',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                        fontFamily: "Pluto",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Esta APP, hace parte de la solución tecnológica Proyecto vesta y  su propiedad intelectual esta  protegida según Certificado de Registro de Soporte Lógico # 13-83-357 del 11 de febrero de 2021, expedido por la Dirección Nacional de Derechos de Autor del Ministerio del Interior de Colombia.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontFamily: "Pluto",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var url = Uri.parse(
                                          'http://proyectovesta.com/M_Terminos_Condiciones.jsp');

                                      launchUrl(url);
                                    },
                                    child: const Text(
                                      'Terminos y condiciones',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontFamily: "Pluto",
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var url = Uri.parse(
                                          'http://proyectovesta.com/VestaMovil.jsp');

                                      launchUrl(url);
                                    },
                                    child: const Text(
                                      'www.protectovesta.com',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontFamily: "Pluto",
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Versión 2.5.3',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontFamily: "Pluto",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: "Pluto",
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: PopupMenuDivider(),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Image(
                                    image: AssetImage('assets/imgs/abuelito.png'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'En memoria de',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontFamily: "Pluto",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Luis Rafael Prado Pacheco.',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontFamily: "Pluto",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '29/05/1929 - 28/07/2020',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontFamily: "Pluto",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Gran esposo, padre y abuelo.',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontFamily: "Pluto",
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text(
                                  //   'Diseñado y desarrollado por: ',
                                  //   style: TextStyle(
                                  //       fontSize: 14,
                                  //       color: Colors.grey,
                                  //       fontFamily: "Pluto",
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     var url = Uri.parse('http://smartp.co/');

                                  //     launchUrl(url);
                                  //   },
                                  //   child: const Image(
                                  //     height: 100,
                                  //     width: 50,
                                  //     image: AssetImage(
                                  //         'images/logotipo_smartp.png'),
                                  //   ),
                                  // )
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
