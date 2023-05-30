// To parse this JSON data, do
//
//     final updatecomplainldata = updatecomplainldataFromJson(jsonString);

import 'dart:convert';

Updatecomplainldata updatecomplainldataFromJson(String str) => Updatecomplainldata.fromJson(json.decode(str));

String updatecomplainldataToJson(Updatecomplainldata data) => json.encode(data.toJson());

class Updatecomplainldata {
  String message;
  bool isSuccess;
  int statusCode;

  Updatecomplainldata({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
  });

  factory Updatecomplainldata.fromJson(Map<String, dynamic> json) => Updatecomplainldata(
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
