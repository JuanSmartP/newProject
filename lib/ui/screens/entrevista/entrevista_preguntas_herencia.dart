import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infancia/domain/models/opcion_model.dart';
import 'package:infancia/domain/models/preguntas_grupos.dart';
import 'package:infancia/domain/models/preguntas_herencia.dart';
import 'package:infancia/domain/models/preguntas_model.dart';
import 'package:infancia/domain/models/preguntas_opciones_model.dart';
import 'package:infancia/domain/models/respuesta_entrevista_model.dart';
import 'package:infancia/domain/models/visibilidad_preguntas.dart';
import 'package:infancia/domain/network/entrevista_service.dart';
import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/domain/repository/entrevista_repository.dart';
import 'package:infancia/domain/theme/utils.dart';
import 'package:infancia/ui/screens/bloc/visible_bloc.dart';
import 'package:infancia/ui/screens/entrevista/bloc/preguntas_entrevista_bloc.dart';

List<RespuestaEntrevista> respuestaPreguntas = [];
List<VisibilidadPreguntas> visibilidadPreguntas = [];
List<Herencia> herenciaPreguntas = [];

List<GrupoPreguntas> gruposList = [];

VisibleBloc visibleBloc = VisibleBloc();

//late PreguntasEntrevistaBloc preguntasBloc;

var boolInterSexual = false;

int conteoGrupos = 0;

String idEntrevista = "";

class EntrevistaPreguntasGrupoHerencia extends StatefulWidget {
  EntrevistaPreguntasGrupoHerencia(this.idTercero, this.contextMainEntrevista,
      {Key? key})
      : super(key: key);

  String idTercero;
  BuildContext contextMainEntrevista;

  @override
  State<EntrevistaPreguntasGrupoHerencia> createState() =>
      _EntrevistaPreguntasGrupoState();
}

class _EntrevistaPreguntasGrupoState
    extends State<EntrevistaPreguntasGrupoHerencia> {
  PreguntasEntrevistaBloc preguntasBloc = PreguntasEntrevistaBloc(
      repository:
          EntrevistaRepository(networkService: NetworkServiceEntrevistas()));

  @override
  void initState() {
    super.initState();
    preguntasBloc
        .add(getPreguntas(grupoPregunta: "", conteoGrupos: conteoGrupos));
  }

  @override
  Widget build(BuildContext context) {
    BuildContext contextMain = context;

    idEntrevista = DateTime.now().millisecondsSinceEpoch.toString();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => preguntasBloc,
        ),
        BlocProvider(
          create: (context) => visibleBloc,
        ),
      ],
      child: BlocListener<PreguntasEntrevistaBloc, PreguntasEntrevistaState>(
          listener: (context, state) {
            if (state is EntrevistaGuardada) {
              //Llamo el dialogo

              conteoGrupos = 0;
              respuestaPreguntas.clear();
              idEntrevista = "";

              Utils.displayDialogDenuncias(
                  context,
                  "Entrevista",
                  "Entrevista guardada correctamente",
                  widget.contextMainEntrevista);
            }
          },
          child: BlocBuilder<PreguntasEntrevistaBloc, PreguntasEntrevistaState>(
              bloc: preguntasBloc,
              builder: (context, state) {
                if (state is PreguntasConsultando) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Utils().getColorFromHex(Preferences.colorEntidad),
                    ),
                  );
                } else if (state is PreguntasData) {
                  var listaPreguntas = getListaPreguntas(state.preguntasData);

                  //Los grupos
                  gruposList = state.gruposData;

                  return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: getPreguntasTodas(
                            context,
                            widget.idTercero,
                            listaPreguntas,
                            state.preguntasData,
                            preguntasBloc,
                            gruposList,
                            state.herenciaData),
                      ));

                  //FormPreguntas(listaPreguntas, state.preguntasData);
                } else {
                  if (state is GuardandoPreguntas) {
                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          CircularProgressIndicator(
                            color: Utils()
                                .getColorFromHex(Preferences.colorEntidad),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Guardando preguntas...",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Utils()
                                    .getColorFromHex(Preferences.colorEntidad)),
                          )
                        ]));
                  } else {
                    return Container();
                  }
                }
              })),
    );
  }
}

//Obtengo las preguntas

class TextGrupo extends StatefulWidget {
  TextGrupo({Key? key}) : super(key: key);

  @override
  State<TextGrupo> createState() => _TextGrupoState();
}

