import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/models/entrevista_view_model.dart';
import 'package:infancia/domain/network/entrevista_view_network.dart';
import 'package:infancia/ui/screens/entrevista_view/bloc/entrevista_bloc_bloc.dart';
import 'package:infancia/ui/widgets/custom_loading.dart';

class EntrevistaView extends StatefulWidget {
  const EntrevistaView({super.key});

  @override
  State<EntrevistaView> createState() => _EntrevistaViewState();
}

class _EntrevistaViewState extends State<EntrevistaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Entrevista',
          style: TextStyle(
              fontSize: 35, fontFamily: 'poppins', color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
                color: Colors.white, Icons.arrow_back_ios_new_outlined)),
        backgroundColor: Colors.blue,
      ),
      body: RepositoryProvider(
          create: (context) => NetworkEntrevistaView(),
          child: const CustomBody()),
    );
  }
}

class CustomBody extends StatelessWidget {
  const CustomBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;

    final Map<String, dynamic> argumnets =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return BlocProvider(
      create: (context) => EntrevistaBlocBloc(argumnets['id_entrevista'],
          RepositoryProvider.of<NetworkEntrevistaView>(context))
        ..add(LoadData()),
      child: SizedBox(
        height: screenH * 0.9,
        child: BlocBuilder<EntrevistaBlocBloc, EntrevistaBlocState>(
          builder: (context, state) {
            if (state is LoadingData) {
              return Center(
                child: CustomLoading(
                   color: 0xFFffffff,
                  screenH: screenH,
                ),
              );
            }

            if (state is DataLoadeed) {
              return CustomCard(
                data: state.data,
              );
            }

            return const Center(
              child: Text('Algo salio mal'),
            );
          },
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final List<Informacion> data;
  const CustomCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // final consecutivo = argumnets['id_entrevista'];

    // print(consecutivo);
    final respuestas = data[0].respuestas;
    final data3 = data[0];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: ListView.builder(
        itemCount: respuestas!.length,
        itemBuilder: (context, index) {
          final data2 = respuestas[index];

          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Card(
                elevation: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              data2.pregunta ?? 'no',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 14, 57, 122)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        data2.respuesta ?? 'no',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// class _CustomSliverAppBar extends StatelessWidget {
  

//   _CustomSliverAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//               color: Colors.white, Icons.arrow_back_ios_new_outlined)),
//       expandedHeight: 150,
//       floating: false,
//       pinned: true,
//       flexibleSpace: FlexibleSpaceBar(
//         centerTitle: true,
//         title: Container(
//           color: Colors.blue,
//           alignment: Alignment.bottomCenter,
//           width: double.infinity,
//           padding: const EdgeInsets.only(),
//           child: const Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(9.0),
//                 child: Text(
//                   'Liliana Lozada Joven',
//                   style: TextStyle(fontFamily: 'poppins', color: Colors.white),
//                 ),
//               ),
//               Text(
//                 '41262173',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontFamily: 'poppins', color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//       backgroundColor: Colors.blue,
//     );
//   }
// }


//TODO: ARREGLAR LA ENTREVISTA