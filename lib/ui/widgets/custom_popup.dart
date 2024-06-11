import 'package:flutter/material.dart';

import 'package:infancia/domain/preferences/preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomPopUp extends StatelessWidget {
  const CustomPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
 

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/imgs/user-profile-square.png'),
        ),
      ),
      child: PopupMenuButton(
        iconColor: const Color.fromARGB(0, 255, 255, 255),
        onSelected: (value) {
          if (value == '1') {
            Navigator.pushNamed(context, 'profile');
          }
          if (value == '2') {
            Navigator.pushNamed(context, 'change_password');
            // Preferences.clearPreferences();
            // Navigator.pushReplacementNamed(context, 'login');
          }
          if (value == '3') {
            Navigator.pushNamed(context, 'about');
          }
          if (value == '4') {
            Navigator.pushNamed(context, 'pf_inside');
            // final url = Uri.parse(
            //     'https://appcontigo.com/Pfs/Infancia/PF_componentes_adentro_infancia.pdf');
            // launchUrl(url);
          }
          if (value == '5') {
            Preferences.clearPreferences();
            Navigator.pushReplacementNamed(context, 'login');
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
              value: '1',
              child: Row(
                children: [
                  Icon(Icons.person_2),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Perfil'),
                  ),
                ],
              )),
          const PopupMenuItem(
            value: '2',
            child: Row(
              children: [
                Icon(Icons.password),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Cambiar contraseña'),
                ),
              ],
            ),
          ),
          const PopupMenuItem(
            value: '3',
            child: Row(
              children: [
                Icon(Icons.error),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Acerca de '),
                ),
              ],
            ),
          ),
          const PopupMenuItem(
              value: '4',
              child: Row(
                children: [
                  Icon(Icons.question_mark_outlined),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Preguntas frecuentes'),
                  ),
                ],
              )),
          const PopupMenuItem(
            value: '5',
            child: Row(
              children: [
                Icon(Icons.exit_to_app),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Cerrar sesion'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//TODO: Poner el cerrar sesion de ultmo