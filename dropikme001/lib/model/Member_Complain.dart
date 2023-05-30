// To parse this JSON data, do
//
//     final membercomplain = membercomplainFromJson(jsonString);

import 'dart:convert';

Membercomplain membercomplainFromJson(String str) => Membercomplain.fromJson(json.decode(str));

String membercomplainToJson(Membercomplain data) => json.encode(data.toJson());

class Membercomplain {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  Membercomplain({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory Membercomplain.fromJson(Map<String, dynamic> json) => Membercomplain(
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
  List<DriverComplaint> driverComplaints;

  Result({
    required this.driverComplaints,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    driverComplaints: List<DriverComplaint>.from(json["DriverComplaints"].map((x) => DriverComplaint.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "DriverComplaints": List<dynamic>.from(driverComplaints.map((x) => x.toJson())),
  };
}

class DriverComplaint {
  String id;
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
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  DriverComplaint({
    required this.id,
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
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory DriverComplaint.fromJson(Map<String, dynamic> json) => DriverComplaint(
    id: json["_id"],
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
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
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
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
