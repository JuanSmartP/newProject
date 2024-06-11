import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infancia/ui/screens/screens.dart';

class PfInside extends StatelessWidget {
  const PfInside({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Preguntas frecuentes',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
                color: Colors.white, Icons.arrow_back_ios_new_outlined)),
      ),
      body: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          PfCard(
              title: 'Componentes de la app ',
              urlPf:
                  'https://appcontigo.com/Pfs/Infancia/PF_componentes_adentro_infancia.pdf'),
          PfCard(title: '¿Como agregar una persona?', urlPf: 'https://appcontigo.com/Pfs/Infancia/PF_registros_infancia.pdf'),
          PfCard(title: '¿Como registrar un caso o entrevista?', urlPf: 'https://appcontigo.com/Pfs/Infancia/PF_casos_infancia.pdf'),
          PfCard(title: '¿Como cambiar el estado las solicitudes?', urlPf: 'https://appcontigo.com/Pfs/Infancia/PF_solicitudes_infancia.pdf'),
        ],
      ),
    );
  }
}
