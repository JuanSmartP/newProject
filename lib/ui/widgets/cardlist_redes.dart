// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/models/redes_model.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/map_redes.dart';
import 'package:infancia/ui/screens/map_redes_todas.dart';
import 'package:infancia/ui/screens/redes/bloc/redes_bloc.dart';
import 'package:infancia/ui/widgets/search_widget.dart';

class CardListRedes extends StatefulWidget {
  List<RedesApoyoModel> hurtosData;

  CardListRedes(this.hurtosData);

  @override
  State<CardListRedes> createState() => _CardListRedesState();
}

class _CardListRedesState extends State<CardListRedes> {
  late List<RedesApoyoModel> tempRedesApoyo;
  String query = "";
  @override
  void initState() {
    super.initState();

    tempRedesApoyo = widget.hurtosData;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(
      children: [
        SearchWidget(
            text: query, onChanged: searchRedes, hintText: "Buscar redes"),
        Flexible(
            child: Stack(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: tempRedesApoyo.length,
              itemBuilder: (BuildContext context, int index) {
                return Redescard(
                  redInstitucional: tempRedesApoyo[index],
                  index: index,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        shape: const CircleBorder(),
                        heroTag: "add",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MapRedesTodas(redes: widget.hurtosData)),
                          );
                        },
                        backgroundColor: Utils().getColorFromHex("#6699FF"),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ))
      ],
    ));

    /*
        SearchWidget(
            text: query, onChanged: searchRedes, hintText: "Buscar redes"),*/
  }

  void searchRedes(String query) {
    final listFilterRedes = widget.hurtosData.where((red) {
      final title = red.nombre.toLowerCase();
      final search = query.toLowerCase();
      return title.contains(search);
    }).toList();

    setState(() {
      tempRedesApoyo = listFilterRedes;
      query = query;
    });
  }
}

//Card de Trata de personas
class Redescard extends StatelessWidget {
  final RedesApoyoModel redInstitucional;
  final int index;

  const Redescard(
      {super.key, required this.redInstitucional, required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
              ),
              elevation: 10.0,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ExpandablePanel(
                    //Cambiar o personalizar icono
                    theme: ExpandableThemeData(),
                    header: Text(
                      Utils.decodificarElemento(redInstitucional.nombre),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Utils()
                              .getColorFromHex(Preferences.colorEntidad)),
                    ),
                    collapsed: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapRedes(
                                    latitudDenuncia: redInstitucional.latitud,
                                    logintudDenuncia: redInstitucional.longitud,
                                    denuncia: "Redes",
                                  )),
                        );
                      },
                      child: Row(
                        children: [
                          // Image(
                          //     color: Utils()
                          //         .getColorFromHex(Preferences.colorEntidad),
                          //     image: const AssetImage('images/mapIcon.png'),
                          //     width: 20.0,
                          //     height: 18.0),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Ubicación",
                            style: TextStyle(
                              fontSize: 16,
                              color: Utils()
                                  .getColorFromHex(Preferences.colorEntidad),
                            ),
                          ),
                        ],
                      ),
                    ),
                    expanded: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Telefonos: ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: Text(
                                "${redInstitucional.telefono} - ${redInstitucional.celular}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Dirección: ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: Text(
                                Utils.decodificarElemento(
                                    redInstitucional.direccion),
                                style: const TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Correo: ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              redInstitucional.email,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Horarios: ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              redInstitucional.horarioAm +
                                  " AM a " +
                                  redInstitucional.horarioPM +
                                  " PM",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapRedes(
                                            latitudDenuncia:
                                                redInstitucional.latitud,
                                            logintudDenuncia:
                                                redInstitucional.longitud,
                                            denuncia: "Redes",
                                          )),
                                );
                              },
                              child: Row(
                                children: [
                                  // Image(
                                  //     color: Utils().getColorFromHex(
                                  //         Preferences.colorEntidad),
                                  //     image: const AssetImage(
                                  //         'images/mapIcon.png'),
                                  //     width: 20.0,
                                  //     height: 18.0),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Ubicación",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Utils().getColorFromHex(
                                          Preferences.colorEntidad),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            BlocBuilder<RedesBloc, RedesState>(
                              builder: (context, state) {
                                return InkWell(
                                  onTap: () {
                                    context.read<RedesBloc>().add(goWhatsapp(
                                        number: redInstitucional.celular));
                                  },
                                  child: Row(
                                    children: [
                                      // Image(
                                      //     color: Utils().getColorFromHex(
                                      //         Preferences.colorEntidad),
                                      //     image: const AssetImage(
                                      //         'images/whatsappIcon.png'),
                                      //     width: 20.0,
                                      //     height: 18.0),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "WhatsApp",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Utils().getColorFromHex(
                                              Preferences.colorEntidad),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ))),
        ));
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