class _TextGrupoState extends State<TextGrupo> {
  @override
  Widget build(BuildContext context) {
    var texto = "";

    setState(() {
      texto = Utils.decodificarElemento(gruposList[conteoGrupos].nombreGrupo);
    });

    return Text(
      texto,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Utils().getColorFromHex(Preferences.colorEntidad)),
    );
  }
}

Column getPreguntasTodas(
    BuildContext context,
    String idTercero,
    List<Preguntas> preguntasList,
    List<PreguntasOpciones> preguntasData,
    PreguntasEntrevistaBloc preguntasBloc,
    List<GrupoPreguntas> gruposList,
    List<Herencia> herenciaData) {
  List<Widget> childrenPreguntas = <Widget>[];

  var textGrupo = TextGrupo();

  childrenPreguntas.add(textGrupo);

  //Recorro las preguntas
  for (int i = 0; i < preguntasList.length; i++) {
    visibilidadPreguntas.add(VisibilidadPreguntas(
        idPregunta: preguntasList[i].idPregunta,
        isVisible: preguntasList[i].heredaPregunta == "False" ? true : false));

    /*
    var card = Text(
      Utils.decodificarElemento(preguntasList[i].pregunta),
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    );*/

    //Agrego lo siguiente segun tipo de pregunta
    switch (preguntasList[i].idTipoPregunta) {
      //Unica
      case 'U':
        var preguntaUnicaPreguntaUnica = PreguntaUnica(preguntasList[i],
            preguntasData, herenciaData, preguntasBloc, gruposList);
        childrenPreguntas.add(preguntaUnicaPreguntaUnica);
        break;

      //Mulitple
      case 'M':
        List<Opcion> listaOpciones =
            getOpcionesPregunta(preguntasList[i], preguntasData);

        var preguntaMultiple =
            PreguntaMultiple(preguntasList[i], listaOpciones);
        childrenPreguntas.add(preguntaMultiple);
        break;

      //Rellenar
      case 'R':
        var preguntaUnicaRellenar =
            PreguntaTexto(preguntasList[i], preguntasData);
        childrenPreguntas.add(preguntaUnicaRellenar);
        break;

      //Seleccionar
      case 'S':
        var preguntaSeleccionar = PreguntaSeleccionar(preguntasList[i],
            preguntasData, preguntasBloc, gruposList, herenciaData);
        childrenPreguntas.add(preguntaSeleccionar);
        break;

      //Dicotomica
      case 'DS':
        var preguntaUnicaDicotomica = PreguntaUnica(preguntasList[i],
            preguntasData, herenciaData, preguntasBloc, gruposList);
        childrenPreguntas.add(preguntaUnicaDicotomica);
        break;
    }
  }

  childrenPreguntas.add(const SizedBox(
    height: 10,
  ));

  //Añado el boton de siguiente pregunta
  childrenPreguntas.add(Center(
      child: CupertinoButton(
          color:Colors.blue,
          child: Text(
            conteoGrupos == gruposList.length ? 'Finalizar' : 'Finalizar',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          onPressed: () {
            //AHORA SIGUE GUARDAR LAS PREGUNTAS Y VERIFICAR QUE SE GUARDEN BIEN
            conteoGrupos++;

            if (conteoGrupos != gruposList.length) {
              var preg = verificarPreguntas(preguntasList);

              

              if (!preg) {
                preguntasBloc.add(getPreguntas(
                    grupoPregunta: gruposList[conteoGrupos].idGrupo,
                    conteoGrupos: conteoGrupos));

                print('=====> IF 2');
              } else {
                conteoGrupos--;

                Utils.displayDialogDenuncias(context, "Entrevista",
                    "Faltan preguntas por contestar", null);

                print('=====> ');
              }
            } else {
              //Guardo las respuestas
              print("Ultimo");

              //Verifico que las respuestas guardadas, esten visibles.
              for (var item in preguntasData) {
                //Remuevo las respuestas que no estan visibles
                respuestaPreguntas.removeWhere((element) =>
                    element.idPregunta == item.idPregunta &&
                    item.heredaPregunta == "True");
              }

              preguntasBloc.add(savePreguntas(
                  idEntrevista: idEntrevista,
                  idTercero: idTercero,
                  respuestaPreguntas: respuestaPreguntas));

                  
            }
          })
      /*
    OutlinedButton(
      onPressed: () {
        conteoGrupos++;

        if (conteoGrupos != gruposList.length) {
          var preg = verificarPreguntas(preguntasList);

          if (!preg) {
            preguntasBloc.add(getPreguntas(
                grupoPregunta: gruposList[conteoGrupos].idGrupo,
                conteoGrupos: conteoGrupos));
          } else {
            conteoGrupos--;

            Utils.displayDialogDenuncias(
                context, "Entrevista", "Faltan preguntas por contestar", null);
          }
        } else {
          //Veo que hago una vez acabe
          //Guardo las respuestas
          print("Ultimo");

          preguntasBloc.add(savePreguntas(
              idEntrevista: idEntrevista,
              idTercero: idTercero,
              respuestaPreguntas: respuestaPreguntas));
        }
        TODO: Revisar este evento

/*
        switch (idGrupoPregunta) {
          case "1":
            //Info general, voy a Datos Basicos
            preguntasBloc.add(getPreguntas(grupoPregunta: "2"));
            idGrupoPregunta = "2";

            break;
          case "2":
            preguntasBloc.add(savePreguntas(
                idEntrevista: idEntrevista,
                idTercero: idTercero,
                respuestaPreguntas: respuestaPreguntas));
            //Datos basicos, voy a Vivienda
            /*
            preguntasBloc.add(getPreguntas(grupoPregunta: "3"));
            idGrupoPregunta = "3";*/
            break;
          case "3":
            //Datos basicos, voy a Retornos
            preguntasBloc.add(getPreguntas(grupoPregunta: "6"));
            idGrupoPregunta = "6";

            break;
          case "6":
            //Retornos, voy a participacion
            preguntasBloc.add(getPreguntas(grupoPregunta: "7"));
            idGrupoPregunta = "7";
            break;

          case "7":
            //Participacion, voy a educacion
            preguntasBloc.add(getPreguntas(grupoPregunta: "8"));
            idGrupoPregunta = "8";
            break;
          case "8":
            //Eduacion, voy a Salud
            preguntasBloc.add(getPreguntas(grupoPregunta: "9"));
            idGrupoPregunta = "9";
            break;
          case "9":
            //Salud, voy a Rehabilitacio
            preguntasBloc.add(getPreguntas(grupoPregunta: "10"));
            idGrupoPregunta = "10";
            break;
          case "10":
            //Rehabilitacio, voy a Alimentacion
            preguntasBloc.add(getPreguntas(grupoPregunta: "11"));
            idGrupoPregunta = "11";
            break;
          case "11":
            //Alimentacion, voy a Trabajo
            preguntasBloc.add(getPreguntas(grupoPregunta: "13"));
            idGrupoPregunta = "13";
            break;
          case "13":
            //Trabajo, voy a Laboral
            preguntasBloc.add(getPreguntas(grupoPregunta: "31"));
            idGrupoPregunta = "31";
            break;
          case "31":
            //Laboral, voy a Fuerza Publica
            preguntasBloc.add(getPreguntas(grupoPregunta: "32"));
            idGrupoPregunta = "32";
            break;
          case "32":
            //Fuerza Publica, voy a Info Adicional
            preguntasBloc.add(getPreguntas(grupoPregunta: "34"));
            idGrupoPregunta = "34";
            break;
          case "34":
            //Info adificonal, voy a Territorio
            preguntasBloc.add(getPreguntas(grupoPregunta: "33"));
            idGrupoPregunta = "33";
            break;

          case "33":
            //Veo que hago una vez acabe
            //Guardo las respuestas
            preguntasBloc.add(savePreguntas(
                idEntrevista: idEntrevista,
                idTercero: idTercero,
                respuestaPreguntas: respuestaPreguntas));

            break;
          default:
        }*/
      },
      child: Text(
        conteoGrupos == gruposList.length ? 'Finalizar' : 'Siguiente',
        style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: "Pluto",
            fontWeight: FontWeight.bold),
      ),
      style: OutlinedButton.styleFrom(
          primary: Preferences.entidadUsuario == "8001860611"
              ? Color(0xff014898)
              : Color(0xffFF2B66),
          backgroundColor: Preferences.entidadUsuario == "8001860611"
              ? Color(0xff014898)
              : Color(0xffFF2B66),
          side: BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          minimumSize: Size(170, 40)),
    ),
  */
      ));

  childrenPreguntas.add(const SizedBox(
    height: 20,
  ));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: childrenPreguntas,
  );
}

