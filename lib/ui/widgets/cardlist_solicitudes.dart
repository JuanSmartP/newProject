import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:infancia/domain/models/blur_model.dart';
import 'package:infancia/domain/models/canales_model.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/cambiar_estado/cambiar_estado.dart';
import 'package:infancia/ui/screens/canal/blocs/canal_atencion_bloc/bloc/canal_atencion_bloc.dart';
import 'package:infancia/ui/screens/cardlist_registros_funcionario.dart';


class CardListSolicitudes extends StatelessWidget {
  final List<SolicituesModel> solicitudesData;
  final CanalAtencionBloc canalAtencionBloc;
  final List<BlurCampos> blurCampos;
  final String regional;

  const CardListSolicitudes(this.solicitudesData, this.canalAtencionBloc,
      this.regional, this.blurCampos);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
          
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: this.solicitudesData.length,
        itemBuilder: (BuildContext context, int index) {
          return SolicitudesCard(
            solicitud: this.solicitudesData[index],
            index: index,
            canalAtencionBloc: canalAtencionBloc,
            regional: regional,
            blurCampos: blurCampos,
          );
        },
      ),
    ));
  }
}

class SolicitudesCard extends StatelessWidget {
  final SolicituesModel solicitud;
  final int index;
  final CanalAtencionBloc canalAtencionBloc;
  final String regional;
  final List<BlurCampos> blurCampos;

  const SolicitudesCard(
      {required this.solicitud,
      required this.index,
      required this.canalAtencionBloc,
      required this.regional,
      required this.blurCampos});

  @override
  Widget build(BuildContext context) {
    var estado = "";
    var color;
    var valueEstado;

    switch (solicitud.estado) {
      case "Pendiente":
        estado = "Pendiente";
        valueEstado = 0;
        color = const Color(0xffF57977);
        break;
      case "En progreso":
        estado = "En progreso";
        valueEstado = 1;
        color = const Color(0xffB081E6);

        break;
      case "Resuelta":
        estado = "Resuelta";
        valueEstado = 2;
        color = const Color(0xff56E299);

        break;
      case "No contesta":
        estado = "No contesta";
        valueEstado = 3;
        color = Colors.grey;
        break;
      case "Cerrada":
        estado = "Cerrada";
        valueEstado = 4;
        color = Colors.grey;

        break;
      default:
    }

    return Padding(
          padding: const EdgeInsets.all(11),
          child: Card(
            color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.0),
      ),
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image(
                    color: Preferences.entidadUsuario == "8001860611"
                        ? Color(0xff014898)
                        : Color(0xffFF2B66),
                    image: AssetImage('images/iconCalendar.png'),
                    width: 18.0,
                    height: 18.0),
                SizedBox(
                  width: 5,
                ),
                Text(
                  Utils.fechaModficiada(solicitud.fechaRegistro)
                      .split("_")[0],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),*/
            Row(
              children: [
                Expanded(
                    child: Blur(
                  blur:
                      getBlurValue(blurCampos, "nombre_completo") ? 0 : 4.0,
                  child: Text(
                    solicitud.servidorPublico == "Si"
                        ? "${getName("${solicitud.entidad}")}"
                        : solicitud.particular == "Si"
                            ? "${getName("${solicitud.nombres}")}"
                            : "No registra",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Utils()
                            .getColorFromHex(Preferences.colorEntidad)),
                  ),
                )),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: new Text('Cambiar estado'),
                                  onTap: () {
                                    //Navigator.pop(context);
                                    /*
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CambiarEstadoCaso(
                                                consecutivo:
                                                    denuncia.consecutivo)),
                                  );*/
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Column(children: <Widget>[
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 20,
                                                          vertical: 15),
                                                  child: GestureDetector(
                                                    child: const Icon(Icons
                                                        .arrow_back_ios),
                                                    onTap: () => {
                                                      Navigator.pop(
                                                        context,
                                                      ),
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                            FormEstadoSolicitud(
                                              consecutivo:
                                                  solicitud.idCanal,
                                              valueEstado: valueEstado,
                                              canalAtencionBloc:
                                                  canalAtencionBloc,
                                              regional: regional,
                                            )
                                          ]);
                                        });
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: const Icon(
                    Icons.more_vert,
                    color: Color(0xff7A7A9D),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  "Lugar:",
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${solicitud.municipio}, ${solicitud.departamento}",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  "Fecha:",
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  Utils.fechaModficiada(solicitud.fechaRegistro)
                      .split("_")[0],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  "Hora:",
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  Utils.fechaModficiada(solicitud.fechaRegistro)
                      .split("_")[1],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  "Celular: ",
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Blur(
                      blur: getBlurValue(blurCampos, "celularS") ? 0 : 4.0,
                      child: Text(
                        solicitud.celular == null
                            ? 'No registra'
                            : solicitud.celular.isEmpty
                                ? "No registra"
                                : solicitud.celular,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      )),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Correo: ",
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Blur(
                      blur: getBlurValue(blurCampos, "celularS") ? 0 : 4.0,
                      child: Text(
                        solicitud.correo == null
                            ? 'No registra'
                            : solicitud.correo.isEmpty
                                ? "No registra"
                                : solicitud.correo!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            solicitud.servidorPublico == "Si"
                ? Row(
                    children: [
                      const Text(
                        "Cargo: ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          solicitud.cargo != null
                              ? solicitud.cargo!
                              : 'No registra',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Estado: ",
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    solicitud.estado,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: const Color(0xffE0E0E0),
              height: 2,
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    Utils.decodificarElemento(solicitud.descripcion),
                    //overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            /*
            Row(
              children: [
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DenunciaDetalles(
                                amenaza: denuncia,
                              )),
                    )
                  },
                  child: const Text(
                    'Ver detalles',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        color: Color(0xff736575),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),*/
            /*
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (!solicitud.lat.toString().contains("null")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapDenuncia(
                                  latitudDenuncia: solicitud.lat,
                                  logintudDenuncia: solicitud.long,
                                  denuncia: "Amenaza",
                                )),
                      );
                    } else {
                      Utils.displayDialogDenuncias(
                          context,
                          "Canal de atención",
                          "Ubicación no disponible",
                          null);
                    }
                  },
                  child: Row(
                    children: [
                      Image(
                          color: Preferences.entidadUsuario == "8001860611"
                              ? Color(0xff014898)
                              : Color(0xffFF2B66),
                          image: AssetImage('images/mapIcon.png'),
                          width: 20.0,
                          height: 18.0),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Ubicación",
                        style: TextStyle(
                          fontSize: 16,
                          color: Preferences.entidadUsuario == "8001860611"
                              ? Color(0xff014898)
                              : Color(0xffFF2B66),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                /*
                MaterialButton(
                    color: Preferences.entidadUsuario == "8001860611"
                        ? Color(0xff014898)
                        : Color(0xffFF2B66),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NovedadesPage(
                                  idDenuncia: denuncia.consecutivo,
                                )),
                      );
                    },
                    child: const Text(
                      "Novedades",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ))*/
              ],
            )*/
          ],
        ),
      )),
        );
  }
}

String getName(String? nombre) {
  if (nombre == "null" ||
      nombre == "" ||
      nombre == null ||
      nombre.contains("null")) {
    return "No registra";
  } else {
    return nombre;
  }
}
