// To parse this JSON data, do
//
//     final memberdetails = memberdetailsFromJson(jsonString);

import 'dart:convert';

Memberdetails memberdetailsFromJson(String str) => Memberdetails.fromJson(json.decode(str));

String memberdetailsToJson(Memberdetails data) => json.encode(data.toJson());

class Memberdetails {
  Memberdetails({
    required this.message,
    required this.memberUserDetail,
  });

  String message;
  MemberUserDetail memberUserDetail;

  factory Memberdetails.fromJson(Map<String, dynamic> json) => Memberdetails(
    message: json["message"],
    memberUserDetail: MemberUserDetail.fromJson(json["MemberUserDetail"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "MemberUserDetail": memberUserDetail.toJson(),
  };
}

class MemberUserDetail {
  MemberUserDetail({
    required this.id,
    required this.organizerId,
    required this.memberId,
    required this.relationId,
    required this.name,
    required this.mobileNo,
    required this.description,
    required this.note,
    required this.details,
    required this.isVerified,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String organizerId;
  String memberId;
  String relationId;
  String name;
  String mobileNo;
  String description;
  String note;
  String details;
  bool isVerified;
  bool isActive;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory MemberUserDetail.fromJson(Map<String, dynamic> json) => MemberUserDetail(
    id: json["_id"],
    organizerId: json["organizerId"],
    memberId: json["memberId"],
    relationId: json["relationId"],
    name: json["name"],
    mobileNo: json["mobileNo"],
    description: json["description"],
    note: json["note"],
    details: json["details"],
    isVerified: json["isVerified"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "organizerId": organizerId,
    "memberId": memberId,
    "relationId": relationId,
    "name": name,
    "mobileNo": mobileNo,
    "description": description,
    "note": note,
    "details": details,
    "isVerified": isVerified,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
