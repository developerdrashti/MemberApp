// To parse this JSON data, do
//
//     final addSos = addSosFromJson(jsonString);

import 'dart:convert';

AddSos addSosFromJson(String str) => AddSos.fromJson(json.decode(str));

String addSosToJson(AddSos data) => json.encode(data.toJson());

class AddSos {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  AddSos({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory AddSos.fromJson(Map<String, dynamic> json) => AddSos(
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
  String memberId;
  String orgNo;
  String memberEmgNo;
  String memberName;

  Result({
    required this.memberId,
    required this.orgNo,
    required this.memberEmgNo,
    required this.memberName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    memberId: json["memberId"],
    orgNo: json["orgNo"],
    memberEmgNo: json["memberEmgNo"],
    memberName: json["memberName"],
  );

  Map<String, dynamic> toJson() => {
    "memberId": memberId,
    "orgNo": orgNo,
    "memberEmgNo": memberEmgNo,
    "memberName": memberName,
  };
}
