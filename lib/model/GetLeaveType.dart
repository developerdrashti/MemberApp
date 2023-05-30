// To parse this JSON data, do
//
//     final leaveType = leaveTypeFromJson(jsonString);

import 'dart:convert';

LeaveType leaveTypeFromJson(String str) => LeaveType.fromJson(json.decode(str));

String leaveTypeToJson(LeaveType data) => json.encode(data.toJson());

class LeaveType {
  LeaveType({
    required this.message,
    required this.leaveTypes,
  });

  String message;
  List<LeaveTypeElement> leaveTypes;

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
    message: json["message"],
    leaveTypes: List<LeaveTypeElement>.from(json["LeaveTypes"].map((x) => LeaveTypeElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "LeaveTypes": List<dynamic>.from(leaveTypes.map((x) => x.toJson())),
  };
}

class LeaveTypeElement {
  LeaveTypeElement({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory LeaveTypeElement.fromJson(Map<String, dynamic> json) => LeaveTypeElement(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
