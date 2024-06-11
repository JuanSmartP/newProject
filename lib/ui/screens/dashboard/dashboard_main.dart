import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infancia/ui/screens/dashboard/dashboard_casos_infancia.dart';
 
// import 'package:vesta_flutter/pages/MainMenu/Dashboard/dashboard_casos_infancia.dart';
// import 'package:vesta_flutter/pages/MainMenu/Dashboard/dashboard_casos_new.dart';
// import 'package:vesta_flutter/pages/MainMenu/Dashboard/dashboard_solicitudes.dart';
// import 'package:vesta_flutter/pages/MainMenu/Denuncias/dashboard_casos.dart';

/// Flutter code sample for [CupertinoSlidingSegmentedControl].

enum Sky { midnight, viridian, cerulean }

Map<Sky, Color> skyColors = <Sky, Color>{
  Sky.midnight: const Color(0xffB081E6),
  Sky.viridian: const Color(0xffB081E6),
};

/*
class DashBoardMain extends StatelessWidget {
  const DashBoardMain();

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: SegmentedControl(),
    );
 */

class DashBoardMain extends StatefulWidget {
  const DashBoardMain();

  @override
  State<DashBoardMain> createState() => _SegmentedControlExampleState();
}

class _SegmentedControlExampleState extends State<DashBoardMain> {
  Sky _selectedSegment = Sky.midnight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
            );

            /*
            valueYear = "2024";
            valueSegmento = "1";
            valueCodeSegemnto = "G";

            valueRegional = "";
            valueDepartamento = "";
            valueMunicipio = "";

            textoTotal = "";

            depa = false;
            mun = false;
            reg = false;

            //Bools de criterios
            violenciaLey = true;
            otrasManifestaciones = false;
            trataPersonas = false;
            presuntoAgresor = false;
            caracteri = false;

            //ValuesSubcriterios
            valueCriterio = "1";
            valueVariables = "55";
          
            //myControllerVictimaID.text = "";*/
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff6D62F7),
          ),
        ),
        // This Cupertino segmented control has the enum "Sky" as the type.
        middle: CupertinoSlidingSegmentedControl<Sky>(
          backgroundColor: CupertinoColors.systemPurple,
          thumbColor: skyColors[_selectedSegment]!,
          // This represents the currently selected segmented control.
          groupValue: _selectedSegment,
          // Callback that sets the selected segmented control.
          onValueChanged: (Sky? value) {
            if (value != null) {
              setState(() {
                _selectedSegment = value;
              });
            }
          },
          children: const <Sky, Widget>{
            Sky.midnight: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Casos',
                style: TextStyle(color: CupertinoColors.white),
              ),
            ),
            Sky.viridian: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '',
                style: TextStyle(color: CupertinoColors.systemPurple),
              ),
            ),
          },
        ),
      ),
      body: SafeArea(child: DashboardAppNewInfancia()),
      // body: SafeArea(
      //   child: _selectedSegment == Sky.midnight
      //       ? DashboardAppNewInfancia() //DashboardAppNew()
      //       : DashboardAppSolicitudes(),
      
    );
  }
}
