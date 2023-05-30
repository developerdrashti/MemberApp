// To parse this JSON data, do
//
//     final clearAllmemberleave = clearAllmemberleaveFromJson(jsonString);

import 'dart:convert';

ClearAllmemberleave clearAllmemberleaveFromJson(String str) => ClearAllmemberleave.fromJson(json.decode(str));

String clearAllmemberleaveToJson(ClearAllmemberleave data) => json.encode(data.toJson());

class ClearAllmemberleave {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  ClearAllmemberleave({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory ClearAllmemberleave.fromJson(Map<String, dynamic> json) => ClearAllmemberleave(
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
  SingleMemberLeaveCancel singleMemberLeaveCancel;

  Result({
    required this.singleMemberLeaveCancel,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    singleMemberLeaveCancel: SingleMemberLeaveCancel.fromJson(json["singleMemberLeaveCancel"]),
  );

  Map<String, dynamic> toJson() => {
    "singleMemberLeaveCancel": singleMemberLeaveCancel.toJson(),
  };
}

class SingleMemberLeaveCancel {
  bool acknowledged;
  int modifiedCount;
  dynamic upsertedId;
  int upsertedCount;
  int matchedCount;

  SingleMemberLeaveCancel({
    required this.acknowledged,
    required this.modifiedCount,
    this.upsertedId,
    required this.upsertedCount,
    required this.matchedCount,
  });

  factory SingleMemberLeaveCancel.fromJson(Map<String, dynamic> json) => SingleMemberLeaveCancel(
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
