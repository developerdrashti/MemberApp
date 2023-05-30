// To parse this JSON data, do
//
//     final failed = failedFromJson(jsonString);

import 'dart:convert';

Failed failedFromJson(String str) => Failed.fromJson(json.decode(str));

String failedToJson(Failed data) => json.encode(data.toJson());

class Failed {
  Failed({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
  });

  String message;
  bool isSuccess;
  int statusCode;

  factory Failed.fromJson(Map<String, dynamic> json) => Failed(
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
