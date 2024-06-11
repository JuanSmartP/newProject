import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'dart:ui' as ui;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infancia/domain/models/redes_model.dart';
import 'package:infancia/domain/theme/utils.dart';
// import 'package:vesta_flutter/Utils.dart';
// import 'package:vesta_flutter/models/redes_model.dart';

part 'maptodas_event.dart';
part 'maptodas_state.dart';

class MaptodasBloc extends Bloc<MaptodasEvent, MaptodasState> {
  MaptodasBloc() : super(MaptodasInitial()) {
    on<OnMapInitializedEvent>((event, emit) async {
      //Adquiero mi localizacion
      var position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .timeout(Duration(seconds: 20));

      //googleMapController = event.controller;
      //googleMapController?.setMapStyle(jsonEncode(mapTheme));
      LatLng myLocation = LatLng(position.latitude, position.longitude);
      final cameraUpdate = CameraUpdate.newLatLng(myLocation);

      final Set<Marker> markersMap = await _getMarcadores(event.sedesMostrar);

      emit(SedesMostrarMarcadores(markersMap));
      print("SedesMostrarMarcadores");
    });

    on<UbicarMarcadoresSedes>((event, emit) async {
      final Set<Marker> markersMap = await _getMarcadores(event.sedesMostrar);

      emit(SedesMostrarMarcadores(markersMap));
      print("SedesMostrarMarcadores");
    });
  }
  Future<Set<Marker>> _getMarcadores(List<RedesApoyoModel> sedesMostrar) async {
    Map<String, Marker> markers = <String, Marker>{};

    //final markerImage = await getImageMarker();

    final Uint8List customMarker =
        await getBytesFromAsset('images/marcadorVesta.png', 50);

    for (int i = 0; i < sedesMostrar.length; i++) {
      double lat = double.parse(sedesMostrar[i].latitud);
      double long = double.parse(sedesMostrar[i].longitud);
      LatLng myLocation = LatLng(lat, long);
      final marker = Marker(
          icon: BitmapDescriptor.fromBytes(customMarker),
          position: myLocation,
          markerId: MarkerId("$i"),
          infoWindow: InfoWindow(
              title: "#${i + 1}",
              snippet: "${Utils.decodificarElemento(sedesMostrar[i].nombre)}"));
      markers["$i"] = marker;
    }
    return markers.values.toSet();
  }

  Future<BitmapDescriptor> getImageMarker() {
    return BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 5.5), 'images/marcador.png');
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
