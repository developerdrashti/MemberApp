// To parse this JSON data, do
//
//     final updateProfile = updateProfileFromJson(jsonString);

import 'dart:convert';

UpdateProfile updateProfileFromJson(String str) => UpdateProfile.fromJson(json.decode(str));

String updateProfileToJson(UpdateProfile data) => json.encode(data.toJson());

class UpdateProfile {
  String message;
  bool isSuccess;
  int statusCode;
  Result result;

  UpdateProfile({
    required this.message,
    required this.isSuccess,
    required this.statusCode,
    required this.result,
  });

  factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
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
  String id;
  String organizerId;
  String name;
  String photo;
  String memberId;
  String departmentId;
  DateTime dob;
  String categoryId;
  dynamic typeId;
  String contactNo;
  String emergencyNo;
  String email;
  String address;
  String pinCode;
  String area;
  String bloodGroup;
  String description;
  String note;
  String details;
  String createdBy;
  String updatedBy;
  bool isActive;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Member({
    required this.id,
    required this.organizerId,
    required this.name,
    required this.photo,
    required this.memberId,
    required this.departmentId,
    required this.dob,
    required this.categoryId,
    this.typeId,
    required this.contactNo,
    required this.emergencyNo,
    required this.email,
    required this.address,
    required this.pinCode,
    required this.area,
    required this.bloodGroup,
    required this.description,
    required this.note,
    required this.details,
    required this.createdBy,
    required this.updatedBy,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["_id"],
    organizerId: json["organizerId"],
    name: json["name"],
    photo: json["photo"],
    memberId: json["memberId"],
    departmentId: json["departmentId"],
    dob: DateTime.parse(json["dob"]),
    categoryId: json["categoryId"],
    typeId: json["typeId"],
    contactNo: json["contactNo"],
    emergencyNo: json["emergencyNo"],
    email: json["email"],
    address: json["address"],
    pinCode: json["pinCode"],
    area: json["area"],
    bloodGroup: json["bloodGroup"],
    description: json["description"],
    note: json["note"],
    details: json["details"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "organizerId": organizerId,
    "name": name,
    "photo": photo,
    "memberId": memberId,
    "departmentId": departmentId,
    "dob": dob.toIso8601String(),
    "categoryId": categoryId,
    "typeId": typeId,
    "contactNo": contactNo,
    "emergencyNo": emergencyNo,
    "email": email,
    "address": address,
    "pinCode": pinCode,
    "area": area,
    "bloodGroup": bloodGroup,
    "description": description,
    "note": note,
    "details": details,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
