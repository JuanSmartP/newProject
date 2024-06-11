import 'package:flutter/material.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            leading: GestureDetector(
              onTap: () => {
                Navigator.pop(
                  context,
                )
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.blue,

            //  Preferences.entidadUsuario == "8001860611"
            //     ? const Color(0xff014898)
            //     : const Color(0xff014898),
            title: const Text(
              'Preguntas frecuentes',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: const Column(
            children: [
              PfCard(
                  title: "Componentes de la aplicación",
                  urlPf:
                      'https://appcontigo.com/Pfs/Infancia/PF_componentes_infancia.pdf'),
              PfCard(
                  title: "¿Cómo iniciar sesión?",
                  urlPf:
                      'https://appcontigo.com/Pfs/Infancia/PF_login_infancia.pdf'),
              PfCard(
                  title: "¿Cómo usar el canal de atención?",
                  urlPf:
                      'https://appcontigo.com/Pfs/Infancia/PF_solicitud_infancia.pdf'),
              // PfCard(
              //     title: "¿Cómo recuperar contraseña?",
              //     urlPf: 'http://proyectovesta.com/Pfs/pf_Recuperar.pdf'),
            ],
          )),
    );
  }
}

class PfCard extends StatelessWidget {
  final String title;
  final String urlPf;

  const PfCard({required this.title, required this.urlPf});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: () {
            var url = Uri.parse(urlPf);

            launchUrl(url);
          },
          child: Card(
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
              ),
              elevation: 10.0,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Preferences.entidadUsuario == "8001860611"
                                ? const Color(0xff014898)
                                : const Color(0xff014898)),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Preferences.entidadUsuario == "8001860611"
                            ? const Color(0xff014898)
                            : const Color(0xff014898),
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}
