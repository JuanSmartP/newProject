import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infancia/domain/models/redes_model.dart';
import 'package:infancia/domain/repository/redes_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:vesta_flutter/models/redes_model.dart';
// import 'package:vesta_flutter/repositorry/redes_repository.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

part 'redes_event.dart';
part 'redes_state.dart';

class RedesBloc extends Bloc<RedesEvent, RedesState> {
  RedesRepository redesRepository;
  RedesBloc({required this.redesRepository}) : super(RedesInitial()) {
    on<getRedes>((event, emit) async {
      emit(RedesConsultando());

      bool result = await InternetConnectionChecker().hasConnection;

      if (result) {
        var position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best)
            .timeout(Duration(seconds: 20));

        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        //Obtengo lugar o municipio
        var municipio = placemarks[0].locality;

        Map<String, dynamic>? redesInfo =
            await redesRepository.getRedes(municipio.toString());

        if (redesInfo!["Status"] == "False") {
          //No hay alertas tempranas
          emit(RedesNohay());
          print("Emit ------> AmenazasNohay");
        } else {
          var amenazaData = redesInfo["info"] as List<dynamic>;

          List<RedesApoyoModel> redesList = [];
          for (int i = 0; i < amenazaData.length; i++) {
            var alertasTempranaData = RedesApoyoModel.fromJson(amenazaData[i]);
            redesList.add(alertasTempranaData);
          }
          emit(RedesData(redesList));
          print("Emit ------> TrataPersonasData");
        }
      } else {
        emit(SinConexionRedes());
      }
    });

    on<goWhatsapp>((event, emit) async {
      final link = WhatsAppUnilink(
        phoneNumber: '+57${event.number}',
        text: "Necesito atención",
      );

      await launch('$link');
    });
  }
}
