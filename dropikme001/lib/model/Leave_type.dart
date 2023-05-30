// To parse this JSON data, do
//
//     final memberLeaveList = memberLeaveListFromJson(jsonString);

import 'dart:convert';

MemberLeaveList memberLeaveListFromJson(String str) => MemberLeaveList.fromJson(json.decode(str));

String memberLeaveListToJson(MemberLeaveList data) => json.encode(data.toJson());

class MemberLeaveList {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  MemberLeaveList({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory MemberLeaveList.fromJson(Map<String, dynamic> json) => MemberLeaveList(
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
  List<MemberLeave> memberLeave;

  Result({
    required this.memberLeave,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    memberLeave: List<MemberLeave>.from(json["memberLeave"].map((x) => MemberLeave.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "memberLeave": List<dynamic>.from(memberLeave.map((x) => x.toJson())),
  };
}

class MemberLeave {
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
  ShiftTypeData shiftTypeData;
  LeaveTypeData leaveTypeData;
  String shiftTypeName;
  String leaveTypeName;

  MemberLeave({
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
    required this.shiftTypeData,
    required this.leaveTypeData,
    required this.shiftTypeName,
    required this.leaveTypeName,
  });

  factory MemberLeave.fromJson(Map<String, dynamic> json) => MemberLeave(
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
    shiftTypeData: ShiftTypeData.fromJson(json["shiftTypeData"]),
    leaveTypeData: LeaveTypeData.fromJson(json["leaveTypeData"]),
    shiftTypeName: json["shiftTypeName"],
    leaveTypeName: json["leaveTypeName"],
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
    "shiftTypeData": shiftTypeData.toJson(),
    "leaveTypeData": leaveTypeData.toJson(),
    "shiftTypeName": shiftTypeName,
    "leaveTypeName": leaveTypeName,
  };
}

class LeaveTypeData {
  String id;
  String name;
  String code;
  bool isActive;

  LeaveTypeData({
    required this.id,
    required this.name,
    required this.code,
    required this.isActive,
  });

  factory LeaveTypeData.fromJson(Map<String, dynamic> json) => LeaveTypeData(
    id: json["_id"],
    name: json["name"],
    code: json["code"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "code": code,
    "isActive": isActive,
  };
}

class ShiftTypeData {
  String id;
  String organizerId;
  String name;
  String code;
  String inTime;
  String outTime;
  String description;
  String note;
  String details;
  String createdBy;
  String updatedBy;
  bool isActive;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ShiftTypeData({
    required this.id,
    required this.organizerId,
    required this.name,
    required this.code,
    required this.inTime,
    required this.outTime,
    required this.description,
    required this.note,
    required this.details,
    required this.createdBy,
    required this.updatedBy,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ShiftTypeData.fromJson(Map<String, dynamic> json) => ShiftTypeData(
    id: json["_id"],
    organizerId: json["organizerId"],
    name: json["name"],
    code: json["code"],
    inTime: json["inTime"],
    outTime: json["outTime"],
    description: json["description"],
    note: json["note"],
    details: json["details"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "organizerId": organizerId,
    "name": name,
    "code": code,
    "inTime": inTime,
    "outTime": outTime,
    "description": description,
    "note": note,
    "details": details,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
