import 'dart:convert';

class Welcome {
    final String? status;
    final List<Info>? info;
    final String? mensaje;

    Welcome({
        this.status,
        this.info,
        this.mensaje,
    });

    factory Welcome.fromRawJson(String str) => Welcome.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["Status"],
        info: json["info"] == null ? [] : List<Info>.from(json["info"]!.map((x) => Info.fromJson(x))),
        mensaje: json["mensaje"],
    );

    Map<String, dynamic> toJson() => {
        "Status": status,
        "info": info == null ? [] : List<dynamic>.from(info!.map((x) => x.toJson())),
        "mensaje": mensaje,
    };
}

class Info {
    final String? idEntrevista;
    final String? idTercero;
    final dynamic idHogar;
    final String? fechaEntrevista;
    final String? app;
    final String? usuario;
    final String? nombres;
    final String? apellidos;
    final String? estado;

    Info({
        this.idEntrevista,
        this.idTercero,
        this.idHogar,
        this.fechaEntrevista,
        this.app,
        this.usuario,
        this.nombres,
        this.apellidos,
        this.estado,
    });

    factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        idEntrevista: json["idEntrevista"],
        idTercero: json["idTercero"],
        idHogar: json["idHogar"],
        fechaEntrevista: json["fecha_entrevista"] == null ? null : (json["fecha_entrevista"]),
        app: json["app"],
        usuario: json["usuario"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "idEntrevista": idEntrevista,
        "idTercero": idTercero,
        "idHogar": idHogar,
        "fecha_entrevista": fechaEntrevista,
        "app": app,
        "usuario": usuario,
        "nombres": nombres,
        "apellidos": apellidos,
        "estado": estado,
    };
}
