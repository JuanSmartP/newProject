import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infancia/domain/models/map_theme.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/redes/mpadenunciabloc/bloc/mapadenuncias_bloc.dart';
 
class MapRedes extends StatelessWidget {
  const MapRedes(
      {required this.latitudDenuncia,
      required this.logintudDenuncia,
      required this.denuncia,
      Key? key})
      : super(key: key);

  final latitudDenuncia;
  final logintudDenuncia;
  final String denuncia;

  @override
  Widget build(BuildContext context) {
    return MapSedesState(
      denuncia: denuncia,
      latitudDenuncia: latitudDenuncia,
      logintudDenuncia: logintudDenuncia,
    );
  }
}

class MapSedesState extends StatefulWidget {
  final latitudDenuncia;
  final logintudDenuncia;
  final String denuncia;
  MapSedesState(
      {Key? key,
      required this.denuncia,
      required this.latitudDenuncia,
      required this.logintudDenuncia})
      : super(key: key);

  @override
  State<MapSedesState> createState() =>
      _MapSedesStateState(denuncia, latitudDenuncia, logintudDenuncia);
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

class _MapSedesStateState extends State<MapSedesState> {
  final latitudDenuncia;
  final logintudDenuncia;
  final String denuncia;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  double distance = 0.0;

  @override
  void initState() {
    super.initState();
    //getDirections(); //fetch direction polylines from Google API
  }

  _MapSedesStateState(
      this.denuncia, this.latitudDenuncia, this.logintudDenuncia);

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .timeout(const Duration(seconds: 5));

    double lat = double.parse(latitudDenuncia);
    double long = double.parse(logintudDenuncia);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyC1NWaU84CTjxjiPIBxrEHeFINXNqbzres",
      PointLatLng(position.latitude, position.longitude),
      PointLatLng(lat, long),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    //polulineCoordinates is the List of longitute and latidtude.
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }
    print(totalDistance);

    setState(() {
      distance = totalDistance;
    });

    //add to the list of poly line coordinates
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Utils().getColorFromHex(Preferences.colorEntidad),
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final MapadenunciasBloc denunciasmapaBloc = MapadenunciasBloc();

    denunciasmapaBloc.add(UbicacionDenuncia(
        latitud: latitudDenuncia, longitud: logintudDenuncia));

    print("latitud ${latitudDenuncia} longitud ${logintudDenuncia}");
    final CameraPosition initialCamera = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(
            double.parse(latitudDenuncia), double.parse(logintudDenuncia)),
        tilt: 59.440717697143555,
        zoom: 13.5);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ubicación red",
            style: TextStyle(color: Colors.white),
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
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: BlocProvider(
          create: (context) => denunciasmapaBloc,
          child: Stack(
            children: [
              BlocBuilder<MapadenunciasBloc, MapadenunciasState>(
                builder: (context, state) {
                  if (state is MostrarMarcadorDenuncia) {
                    return GoogleMap(
                      polylines: Set<Polyline>.of(polylines.values),
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
              ),
              BlocBuilder<MapadenunciasBloc, MapadenunciasState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          heroTag: "route",
                          onPressed: () {
                            getDirections();
                          },
                          backgroundColor:
                              Utils().getColorFromHex(Preferences.colorEntidad),
                          child: const Icon(
                            Icons.route,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
