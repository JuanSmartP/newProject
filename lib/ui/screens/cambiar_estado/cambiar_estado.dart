import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/domain/network/denuncias.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/denuncias_repository.dart';
import 'package:infancia/ui/screens/cambiar_estado/bloc/cambiar_estado_bloc.dart';
import 'package:infancia/ui/screens/canal/blocs/canal_atencion_bloc/bloc/canal_atencion_bloc.dart';

String estadoEscogido = "";

class CambiarEstadoCaso extends StatelessWidget {
  const CambiarEstadoCaso({required this.consecutivo, super.key});

  final String consecutivo;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: GestureDetector(
                  child: const Icon(Icons.arrow_back_ios),
                  onTap: () => {
                    Navigator.pop(
                      context,
                    ),
                  },
                ),
                backgroundColor: const Color(0xff014898),
                title: const Text('Cambiar de estado'),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child:
                      Container() /*FormEstado(
                    consecutivo: consecutivo,
                    valueEstado: 1,
                    denunciasBloc: 
                    ,
                  )*/
                  ,
                ),
              ),
            )));
  }
}

class FormEstadoSolicitud extends StatefulWidget {
  const FormEstadoSolicitud(
      {required this.consecutivo,
      required this.valueEstado,
      required this.canalAtencionBloc,
      required this.regional,
      super.key});

  final String consecutivo;
  final int valueEstado;
  final CanalAtencionBloc canalAtencionBloc;
  final String regional;

  @override
  State<FormEstadoSolicitud> createState() => _FormEstadoSolicitudState();
}

class _FormEstadoSolicitudState extends State<FormEstadoSolicitud> {
  CambiarEstadoBloc cambiarBloc = CambiarEstadoBloc(
      denunciasRepository:
          DenunciasRepository(networkService: NetworkServiceDenuncias()));

  List<DropdownMenuItem<String>> dataEstado = [
    const DropdownMenuItem(
        value: "1",
        child: Row(
          children: [Text("Pendiente")],
        )),
    const DropdownMenuItem(
        value: "2",
        child: Row(
          children: [Text("En progreso")],
        )),
    const DropdownMenuItem(
        value: "3",
        child: Row(
          children: [Text("Resuelta")],
        )),
    const DropdownMenuItem(
        value: "4",
        child: Row(
          children: [Text("No contesta")],
        )),
    const DropdownMenuItem(
        value: "5",
        child: Row(
          children: [Text("Cerrada")],
        )),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                "Cambiar estado",
                style: TextStyle(
                    color: Color(0xff014898),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: DropdownButtonFormField(
                value: dataEstado[widget.valueEstado].value,
                decoration: editTextDecorationCombos("Estado", "", false),
                onChanged: (String? newValue) {
                  setState(() {
                    estadoEscogido = newValue!;
                  });
                },
                items: dataEstado),
          ),
          BlocProvider(
            create: (context) => cambiarBloc,
            child: BlocListener<CambiarEstadoBloc, CambiarEstadoState>(
              listener: (context, state) {
                if (state is EstadoCambiado) {
                  Utils.displayDialogCampos(context, "Cambiar estado",
                      "Estado cambiado correctamente");
                  widget.canalAtencionBloc.add(getCanalesMain(
                      regional: widget.regional,
                      fechaInicial: "",
                      fechaFinal: "",
                      rangoFecha: false));
                }
              },
              child: BlocBuilder<CambiarEstadoBloc, CambiarEstadoState>(
                builder: (context, state) {
                  return state is CambiandoEstado
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Utils()
                                .getColorFromHex(Preferences.colorEntidad),
                          ),
                        )
                      : CupertinoButton(
                          color: const Color(0xff014898),
                          child: const Text("Cambiar"),
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    elevation: 5,
                                    title: const Text("Cambiar estado"),
                                    content: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            "¿Seguro que desea cambiar el estado de esta solicitud?"),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancelar")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            cambiarBloc.add(
                                                cambiarEstadoSolicitud(
                                                    idCanal: widget.consecutivo,
                                                    estadoACambiar:
                                                        estadoEscogido
                                                            .toString()));
                                          },
                                          child: const Text("Cambiar")),
                                    ],
                                  );
                                });
                          });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration editTextDecorationCombos(
      String hint, String helperText, bool state) {
    return InputDecoration(
        helperText: helperText,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(
              width: 3,
              color: Utils().getColorFromHex(Preferences.colorEntidad)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(
              width: 2,
              color: Utils().getColorFromHex(Preferences.colorEntidad)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(
              width: 2,
              color: Utils().getColorFromHex(Preferences.colorEntidad)),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(
              width: 1,
            )),
        errorBorder: state
            ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                borderSide: BorderSide(width: 2, color: Colors.red))
            : null,
        focusedErrorBorder: state
            ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                borderSide: BorderSide(width: 2, color: Colors.red))
            : null,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
        errorText: state ? "Campo obligatorio" : null);
  }
}
