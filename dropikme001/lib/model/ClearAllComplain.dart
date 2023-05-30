// To parse this JSON data, do
//
//     final clearallcomplain = clearallcomplainFromJson(jsonString);

import 'dart:convert';

Clearallcomplain clearallcomplainFromJson(String str) => Clearallcomplain.fromJson(json.decode(str));

String clearallcomplainToJson(Clearallcomplain data) => json.encode(data.toJson());

class Clearallcomplain {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  Clearallcomplain({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory Clearallcomplain.fromJson(Map<String, dynamic> json) => Clearallcomplain(
    message: json["message"],
    isSuccess: json["isSuccess"],
    statusCode: json["statusCode"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "statusCode": statusCode,
    "result": result.toJson(),
  };
}

class Result {
  bool acknowledged;
  int modifiedCount;
  dynamic upsertedId;
  int upsertedCount;
  int matchedCount;

  Result({
    required this.acknowledged,
    required this.modifiedCount,
    this.upsertedId,
    required this.upsertedCount,
    required this.matchedCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    acknowledged: json["acknowledged"],
    modifiedCount: json["modifiedCount"],
    upsertedId: json["upsertedId"],
    upsertedCount: json["upsertedCount"],
    matchedCount: json["matchedCount"],
  );

  Map<String, dynamic> toJson() => {
    "acknowledged": acknowledged,
    "modifiedCount": modifiedCount,
    "upsertedId": upsertedId,
    "upsertedCount": upsertedCount,
    "matchedCount": matchedCount,
  };
}
