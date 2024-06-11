import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'mapadenuncias_event.dart';
part 'mapadenuncias_state.dart';

class MapadenunciasBloc extends Bloc<MapadenunciasEvent, MapadenunciasState> {
  MapadenunciasBloc() : super(MapadenunciasInitial()) {
    on<UbicacionDenuncia>((event, emit) async {
      final Set<Marker> markersMap = await _getMarcadore(
          double.parse(event.latitud), double.parse(event.longitud));
      emit(MostrarMarcadorDenuncia(markersMap));
    });

/*
    on<UbicacionSede>((event, emit) async {
      var position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .timeout(Duration(seconds: 20));

      PointLatLng origin = PointLatLng(position.latitude, position.longitude);
      PointLatLng destination =
          PointLatLng(event.latitud as double, event.longitud as double);

      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyC1NWaU84CTjxjiPIBxrEHeFINXNqbzres", origin, destination);

      emit(PolylineSede(result));
    });

    on<UbicarSedes>((event, emit) {});
  }*/
  }

  Future<Set<Marker>> _getMarcadore(double lat, double long) async {
    Map<String, Marker> markers = <String, Marker>{};

    final Uint8List customMarker =
        await getBytesFromAsset('assets/imgs/logonew.png', 100);


        
    LatLng myLocation = LatLng(lat, long);
    final marker = Marker(
        icon: BitmapDescriptor.fromBytes(customMarker),
        position: myLocation,
        markerId: MarkerId("Denuncia"));
    markers["Denuncia"] = marker;

    return markers.values.toSet();
  }

  //Metodo para reducir ek tamaño de la imagen y asignarle icono
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
