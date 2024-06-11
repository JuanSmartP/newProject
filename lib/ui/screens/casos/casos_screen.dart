import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/models/entrevista_casos_model.dart';
import 'package:infancia/domain/network/entrevista_services.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/casos/bloc/casos_bloc.dart';
import 'package:infancia/ui/widgets/custom_loading.dart';


final 

class CasosScreen extends StatelessWidget {
  const CasosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final screenW = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      child: RepositoryProvider(
        create: (context) => NetworkEntrevista(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenH * 0.01),
              child: const Text(
                'CASOS',
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF505780),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenW * 0.03, vertical: screenH * 0.010),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'verificar');
                },
                child: const Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text(
                          'Agregar',
                          style: TextStyle(fontFamily: 'inter', fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const CustomBodyCasos(),
          ],
        ),
      ),
    );
  }
}

class CustomBodyCasos extends StatelessWidget {
  const CustomBodyCasos({super.key});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final screenW = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (context) => CasosBloc(
        RepositoryProvider.of<NetworkEntrevista>(context),
      )..add(LoadData()),
      child: BlocBuilder<CasosBloc, CasosState>(
        builder: (context, state) {
          if (state is CasosLoadindData) {
            return Center(child: CustomLoading( color: 0xFF6599fe, screenH: screenH));
          }
          if (state is CasosLoadedData) {
            List<Info> data = state.data;
            return Padding(
              padding: EdgeInsets.only(
                  left: screenW * 0.04,
                  right: screenW * 0.04,
                  bottom: screenH * 0.03),
              child: SizedBox(
                width: screenW * 1,
                height: screenH * 0.6,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final data1 = data[index];
                    const textStyle = TextStyle(
                        color: Color(0xFF505780),
                        fontFamily: 'inter',
                        fontWeight: FontWeight.bold);
                    const textStyle2 = TextStyle(
                      color: Color(0xFF004897),
                      fontFamily: 'inter',
                    );
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 15, bottom: 10),
                              child: Text(
                                data1.idEntrevista ?? '---',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF216FC6),
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 10, bottom: 5),
                            //   child: Text(
                            //     data1.apellidos ?? '---',
                            //     style: const TextStyle(
                            //         color: Color(0xFF216FC6),
                            //         fontFamily: 'inter',
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  const Text(
                                    'Nombre: ',
                                    style: textStyle,
                                  ),
                                  Text(
                                    data1.nombres ?? '---',
                                    style: textStyle2,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 15),
                              child: Row(
                                children: [
                                  const Text(
                                    'Identificacion: ',
                                    style: textStyle,
                                  ),
                                  Text(
                                    data1.idTercero ?? '---',
                                    style: textStyle2,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 15),
                              child: Row(
                                children: [
                                  const Text(
                                    'Fecha : ',
                                    style: textStyle,
                                  ),
                                  Text(
                                    Utils.fechaModficiada(
                                            data1.fechaEntrevista!)
                                        .split("_")[0],
                                    style: textStyle2,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  const Text(
                                    'Hora : ',
                                    style: textStyle,
                                  ),
                                  Text(
                                    Utils.fechaModficiada(
                                            data1.fechaEntrevista!)
                                        .split("_")[1],
                                    style: textStyle2,
                                  ),
                                ],
                              ),
                            ),

                            //TODO IMPLEMENTAR
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                     
                                      Navigator.pushNamed(
                                        context,
                                        'e_view',
                                        arguments: {
                                          'id_entrevista': data1.idEntrevista

                                        });
                                    },
                                    child: const Text('Ver entrevista'))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
