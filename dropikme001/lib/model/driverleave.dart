// To parse this JSON data, do
//
//     final driverLeaveList = driverLeaveListFromJson(jsonString);

import 'dart:convert';

DriverLeaveList driverLeaveListFromJson(String str) => DriverLeaveList.fromJson(json.decode(str));

String driverLeaveListToJson(DriverLeaveList data) => json.encode(data.toJson());

class DriverLeaveList {
  DriverLeaveList({
    required this.message,
    required this.driverLeave,
  });

  String message;
  List<DriverLeave> driverLeave;

  factory DriverLeaveList.fromJson(Map<String, dynamic> json) => DriverLeaveList(
    message: json["message"],
    driverLeave: List<DriverLeave>.from(json["driverLeave"].map((x) => DriverLeave.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "driverLeave": List<dynamic>.from(driverLeave.map((x) => x.toJson())),
  };
}

class DriverLeave {
  DriverLeave({
    required this.id,
    required this.organizerId,
    required this.driverId,
    required this.shiftTypeId,
    required this.leaveTypeId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.isApproved,
    required this.approvedDate,
    required this.code,
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

  String id;
  String organizerId;
  String driverId;
  ShiftTypeId shiftTypeId;
  LeaveTypeId leaveTypeId;
  DateTime startDate;
  DateTime endDate;
  String reason;
  bool isApproved;
  String approvedDate;
  String code;
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

  factory DriverLeave.fromJson(Map<String, dynamic> json) => DriverLeave(
    id: json["_id"],
    organizerId: json["organizerId"],
    driverId: json["driverId"],
    shiftTypeId: ShiftTypeId.fromJson(json["shiftTypeId"]),
    leaveTypeId: LeaveTypeId.fromJson(json["leaveTypeId"]),
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    reason: json["reason"],
    isApproved: json["isApproved"],
    approvedDate: json["approvedDate"],
    code: json["code"],
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
    "driverId": driverId,
    "shiftTypeId": shiftTypeId.toJson(),
    "leaveTypeId": leaveTypeId.toJson(),
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "reason": reason,
    "isApproved": isApproved,
    "approvedDate": approvedDate,
    "code": code,
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

class LeaveTypeId {
  LeaveTypeId({
    required this.id,
    required this.name,
    required this.code,
    required this.isActive,
  });

  String id;
  String name;
  String code;
  bool isActive;

  factory LeaveTypeId.fromJson(Map<String, dynamic> json) => LeaveTypeId(
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

class ShiftTypeId {
  ShiftTypeId({
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

  factory ShiftTypeId.fromJson(Map<String, dynamic> json) => ShiftTypeId(
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
