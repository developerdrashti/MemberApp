// To parse this JSON data, do
//
//     final addMemberLeave = addMemberLeaveFromJson(jsonString);

import 'dart:convert';

AddMemberLeave addMemberLeaveFromJson(String str) => AddMemberLeave.fromJson(json.decode(str));

String addMemberLeaveToJson(AddMemberLeave data) => json.encode(data.toJson());

class AddMemberLeave {
  String message;
  bool isSuccess;
  int statusCode;

  AddMemberLeave({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
  });

  factory AddMemberLeave.fromJson(Map<String, dynamic> json) => AddMemberLeave(
    message: json["message"],
    isSuccess: json["isSuccess"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "statusCode": statusCode,
  };
}
