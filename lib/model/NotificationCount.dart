// To parse this JSON data, do
//
//     final notificationCount = notificationCountFromJson(jsonString);

import 'dart:convert';

NotificationCount notificationCountFromJson(String str) => NotificationCount.fromJson(json.decode(str));

String notificationCountToJson(NotificationCount data) => json.encode(data.toJson());

class NotificationCount {
  String message;
  bool isSuccess;
  int statusCode;
  List<Datum> result;

  NotificationCount({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory NotificationCount.fromJson(Map<String, dynamic> json) => NotificationCount(
    message: json["message"],
    isSuccess: json["isSuccess"],
    statusCode: json["statusCode"],
    result: List<Datum>.from(json["result"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "statusCode": statusCode,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Datum {
  int notificationCount;

  Datum({
    required this.notificationCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    notificationCount: json["notificationCount"],
  );

  Map<String, dynamic> toJson() => {
    "notificationCount": notificationCount,
  };
}
