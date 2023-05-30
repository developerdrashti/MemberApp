// To parse this JSON data, do
//
//     final notificationList = notificationListFromJson(jsonString);

import 'dart:convert';

NotificationList notificationListFromJson(String str) => NotificationList.fromJson(json.decode(str));

String notificationListToJson(NotificationList data) => json.encode(data.toJson());

class NotificationList {
  String message;
  bool isSuccess;
  int statusCode;
  List<Notificatiodata> result;

  NotificationList({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    message: json["message"],
    isSuccess: json["isSuccess"],
    statusCode: json["statusCode"],
    result: List<Notificatiodata>.from(json["result"].map((x) => Notificatiodata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "statusCode": statusCode,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Notificatiodata {
  String id;
  String userId;
  String userType;
  String message;
  String deviceId;
  bool isRead;
  bool isClear;
  String title;
  String receiverId;
  String receiverType;
  String destinationScreen;
  DateTime createdAt;
  DateTime updatedAt;
  String slicedDate;

  Notificatiodata({
    required this.id,
    required this.userId,
    required this.userType,
    required this.message,
    required this.deviceId,
    required this.isRead,
    required this.isClear,
    required this.title,
    required this.receiverId,
    required this.receiverType,
    required this.destinationScreen,
    required this.createdAt,
    required this.updatedAt,
    required this.slicedDate,
  });

  factory Notificatiodata.fromJson(Map<String, dynamic> json) => Notificatiodata(
    id: json["_id"],
    userId: json["userId"],
    userType: json["userType"],
    message: json["message"],
    deviceId: json["deviceId"],
    isRead: json["isRead"],
    isClear: json["isClear"],
    title: json["title"],
    receiverId: json["receiverId"],
    receiverType: json["receiverType"],
    destinationScreen: json["destinationScreen"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    slicedDate: json["slicedDate"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "userType": userType,
    "message": message,
    "deviceId": deviceId,
    "isRead": isRead,
    "isClear": isClear,
    "title": title,
    "receiverId": receiverId,
    "receiverType": receiverType,
    "destinationScreen": destinationScreen,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "slicedDate": slicedDate,
  };
}
