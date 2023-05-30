// To parse this JSON data, do
//
//     final sosList = sosListFromJson(jsonString);

import 'dart:convert';

SosList sosListFromJson(String str) => SosList.fromJson(json.decode(str));

String sosListToJson(SosList data) => json.encode(data.toJson());

class SosList {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  SosList({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory SosList.fromJson(Map<String, dynamic> json) => SosList(
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
  List<MemberSosRequestList> memberSosRequestList;

  Result({
    required this.memberSosRequestList,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    memberSosRequestList: List<MemberSosRequestList>.from(json["memberSosRequestList"].map((x) => MemberSosRequestList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "memberSosRequestList": List<dynamic>.from(memberSosRequestList.map((x) => x.toJson())),
  };
}

class MemberSosRequestList {
  String id;
  DateTime createdAt;

  MemberSosRequestList({
    required this.id,
    required this.createdAt,
  });

  factory MemberSosRequestList.fromJson(Map<String, dynamic> json) => MemberSosRequestList(
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
  };
}
