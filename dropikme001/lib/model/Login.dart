// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  Login({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
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
  Member member;

  Result({
    required this.member,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    member: Member.fromJson(json["member"]),
  );

  Map<String, dynamic> toJson() => {
    "member": member.toJson(),
  };
}

class Member {
  Response response;
  bool paymentCheck;
  bool rfidCardCheck;
  bool isMultiShift;
  String businessNameAdd;

  Member({
    required this.response,
    required this.paymentCheck,
    required this.rfidCardCheck,
    required this.isMultiShift,
    required this.businessNameAdd,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    response: Response.fromJson(json["response"]),
    paymentCheck: json["paymentCheck"],
    rfidCardCheck: json["rfidCardCheck"],
    isMultiShift: json["isMultiShift"],
    businessNameAdd: json["businessNameAdd"],
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
    "paymentCheck": paymentCheck,
    "rfidCardCheck": rfidCardCheck,
    "isMultiShift": isMultiShift,
    "businessNameAdd": businessNameAdd,
  };
}

class Response {
  String organizerId;
  String memberId;
  String memberName;
  String profilePhoto;
  String contactNo;
  String deviceId;
  String deviceDetails;
  bool isFromMobile;
  String token;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Response({
    required this.organizerId,
    required this.memberId,
    required this.memberName,
    required this.profilePhoto,
    required this.contactNo,
    required this.deviceId,
    required this.deviceDetails,
    required this.isFromMobile,
    required this.token,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    organizerId: json["organizerId"],
    memberId: json["memberId"],
    memberName: json["memberName"],
    profilePhoto: json["profilePhoto"],
    contactNo: json["contactNo"],
    deviceId: json["deviceId"],
    deviceDetails: json["deviceDetails"],
    isFromMobile: json["isFromMobile"],
    token: json["token"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "organizerId": organizerId,
    "memberId": memberId,
    "memberName": memberName,
    "profilePhoto": profilePhoto,
    "contactNo": contactNo,
    "deviceId": deviceId,
    "deviceDetails": deviceDetails,
    "isFromMobile": isFromMobile,
    "token": token,
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