bool verificarPreguntas(List<Preguntas> preguntasList) {
  bool containReturn = false;
  for (var preg in preguntasList) {
    var contain = respuestaPreguntas
        .any((element) => element.idPregunta == preg.idPregunta);

    if (!contain) {
      containReturn = true;
    }
  }

  return containReturn;
}

//Obtengo las preguntas
List<Preguntas> getListaPreguntas(List<PreguntasOpciones> preguntasData) {
  List<Preguntas> preguntasList = [];

  for (int i = 0; i < preguntasData.length; i++) {
    var preguntaDataValue = preguntasData[i];
    if (!containsPregunta(preguntaDataValue, preguntasList)) {
      Preguntas pregunta = Preguntas(
          preguntaDataValue.idPregunta,
          preguntaDataValue.idGrupoPregunta,
          preguntaDataValue.idTipoPregunta,
          preguntaDataValue.pregunta,
          preguntaDataValue.descripcionPregunta,
          preguntaDataValue.heredaPregunta);

      preguntasList.add(pregunta);
    }
  }

  return preguntasList;
}

//Pregunto si esta pregunta ya existe en la lista
bool containsPregunta(
    PreguntasOpciones preguntasData, List<Preguntas> preguntasList) {
  for (int i = 0; i < preguntasList.length; i++) {
    if (preguntasData.idPregunta == preguntasList[i].idPregunta) {
      return true;
    }
  }
  return false;
}

