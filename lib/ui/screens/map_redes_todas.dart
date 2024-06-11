import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infancia/domain/models/map_theme.dart';
import 'package:infancia/domain/models/redes_model.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/redes/bloc/maptodas_bloc/bloc/maptodas_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:vesta_flutter/Blocs/MapaTodas/maptodas_bloc.dart';
// import 'package:vesta_flutter/Utils.dart';
// import 'package:vesta_flutter/models/redes_model.dart';
// import 'package:vesta_flutter/preferences.dart';
// import 'package:vesta_flutter/themes/map_theme.dart';

class MapRedesTodas extends StatelessWidget {
  const MapRedesTodas({required this.redes, Key? key}) : super(key: key);

  final List<RedesApoyoModel> redes;

  @override
  Widget build(BuildContext context) {
    final MaptodasBloc denunciasmapaBloc = MaptodasBloc();

    denunciasmapaBloc.add(UbicarMarcadoresSedes(redes));

    final CameraPosition initialCamera = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(
            double.parse(redes[0].latitud), double.parse(redes[0].longitud)),
        tilt: 59.440717697143555,
        zoom: 13);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Text(
            "Ubicación de redes",
            style: const TextStyle(color: Colors.white),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
              );
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          backgroundColor: Utils().getColorFromHex(Preferences.colorEntidad),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: BlocProvider(
                create: (context) => denunciasmapaBloc,
                child: Column(children: [
                  Expanded(child: BlocBuilder<MaptodasBloc, MaptodasState>(
                    builder: (context, state) {
                      if (state is SedesMostrarMarcadores) {
                        return GoogleMap(
                          markers: state.marcadores,
                          zoomControlsEnabled: true,
                          zoomGesturesEnabled: true,
                          initialCameraPosition: initialCamera,
                          compassEnabled: false,
                          myLocationEnabled: true,
                          onMapCreated: (controller) =>
                              controller.setMapStyle(jsonEncode(mapTheme)),
                        );
                      } else {
                        return const Text("No se pudo ubicar");
                      }
                    },
                  ))
                ]))),
      ),
    );
  }
}
