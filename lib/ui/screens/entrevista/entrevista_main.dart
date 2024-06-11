import 'package:flutter/material.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/entrevista/entrevista_preguntas_herencia.dart';
// import 'package:vesta_flutter/Utils.dart';
// import 'package:vesta_flutter/models/registro_victimas.dart';
// //import 'package:vesta_flutter/pages/Caracterizacion/entrevista_preguntas_grupo.dart';
// import 'package:vesta_flutter/pages/Caracterizacion/entrevista_preguntas_herencia.dart';
// import 'package:vesta_flutter/preferences.dart';

class EntrevistaMain extends StatelessWidget {
  //RegistroFuncionaroVictimas registroFuncionaroVictimas;
  String id;
  String names;
  String apellidos;

  EntrevistaMain(
      {required this.id, required this.names, required this.apellidos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {Navigator.pop(context);},
            icon: const Icon(color: Colors.white, Icons.arrow_back_ios_new)),
        centerTitle: true,
        title: const Text(
          "Entrevista",
          style: TextStyle(
              color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Entrevista de Caracterización",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Utils().getColorFromHex(Preferences.colorEntidad)),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "${id} - ${Utils.decodificarElemento(names)} ${Utils.decodificarElemento(apellidos.toString())} ",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: EntrevistaPreguntasGrupoHerencia(id, context),
            )
          ],
        ),
      ),
    );
  }
}

 