//PRGUNTAS DE SELECCION UNICA O DICOTOMOCA
class PreguntaUnica extends StatefulWidget {
  PreguntaUnica(this.pregunta, this.preguntasData, this.herenciaData,
      this.preguntasBloc, this.gruposList,
      {Key? key})
      : super(key: key);

  List<PreguntasOpciones> preguntasData;
  List<Herencia> herenciaData;
  PreguntasEntrevistaBloc preguntasBloc;
  List<GrupoPreguntas> gruposList;

  Preguntas pregunta;

  @override
  State<PreguntaUnica> createState() => _PreguntaUnicaState();
}

class _PreguntaUnicaState extends State<PreguntaUnica> {
  var seleectedOpcion;

  setSelectedOpcion(String opcion) {
    setState(() {
      seleectedOpcion = opcion;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenOpciones = <Widget>[];

    //VisibleBloc visibleBloc = VisibleBloc();

    visibleBloc.add(setVisibility(
      isvisible: visibilidadPreguntas
          .firstWhere(
              (element) => element.idPregunta == widget.pregunta.idPregunta)
          .isVisible,
    ));

    childrenOpciones.add(Text(
        '${widget.pregunta.idPregunta}. ${Utils.decodificarElemento(widget.pregunta.pregunta)}',
        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)));

    if (widget.pregunta.descripcionPregunta != null) {
      childrenOpciones.add(Text(
          '${Utils.decodificarElemento(widget.pregunta.descripcionPregunta!)}',
          style: const TextStyle(fontSize: 12.0)));
    }

    List<Opcion> listaOpciones =
        getOpcionesPregunta(widget.pregunta, widget.preguntasData);

    for (Opcion opcion in listaOpciones) {
      //Adquiero las opciones
      var radioOopcion = Visibility(
          visible: opcion.visibilidadOpcion,
          child: RadioListTile<String>(
              title: Text(
                  '${Utils.decodificarElemento(opcion.descripcionOpcion)}',
                  style: const TextStyle(
                      fontSize: 12.0, fontWeight: FontWeight.bold)),
              value: opcion.opcionIdPregunta,
              groupValue: seleectedOpcion,
              onChanged: (currentOpcion) async {
                print("Current opc ${opcion.descripcionOpcion}");
                setSelectedOpcion(currentOpcion!);
                //Guardo la respuesta
                var respuestaUnica = RespuestaEntrevista(
                    idPregunta: opcion.idPregunta,
                    idOpcion: opcion.idOpcion,
                    idEntrevista: idEntrevista,
                    idTipoPregunta: widget.pregunta.idTipoPregunta,
                    idTextoRespuesta: "",
                    idGrupoPregunta: widget.pregunta.idGrupoPregunta);

                if (verificarPregunta(respuestaUnica)) {
                  //No tiene tiene la respuesta
                  respuestaPreguntas.removeWhere((element) =>
                      element.idPregunta == respuestaUnica.idPregunta);
                  respuestaPreguntas.add(respuestaUnica);
                } else {
                  respuestaPreguntas.add(respuestaUnica);
                }

                var idPRegunta = "";
                var valueTipoRespuesta =
                    "${opcion.opcionIdPregunta}_${opcion.hereda}_${opcion.heredaPregunta}_${opcion.heredaOpcionRespuesta}";

                //Recargar las preguntas
                idPRegunta = valueTipoRespuesta.toString().split("_")[3];
                widget.preguntasBloc.add(mostrarPreguntas(
                    idPregunta: idPRegunta,
                    preguntasData: widget.preguntasData,
                    gruposData: widget.gruposList,
                    herenciaData: widget.herenciaData,
                    respuesta: valueTipoRespuesta,
                    herenciaOpcionRespuesta: opcion.heredaOpcionRespuesta));

                //Verifico si la opcion tiene herencia

                /*
            if (opcion.hereda == "True") {
              EntrevistaRepository repository = EntrevistaRepository(
                  networkService: NetworkServiceEntrevistas());
              Map<String, dynamic>? preguntasInfo =
                  await repository.getHerenciaOpcion(opcion.idPregunta,
                      widget.pregunta.idTipoPregunta, opcion.idOpcion);
              // var preguntasData = preguntasInfo!["info"] as List<dynamic>;
              var preguntasData = preguntasInfo!["info"] as List<dynamic>;

              for (int i = 0; i < preguntasData.length; i++) {
                var preguntaData = Herencia.fromJson(preguntasData[i]);
                herenciaPreguntas.add(preguntaData);
              }

              for (Herencia herencia in herenciaPreguntas) {
                var idPregunta = herencia.idPreguntaHerencia!;
                var b = getVisibility(idPregunta);
              }

              //preguntasBloc.add(getPreguntas(grupoPregunta: "001"));

              visibleBloc.add(setVisibility(isvisible: false));
            } else {
              for (int i = 0; i < herenciaPreguntas.length; i++) {
                var herencia = herenciaPreguntas[i];
                if (herencia.idPreguntaOpcion == opcion.idPregunta) {
                  herenciaPreguntas.removeAt(i);
                  /*
                  herenciaPreguntas.removeWhere((element) =>
                      element.idPreguntaOpcion == opcion.idPregunta);*/
                  var b = getVisibility(herencia.idPreguntaHerencia!);
                }
              }
              visibleBloc.add(setVisibility(isvisible: true));
            }*/
              }));

