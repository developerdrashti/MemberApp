// To parse this JSON data, do
//
//     final mappingmember = mappingmemberFromJson(jsonString);

import 'dart:convert';

Mappingmember mappingmemberFromJson(String str) => Mappingmember.fromJson(json.decode(str));

String mappingmemberToJson(Mappingmember data) => json.encode(data.toJson());

class Mappingmember {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  Mappingmember({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory Mappingmember.fromJson(Map<String, dynamic> json) => Mappingmember(
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
  List<MemberDefaultMapping> memberDefaultMapping;

  Result({
    required this.memberDefaultMapping,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    memberDefaultMapping: List<MemberDefaultMapping>.from(json["MemberDefaultMapping"].map((x) => MemberDefaultMapping.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "MemberDefaultMapping": List<dynamic>.from(memberDefaultMapping.map((x) => x.toJson())),
  };
}

class MemberDefaultMapping {
  String id;
  String shiftTypeId;
  String pickUpRouteId;
  String memberDropLocation;
  String memberPickUpLocation;
  String memberPickupTime;
  String memberDropTime;
  String memberVehicleRegId;
  String memberDriverId;

  MemberDefaultMapping({
    required this.id,
    required this.shiftTypeId,
    required this.pickUpRouteId,
    required this.memberDropLocation,
    required this.memberPickUpLocation,
    required this.memberPickupTime,
    required this.memberDropTime,
    required this.memberVehicleRegId,
    required this.memberDriverId,
  });

  factory MemberDefaultMapping.fromJson(Map<String, dynamic> json) => MemberDefaultMapping(
    id: json["_id"],
    shiftTypeId: json["shiftTypeId"],
    pickUpRouteId: json["pickUpRouteId"],
    memberDropLocation: json["memberDropLocation"],
    memberPickUpLocation: json["memberPickUpLocation"],
    memberPickupTime: json["memberPickupTime"],
    memberDropTime: json["memberDropTime"],
    memberVehicleRegId: json["memberVehicleRegId"],
    memberDriverId: json["memberDriverId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "shiftTypeId": shiftTypeId,
    "pickUpRouteId": pickUpRouteId,
    "memberDropLocation": memberDropLocation,
    "memberPickUpLocation": memberPickUpLocation,
    "memberPickupTime": memberPickupTime,
    "memberDropTime": memberDropTime,
    "memberVehicleRegId": memberVehicleRegId,
    "memberDriverId": memberDriverId,
  };
}
