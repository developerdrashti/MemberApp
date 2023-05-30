// To parse this JSON data, do
//
//     final addComplain = addComplainFromJson(jsonString);

import 'dart:convert';

AddComplain addComplainFromJson(String str) => AddComplain.fromJson(json.decode(str));

String addComplainToJson(AddComplain data) => json.encode(data.toJson());

class AddComplain {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  AddComplain({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory AddComplain.fromJson(Map<String, dynamic> json) => AddComplain(
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
  String organizerId;
  String driverId;
  String memberId;
  String vehicleId;
  String complaintMessage;
  String complaintAnswer;
  DateTime complaintDate;
  int complaintStatus;
  String createdBy;
  String updatedBy;
  bool isClear;
  bool isActive;
  bool isDeleted;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Result({
    required this.organizerId,
    required this.driverId,
    required this.memberId,
    required this.vehicleId,
    required this.complaintMessage,
    required this.complaintAnswer,
    required this.complaintDate,
    required this.complaintStatus,
    required this.createdBy,
    required this.updatedBy,
    required this.isClear,
    required this.isActive,
    required this.isDeleted,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    organizerId: json["organizerId"],
    driverId: json["driverId"],
    memberId: json["memberId"],
    vehicleId: json["vehicleId"],
    complaintMessage: json["complaintMessage"],
    complaintAnswer: json["complaintAnswer"],
    complaintDate: DateTime.parse(json["complaintDate"]),
    complaintStatus: json["complaintStatus"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    isClear: json["isClear"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "organizerId": organizerId,
    "driverId": driverId,
    "memberId": memberId,
    "vehicleId": vehicleId,
    "complaintMessage": complaintMessage,
    "complaintAnswer": complaintAnswer,
    "complaintDate": complaintDate.toIso8601String(),
    "complaintStatus": complaintStatus,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "isClear": isClear,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