      childrenOpciones.add(radioOopcion);
    }

    return Visibility(
        visible: widget.pregunta.heredaPregunta == "False" ? true : false,

        /*visibilidadPreguntas
            .firstWhere(
                (element) => element.idPregunta == widget.pregunta.idPregunta)
            .isVisible,*/
        child: Card(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10.0,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: childrenOpciones,
                ))));

    //USAR clase Visibility para decir si es visible o no la tarjeta

    /*
    return BlocBuilder<VisibleBloc, VisibleState>(
      builder: (context, state) {
        return state is Visible
            ? Visibility(
                visible: visibilidadPreguntas
                    .firstWhere((element) =>
                        element.idPregunta == widget.pregunta.idPregunta)
                    .isVisible,
                child: Card(
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10.0,
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: childrenOpciones,
                        ))))
            : Visibility(
                visible: visibilidadPreguntas
                    .firstWhere((element) =>
                        element.idPregunta == widget.pregunta.idPregunta)
                    .isVisible,
                child: Card(
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10.0,
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: childrenOpciones,
                        ))));
      },
    );*/
  }

  bool getVisibility(String idPregunta) {
    setState(() {
      if (visibilidadPreguntas
              .firstWhere((element) => element.idPregunta == idPregunta)
              .isVisible ==
          true) {
        visibilidadPreguntas
            .firstWhere((element) => element.idPregunta == idPregunta)
            .isVisible = false;
      } else {
        visibilidadPreguntas
            .firstWhere((element) => element.idPregunta == idPregunta)
            .isVisible = true;
      }
    });

    return true;
  }
}

bool verificarPregunta(RespuestaEntrevista respuestaUnica) {
  if (respuestaPreguntas.contains(respuestaUnica)) {
    return true;
  } else {
    return false;
  }
}

