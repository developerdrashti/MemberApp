// To parse this JSON data, do
//
//     final cencelcomplain = cencelcomplainFromJson(jsonString);

import 'dart:convert';

Cencelcomplain cencelcomplainFromJson(String str) => Cencelcomplain.fromJson(json.decode(str));

String cencelcomplainToJson(Cencelcomplain data) => json.encode(data.toJson());

class Cencelcomplain {
  String message;
  bool isSuccess;
  int statusCode;

  Cencelcomplain({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
  });

  factory Cencelcomplain.fromJson(Map<String, dynamic> json) => Cencelcomplain(
    message: json["message"],
    isSuccess: json["isSuccess"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "statusCode": statusCode,
  };
}
