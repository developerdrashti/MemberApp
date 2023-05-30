// To parse this JSON data, do
//
//     final notificationUpdate = notificationUpdateFromJson(jsonString);

import 'dart:convert';

NotificationUpdate notificationUpdateFromJson(String str) => NotificationUpdate.fromJson(json.decode(str));

String notificationUpdateToJson(NotificationUpdate data) => json.encode(data.toJson());

class NotificationUpdate {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  NotificationUpdate({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory NotificationUpdate.fromJson(Map<String, dynamic> json) => NotificationUpdate(
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
  String id;
  String userId;
  String userType;
  String message;
  String deviceId;
  bool isRead;
  bool isClear;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Result({
    required this.id,
    required this.userId,
    required this.userType,
    required this.message,
    required this.deviceId,
    required this.isRead,
    required this.isClear,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    userType: json["userType"],
    message: json["message"],
    deviceId: json["deviceId"],
    isRead: json["isRead"],
    isClear: json["isClear"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "userType": userType,
    "message": message,
    "deviceId": deviceId,
    "isRead": isRead,
    "isClear": isClear,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