List<Opcion> getOpcionesPregunta(
    Preguntas pregunta, List<PreguntasOpciones> preguntasData) {
  List<Opcion> opciones = [];
  for (int i = 0; i < preguntasData.length; i++) {
    if (preguntasData[i].idPregunta == pregunta.idPregunta &&
        !opciones
            .any((element) => element.idOpcion == preguntasData[i].idOpcion)) {
      Opcion opcionNew = Opcion(
          opcionIdPregunta:
              '${pregunta.idPregunta}_${preguntasData[i].idOpcion}',
          descripcionOpcion: preguntasData[i].descripcionOpcion!,
          idPregunta: pregunta.idPregunta,
          idOpcion: preguntasData[i].idOpcion!,
          hereda: preguntasData[i].heredaOpcion!,
          heredaPregunta: preguntasData[i].heredaPreguntaOpcion!,
          heredaOpcionRespuesta: preguntasData[i].heredaOpcionRespuesta,
          selecionado: false,
          visibilidadOpcion: preguntasData[i].visibilidadOpcion);
      opciones.add(opcionNew);
    }
  }
  return opciones;
}

//PREGUNTAS SELECCION MULTIPLE

class PreguntaMultiple extends StatefulWidget {
  PreguntaMultiple(this.pregunta, this.listaOpciones, {Key? key})
      : super(key: key);

  List<Opcion> listaOpciones;
  Preguntas pregunta;

  @override
  State<PreguntaMultiple> createState() => _PreguntaMultipleState();
}

class _PreguntaMultipleState extends State<PreguntaMultiple> {
  List<Map> categories = [
    {"name": "Swimming", "isChecked": false},
    {"name": "Cycling", "isChecked": false},
    {"name": "Tennis", "isChecked": false},
    {"name": "Boxing", "isChecked": false},
    {"name": "Volleyball ", "isChecked": false},
    {"name": "Bowling ", "isChecked": false},
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> childrenOpciones = <Widget>[];

    childrenOpciones.add(Text(
        '${widget.pregunta.idPregunta}. ${Utils.decodificarElemento(widget.pregunta.pregunta)}',
        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)));

    if (widget.pregunta.descripcionPregunta != null) {
      childrenOpciones.add(Text(
          '${Utils.decodificarElemento(widget.pregunta.descripcionPregunta!)}',
          style: const TextStyle(fontSize: 12.0)));
    }

/*
    for (Map cat in categories) {
      //Adquiero las opciones
      var multiOopcion = CheckboxListTile(
        title: Text('${cat["name"]}',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
        value: cat["isChecked"],
        onChanged: (val) {
          setState(() {
            print('${cat["name"]}');
            cat["isChecked"] = val;

            //setSelectedOpcion(currentOpcion!);
          });
        },
      );

      childrenOpciones.add(multiOopcion);
    }*/

    for (Opcion opcion in widget.listaOpciones) {
      //Adquiero las opciones
      var multiOopcion = CheckboxListTile(
        title: Text('${Utils.decodificarElemento(opcion.descripcionOpcion)}',
            style:
                const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
        value: opcion.selecionado,
        onChanged: (val) {
          setState(() {
            print(
                "Current opcion ${opcion.descripcionOpcion}, ${opcion.selecionado}");
            opcion.selecionado = val!;

            var respuestaUnica = RespuestaEntrevista(
                idPregunta: widget.pregunta.idPregunta,
                idOpcion: opcion.idOpcion,
                idEntrevista: idEntrevista,
                idTipoPregunta: "M",
                idTextoRespuesta: "",
                idGrupoPregunta: widget.pregunta.idGrupoPregunta);

            if (verificarPregunta(respuestaUnica)) {
              //No tiene tiene la respuesta

              respuestaPreguntas.removeWhere((element) =>
                  element.idPregunta == respuestaUnica.idPregunta &&
                  element.idOpcion == respuestaUnica.idOpcion);
              if (opcion.selecionado) {
                respuestaPreguntas.add(respuestaUnica);
              }
            } else {
              respuestaPreguntas.add(respuestaUnica);
            }
            //setSelectedOpcion(currentOpcion!);
          });
        },
      );

      childrenOpciones.add(multiOopcion);
    }

    //USAR clase Visibility para decir si es visible o no la tarjeta

    return Card(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10.0,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: childrenOpciones,
            )));
  }
}

//PREGUNTAS DE TIPO TEXTO
class PreguntaTexto extends StatefulWidget {
  PreguntaTexto(this.pregunta, this.preguntasData, {Key? key})
      : super(key: key);

  List<PreguntasOpciones> preguntasData;
  Preguntas pregunta;

  @override
  State<PreguntaTexto> createState() => _PreguntaTextoState();
}

