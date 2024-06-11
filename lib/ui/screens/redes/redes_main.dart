import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/models/redes_model.dart';
import 'package:infancia/domain/network/app_version_services.dart';
import 'package:infancia/domain/network/redes_services.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/redes_repository.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/redes/bloc/redes_bloc.dart';
import 'package:infancia/ui/widgets/cardlist_redes.dart';
import 'package:infancia/ui/widgets/custom_loading.dart';

late List<RedesApoyoModel> redesDeApoyoAll;
late List<RedesApoyoModel> tempRedesApoyo;

String query = "";

class RedesMain extends StatefulWidget {
  @override
  State<RedesMain> createState() => _RedesMainState();
}

class _RedesMainState extends State<RedesMain> {
  List<RedesApoyoModel>? redesList;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;

    RedesRepository? redesRepository =
        RedesRepository(networkService: NetworkServiceRedes());

    // ContactoAsaBloc contactoAsaBloc = ContactoAsaBloc(
    //     repository: ContactoAsaRepository(networkService: NetworkAppVersion()));

    // contactoAsaBloc.add(getContactoNumber(regional: Preferences.regional));

    final RedesBloc redesBloc = RedesBloc(redesRepository: redesRepository);
    redesBloc.add(getRedes());

    /*
    @override
    void initState() {
      super.initState();

      tempRedesApoyo = widget.hurtosData;
    }
*/
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: MultiBlocProvider(
                providers: [
              BlocProvider(
                create: (BuildContext context) => redesBloc,
              ),
              // BlocProvider(
              //   create: (BuildContext context) => contactoAsaBloc,
              // ),
            ],
                child: Stack(
                  children: [
                    const Row(
                      children: [
                        // Image(
                        //   color: Color(0xffE0E0E0),
                        //   alignment: Alignment.topLeft,
                        //   image: AssetImage('images/lazoLogin.png'),
                        // ),
                      ],
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Image(
                            //   color: Color(0xffE0E0E0),
                            //   alignment: Alignment.bottomRight,
                            //   image: AssetImage('images/corazonLogin.png'),
                            // ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Redes de apoyo",
                              style: TextStyle(
                                  color: Utils().getColorFromHex(
                                      Preferences.colorEntidad),
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            // Container(
                            //   width: 50,
                            //   height: 50,
                            //   child: BlocBuilder<ContactoAsaBloc,
                            //       ContactoAsaState>(
                            //     builder: (context, state) {
                            //       return state is ContactoAsaData
                            //           ? FloatingActionButton(
                            //               shape: const CircleBorder(),
                            //               heroTag: "addVic",
                            //               onPressed: () async {
                            //                 final link = WhatsAppUnilink(
                            //                   phoneNumber: '+57${state.numero}',
                            //                   text: state.mensaje,
                            //                 );
                            //                 var url =
                            //                     Uri.parse(link.toString());
                            //                 await launchUrl(url);
                            //               },
                            //               backgroundColor: Utils()
                            //                   .getColorFromHex("#6699FF"),
                            //               child: const Icon(
                            //                 Icons.headphones,
                            //                 color: Colors.white,
                            //               ),
                            //             )
                            //           : Container();
                            //     },
                            //   ),
                            // ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        /*
                        SearchWidget(
                            text: query,
                            onChanged: searchRedes,
                            hintText: "Buscar redes"),*/
                        BlocBuilder<RedesBloc, RedesState>(
                          builder: (context, state) {
                            if (state is RedesConsultando) {
                              return Center(
                                  child: CustomLoading(
                                      color: 0xFF6599fe, screenH: screenH));
                            } else if (state is RedesData) {
                              return CardListRedes(state.redesData);
                            } else {
                              if (state is RedesNohay) {
                                return Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .55,
                                      child: const Center(
                                        child: Text(
                                            "No se encontraron redes cercanas"),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                if (state is SinConexionRedes) {
                                  return Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                          color: Colors.white,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .55,
                                          child: const Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Fallo de conexión"),
                                                // Image(
                                                //   image: AssetImage(
                                                //       'images/network-signal.png'),
                                                //   width: 30.0,
                                                //   height: 30.0,
                                                // ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
