// To parse this JSON data, do
//
//     final addDayoff = addDayoffFromJson(jsonString);

import 'dart:convert';

AddDayoff addDayoffFromJson(String str) => AddDayoff.fromJson(json.decode(str));

String addDayoffToJson(AddDayoff data) => json.encode(data.toJson());

class AddDayoff {
  AddDayoff({
    required this.message,
  });

  String message;

  factory AddDayoff.fromJson(Map<String, dynamic> json) => AddDayoff(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