class _PreguntaTextoState extends State<PreguntaTexto> {
  @override
  Widget build(BuildContext context) {
    List<Widget> childrenTexto = <Widget>[];

    childrenTexto.add(Text(
        '${widget.pregunta.idPregunta}. ${Utils.decodificarElemento(widget.pregunta.pregunta)}',
        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)));

    if (widget.pregunta.descripcionPregunta != null) {
      childrenTexto.add(Text(
          '${Utils.decodificarElemento(widget.pregunta.descripcionPregunta!)}',
          style: const TextStyle(fontSize: 12.0)));

      childrenTexto.add(const SizedBox(height: 10));
    }

    var textorespuesta = TextField(
      keyboardType: TextInputType.text,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[A-Z\s]+')),
      ],
      maxLines: 5,
      textAlign: TextAlign.left,
      decoration: editTextDecoration("SOLO MAYÚSCULAS", "", false),
      onChanged: (text) {
        //myControllerDescripcion.text = value;
        print(text);
        var respuestaTexto = RespuestaEntrevista(
            idPregunta: widget.pregunta.idPregunta,
            idOpcion: null,
            idEntrevista: idEntrevista,
            idTipoPregunta: "R",
            idTextoRespuesta: text,
            idGrupoPregunta: widget.pregunta.idGrupoPregunta);

        if (verificarPregunta(respuestaTexto)) {
          respuestaPreguntas.removeWhere(
              (element) => element.idPregunta == respuestaTexto.idPregunta);
          respuestaPreguntas.add(respuestaTexto);
        } else {
          respuestaPreguntas.add(respuestaTexto);
        }
      },
    );

    childrenTexto.add(textorespuesta);

    //Con Visibility podre manejar la herencia
    return Visibility(
        visible: true,
        child: Card(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10.0,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: childrenTexto,
                  ),
                ))));
  }

  InputDecoration editTextDecoration(
      String hint, String helperText, bool state) {
    return InputDecoration(
        helperText: helperText,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 3,
              color: Utils().getColorFromHex(Preferences.colorEntidad)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 2, color: Color(0xffB6B1B7)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 2, color: Color(0xffB6B1B7)),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 1,
            )),
        errorBorder: state
            ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 2, color: Colors.red))
            : null,
        focusedErrorBorder: state
            ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 2, color: Colors.red))
            : null,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
        errorText: state ? "Campo obligatorio" : null);
  }
}

//PREGUNTAS DE TIPO SELECCIONAR
class PreguntaSeleccionar extends StatefulWidget {
  PreguntaSeleccionar(this.pregunta, this.preguntasData, this.preguntasBloc,
      this.gruposList, this.herenciaData);
  PreguntasEntrevistaBloc preguntasBloc;
  List<GrupoPreguntas> gruposList;
  List<PreguntasOpciones> preguntasData;
  List<Herencia> herenciaData;

  Preguntas pregunta;
  @override
  State<PreguntaSeleccionar> createState() => _PreguntaSeleccionarState();
}

class _PreguntaSeleccionarState extends State<PreguntaSeleccionar> {
  var valueTipo;

  @override
  Widget build(BuildContext context) {
    List<Widget> chilrenSeleccionar = <Widget>[];

    visibleBloc.add(setVisibility(
      isvisible: visibilidadPreguntas
          .firstWhere(
              (element) => element.idPregunta == widget.pregunta.idPregunta)
          .isVisible,
    ));

    chilrenSeleccionar.add(Text(
        '${widget.pregunta.idPregunta}. ${Utils.decodificarElemento(widget.pregunta.pregunta)}',
        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)));
    if (widget.pregunta.descripcionPregunta != null) {
      chilrenSeleccionar.add(Text(
          '${Utils.decodificarElemento(widget.pregunta.descripcionPregunta!)}',
          style: const TextStyle(fontSize: 12.0)));
    }

    List<DropdownMenuItem<String>> menuItems = [
      /*
      DropdownMenuItem(child: Text("Cédula de ciudadania"), value: "0"),
      DropdownMenuItem(child: Text("Tarjeta de identidad"), value: "1"),
      DropdownMenuItem(child: Text("Cédula de extranjeria"), value: "2"),
      DropdownMenuItem(child: Text("Pasaporte"), value: "3"),
      DropdownMenuItem(child: Text("Tipo de documento Extranjero"), value: "4"),*/
    ];

    List<Opcion> listaOpciones =
        getOpcionesPregunta(widget.pregunta, widget.preguntasData);

