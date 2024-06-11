import 'dart:convert';

class Entrevista {
    final bool? status;
    final List<Info>? info;
    final String? mensaje;

    Entrevista({
        this.status,
        this.info,
        this.mensaje,
    });

    factory Entrevista.fromRawJson(String str) => Entrevista.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Entrevista.fromJson(Map<String, dynamic> json) => Entrevista(
        status: json["Status"],
        info: json["info"] == null ? [] : List<Info>.from(json["info"]!.map((x) => Info.fromJson(x))),
        mensaje: json["Mensaje"],
    );

    Map<String, dynamic> toJson() => {
        "Status": status,
        "info": info == null ? [] : List<dynamic>.from(info!.map((x) => x.toJson())),
        "Mensaje": mensaje,
    };
}

class Info {
    final String? entrevista;
    final String? tercero;
    final DateTime? fechaEntrevista;
    final String? usuario;
    final String? nombreCompleto;
    final List<Respuesta>? respuestas;

    Info({
        this.entrevista,
        this.tercero,
        this.fechaEntrevista,
        this.usuario,
        this.nombreCompleto,
        this.respuestas,
    });

    factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Info.fromJson(Map<String, dynamic> json) => Info(
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
