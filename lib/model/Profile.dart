// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  Profile({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
  List<MemberProfileDetail> memberProfileDetails;

  Result({
    required this.memberProfileDetails,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    memberProfileDetails: List<MemberProfileDetail>.from(json["memberProfileDetails"].map((x) => MemberProfileDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "memberProfileDetails": List<dynamic>.from(memberProfileDetails.map((x) => x.toJson())),
  };
}

class MemberProfileDetail {
  String id;
  String name;
  String photo;
  String contactNo;
  String email;
  String address;
  String bloodGroup;
  String memberDepartmentName;
  List<MemberShiftName> memberShiftName;

  MemberProfileDetail({
    required this.id,
    required this.name,
    required this.photo,
    required this.contactNo,
    required this.email,
    required this.address,
    required this.bloodGroup,
    required this.memberDepartmentName,
    required this.memberShiftName,
  });

  factory MemberProfileDetail.fromJson(Map<String, dynamic> json) => MemberProfileDetail(
    id: json["_id"],
    name: json["name"],
    photo: json["photo"],
    contactNo: json["contactNo"],
    email: json["email"],
    address: json["address"],
    bloodGroup: json["bloodGroup"],
    memberDepartmentName: json["memberDepartmentName"],
    memberShiftName: List<MemberShiftName>.from(json["memberShiftName"].map((x) => MemberShiftName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "photo": photo,
    "contactNo": contactNo,
    "email": email,
    "address": address,
    "bloodGroup": bloodGroup,
    "memberDepartmentName": memberDepartmentName,
    "memberShiftName": List<dynamic>.from(memberShiftName.map((x) => x.toJson())),
  };
}

class MemberShiftName {
  String name;

  MemberShiftName({
    required this.name,
  });

  factory MemberShiftName.fromJson(Map<String, dynamic> json) => MemberShiftName(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