    for (Opcion opcion in listaOpciones) {
      menuItems.add(DropdownMenuItem(
          child:
              Text("${Utils.decodificarElemento(opcion.descripcionOpcion)} "),
          value:
              "${opcion.opcionIdPregunta}_${opcion.hereda}_${opcion.heredaPregunta}"));
    }

    var io = UniqueKey();

    var seleccionador = DropdownButtonFormField(
        isExpanded: true,
        hint: const Text("Seleccionar"),
        decoration: editTextDecoration("", false, "Obligatorio"),
        onChanged: (String? newValue) {
          setState(() {
            valueTipo = newValue!;

            var respuestaUnica = RespuestaEntrevista(
                idPregunta: widget.pregunta.idPregunta,
                idOpcion: valueTipo.toString().split("_")[1],
                idEntrevista: idEntrevista,
                idTipoPregunta: "S",
                idTextoRespuesta: "",
                idGrupoPregunta: widget.pregunta.idGrupoPregunta);

            //Verifico la herencia
            var idPRegunta = "";

            //Recargar las preguntas
            idPRegunta = valueTipo.toString().split("_")[3];
            widget.preguntasBloc.add(mostrarPreguntas(
                idPregunta: idPRegunta,
                preguntasData: widget.preguntasData,
                gruposData: widget.gruposList,
                herenciaData: widget.herenciaData,
                respuesta: valueTipo,
                herenciaOpcionRespuesta: null));
            /*
            if (valueTipo.toString().split("_")[2] == "True") {
              //Tiene herencia
              idPRegunta = valueTipo.toString().split("_")[3];
              //Muestro la pregunta
              widget.preguntasBloc.add(mostrarPreguntas(
                  idPregunta: idPRegunta,
                  preguntasData: widget.preguntasData,
                  gruposData: widget.gruposList,
                  herenciaData: widget.herenciaData,
                  respuesta: valueTipo));

              //Quito las herencias atneriores de la pregunta
            } else {
              //Oculto herencia mostrada de esa pregunta
              widget.preguntasBloc.add(mostrarPreguntas(
                  idPregunta: idPRegunta,
                  preguntasData: widget.preguntasData,
                  gruposData: widget.gruposList,
                  herenciaData: widget.herenciaData,
                  respuesta: valueTipo));
            }*/

            if (verificarPregunta(respuestaUnica)) {
              //No tiene tiene la respuesta

              respuestaPreguntas.removeWhere(
                  (element) => element.idPregunta == respuestaUnica.idPregunta);
              respuestaPreguntas.add(respuestaUnica);
            } else {
              respuestaPreguntas.add(respuestaUnica);
            }
          });

          print(valueTipo);
        },
        items: menuItems);
    chilrenSeleccionar.add(const SizedBox(
      height: 10,
    ));

    chilrenSeleccionar.add(seleccionador);

    return Visibility(
        visible: widget.pregunta.heredaPregunta == "False" ? true : false,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: chilrenSeleccionar,
              ),
            )));

    /*
    return BlocBuilder<VisibleBloc, VisibleState>(
      bloc: visibleBloc,
      builder: (context, state) {
        return state is Visible
            ? Visibility(
                visible: visibilidadPreguntas
                    .firstWhere((element) =>
                        element.idPregunta == widget.pregunta.idPregunta)
                    .isVisible,
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: chilrenSeleccionar,
                      ),
                    )))
            : Visibility(
                visible: visibilidadPreguntas
                    .firstWhere((element) =>
                        element.idPregunta == widget.pregunta.idPregunta)
                    .isVisible,
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: chilrenSeleccionar,
                      ),
                    )));
      },
    );*/
  }

  InputDecoration editTextDecoration(String hint, bool state, String helpText) {
    return InputDecoration(
        helperText: helpText,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 4,
              color: Utils().getColorFromHex(Preferences.colorEntidad)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 2, color: Color(0xffB6B1B7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 2,
              color: Utils().getColorFromHex(Preferences.colorEntidad)),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 1,
            )),
        errorBorder: state
            ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 2, color: Colors.red))
            : null,
        focusedErrorBorder: state
            ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 2, color: Colors.red))
            : null,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
        errorText: state ? "Campo obligatorio" : null);
  }

  bool getVisibility(String idPregunta) {
    setState(() {
      visibilidadPreguntas
          .firstWhere((element) => element.idPregunta == idPregunta)
          .isVisible = true;
    });

    return true;
  }
}
