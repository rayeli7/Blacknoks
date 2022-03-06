// To parse this JSON data, do
//
//     final flutterWaveResponse = flutterWaveResponseFromJson(jsonString);

import 'dart:convert';

FlutterWaveResponse flutterWaveResponseFromJson(String str) => FlutterWaveResponse.fromJson(json.decode(str));

String flutterWaveResponseToJson(FlutterWaveResponse data) => json.encode(data.toJson());

class FlutterWaveResponse {
    FlutterWaveResponse({
        required this.status,
        required this.message,
        required this.meta,
    });

    final String status;
    final String message;
    final Meta meta;

    factory FlutterWaveResponse.fromJson(Map<String, dynamic> json) => FlutterWaveResponse(
        status: json["status"],
        message: json["message"],
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "meta": meta.toJson(),
    };
}

class Meta {
    Meta({
        required this.authorization,
    });

    final Authorization authorization;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        authorization: Authorization.fromJson(json["authorization"]),
    );

    Map<String, dynamic> toJson() => {
        "authorization": authorization.toJson(),
    };
}

class Authorization {
    Authorization({
        required this.redirect,
        required this.mode,
    });

    final String redirect;
    final String mode;

    factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        redirect: json["redirect"],
        mode: json["mode"],
    );

    Map<String, dynamic> toJson() => {
        "redirect": redirect,
        "mode": mode,
    };
}
