// To parse this JSON data, do
//
//     final membersingleleave = membersingleleaveFromJson(jsonString);

import 'dart:convert';

Membersingleleave membersingleleaveFromJson(String str) => Membersingleleave.fromJson(json.decode(str));

String membersingleleaveToJson(Membersingleleave data) => json.encode(data.toJson());

class Membersingleleave {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  Membersingleleave({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory Membersingleleave.fromJson(Map<String, dynamic> json) => Membersingleleave(
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
  SingleMemberLeave singleMemberLeave;

  Result({
    required this.singleMemberLeave,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    singleMemberLeave: SingleMemberLeave.fromJson(json["singleMemberLeave"]),
  );

  Map<String, dynamic> toJson() => {
    "singleMemberLeave": singleMemberLeave.toJson(),
  };
}

class SingleMemberLeave {
  String id;
  String organizerId;
  String memberId;
  String shiftTypeId;
  String vehicleId;
  String leaveTypeId;
  DateTime startDate;
  DateTime endDate;
  String reason;
  String code;
  String description;
  String note;
  String details;
  String createdBy;
  String updatedBy;
  bool isActive;
  bool isDeleted;
  bool isRead;
  bool isClear;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  SingleMemberLeave({
    required this.id,
    required this.organizerId,
    required this.memberId,
    required this.shiftTypeId,
    required this.vehicleId,
    required this.leaveTypeId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.code,
    required this.description,
    required this.note,
    required this.details,
    required this.createdBy,
    required this.updatedBy,
    required this.isActive,
    required this.isDeleted,
    required this.isRead,
    required this.isClear,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SingleMemberLeave.fromJson(Map<String, dynamic> json) => SingleMemberLeave(
    id: json["_id"],
    organizerId: json["organizerId"],
    memberId: json["memberId"],
    shiftTypeId: json["shiftTypeId"],
    vehicleId: json["vehicleId"],
    leaveTypeId: json["leaveTypeId"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    reason: json["reason"],
    code: json["code"],
    description: json["description"],
    note: json["note"],
    details: json["details"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    isRead: json["isRead"],
    isClear: json["isClear"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "organizerId": organizerId,
    "memberId": memberId,
    "shiftTypeId": shiftTypeId,
    "vehicleId": vehicleId,
    "leaveTypeId": leaveTypeId,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "reason": reason,
    "code": code,
    "description": description,
    "note": note,
    "details": details,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "isRead": isRead,
    "isClear": isClear,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
