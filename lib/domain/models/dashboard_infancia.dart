import 'dart:convert';

class Welcome {
    final String? status;
    final InfoInfancia? info;
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
        info: json["info"] == null ? null : InfoInfancia.fromJson(json["info"]),
        mensaje: json["Mensaje"],
    );

    Map<String, dynamic> toJson() => {
        "Status": status,
        "info": info?.toJson(),
        "Mensaje": mensaje,
    };
}

class InfoInfancia {
    final List<Datum>? data;
    final int? totales;
    final List<String>? meses;
    final String? opcion;

    InfoInfancia({
        this.data,
        this.totales,
        this.meses,
        this.opcion,
    });

    factory InfoInfancia.fromRawJson(String str) => InfoInfancia.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory InfoInfancia.fromJson(Map<String, dynamic> json) => InfoInfancia(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        totales: json["totales"],
        meses: json["meses"] == null ? [] : List<String>.from(json["meses"]!.map((x) => x)),
        opcion: json["opcion"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totales": totales,
        "meses": meses == null ? [] : List<dynamic>.from(meses!.map((x) => x)),
        "opcion": opcion,
    };
}

class Datum {
    final String? mes;
    final int? total;

    Datum({
        this.mes,
        this.total,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        mes: json["mes"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "mes": mes,
        "total": total,
    };
}
