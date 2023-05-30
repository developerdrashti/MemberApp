// To parse this JSON data, do
//
//     final updateMemberleave = updateMemberleaveFromJson(jsonString);

import 'dart:convert';

UpdateMemberleave updateMemberleaveFromJson(String str) => UpdateMemberleave.fromJson(json.decode(str));

String updateMemberleaveToJson(UpdateMemberleave data) => json.encode(data.toJson());

class UpdateMemberleave {
  String message;
  bool isSuccess;
  int statusCode;

  UpdateMemberleave({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
  });

  factory UpdateMemberleave.fromJson(Map<String, dynamic> json) => UpdateMemberleave(
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
