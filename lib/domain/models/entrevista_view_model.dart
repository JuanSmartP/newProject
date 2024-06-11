import 'dart:convert';

class Welcome {
    final bool? status;
    final List<Informacion>? informacion;
    final String? mensaje;

    Welcome({
        this.status,
        this.informacion,
        this.mensaje,
    });

    factory Welcome.fromRawJson(String str) => Welcome.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["Status"],
        informacion: json["informacion"] == null ? [] : List<Informacion>.from(json["informacion"]!.map((x) => Informacion.fromJson(x))),
        mensaje: json["Mensaje"],
    );

    Map<String, dynamic> toJson() => {
        "Status": status,
        "informacion": informacion == null ? [] : List<dynamic>.from(informacion!.map((x) => x.toJson())),
        "Mensaje": mensaje,
    };
}

class Informacion {
    final String? entrevista;
    final String? tercero;
    final DateTime? fechaEntrevista;
    final String? usuario;
    final String? nombreCompleto;
    final List<Respuesta>? respuestas;

    Informacion({
        this.entrevista,
        this.tercero,
        this.fechaEntrevista,
        this.usuario,
        this.nombreCompleto,
        this.respuestas,
    });

    factory Informacion.fromRawJson(String str) => Informacion.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Informacion.fromJson(Map<String, dynamic> json) => Informacion(
        entrevista: json["entrevista"],
        tercero: json["tercero"],
        fechaEntrevista: json["fecha_entrevista"] == null ? null : DateTime.parse(json["fecha_entrevista"]),
        usuario: json["usuario"],
        nombreCompleto: json["nombre_completo"],
        respuestas: json["respuestas"] == null ? [] : List<Respuesta>.from(json["respuestas"]!.map((x) => Respuesta.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "entrevista": entrevista,
        "tercero": tercero,
        "fecha_entrevista": fechaEntrevista?.toIso8601String(),
        "usuario": usuario,
        "nombre_completo": nombreCompleto,
        "respuestas": respuestas == null ? [] : List<dynamic>.from(respuestas!.map((x) => x.toJson())),
    };
}

class Respuesta {
    final String? preguntaId;
    final String? pregunta;
    final String? idOpcion;
    final TipoPregunta? tipoPregunta;
    final String? respuesta;

    Respuesta({
        this.preguntaId,
        this.pregunta,
        this.idOpcion,
        this.tipoPregunta,
        this.respuesta,
    });

    factory Respuesta.fromRawJson(String str) => Respuesta.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Respuesta.fromJson(Map<String, dynamic> json) => Respuesta(
        preguntaId: json["pregunta_id"],
        pregunta: json["pregunta"],
        idOpcion: json["idOpcion"],
        tipoPregunta: tipoPreguntaValues.map[json["tipoPregunta"]]!,
        respuesta: json["respuesta"],
    );

    Map<String, dynamic> toJson() => {
        "pregunta_id": preguntaId,
        "pregunta": pregunta,
        "idOpcion": idOpcion,
        "tipoPregunta": tipoPreguntaValues.reverse[tipoPregunta],
        "respuesta": respuesta,
    };
}

enum TipoPregunta {
    DS,
    M,
    R,
    S
}

final tipoPreguntaValues = EnumValues({
    "DS": TipoPregunta.DS,
    "M": TipoPregunta.M,
    "R": TipoPregunta.R,
    "S": TipoPregunta.S
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
