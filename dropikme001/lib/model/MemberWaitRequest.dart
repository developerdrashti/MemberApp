// To parse this JSON data, do
//
//     final memberWaitRequest = memberWaitRequestFromJson(jsonString);

import 'dart:convert';

MemberWaitRequest memberWaitRequestFromJson(String str) => MemberWaitRequest.fromJson(json.decode(str));

String memberWaitRequestToJson(MemberWaitRequest data) => json.encode(data.toJson());

class MemberWaitRequest {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  MemberWaitRequest({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory MemberWaitRequest.fromJson(Map<String, dynamic> json) => MemberWaitRequest(
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
  MemberWaitRequestClass memberWaitRequest;

  Result({
    required this.memberWaitRequest,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    memberWaitRequest: MemberWaitRequestClass.fromJson(json["MemberWaitRequest"]),
  );

  Map<String, dynamic> toJson() => {
    "MemberWaitRequest": memberWaitRequest.toJson(),
  };
}

class MemberWaitRequestClass {
  String organizerId;
  String memberId;
  String shiftTypeId;
  String vehicleId;
  String waitTime;
  String waitMonth;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MemberWaitRequestClass({
    required this.organizerId,
    required this.memberId,
    required this.shiftTypeId,
    required this.vehicleId,
    required this.waitTime,
    required this.waitMonth,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MemberWaitRequestClass.fromJson(Map<String, dynamic> json) => MemberWaitRequestClass(
    organizerId: json["organizerId"],
    memberId: json["memberId"],
    shiftTypeId: json["shiftTypeId"],
    vehicleId: json["vehicleId"],
    waitTime: json["waitTime"],
    waitMonth: json["waitMonth"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "organizerId": organizerId,
    "memberId": memberId,
    "shiftTypeId": shiftTypeId,
    "vehicleId": vehicleId,
    "waitTime": waitTime,
    "waitMonth": waitMonth,
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
