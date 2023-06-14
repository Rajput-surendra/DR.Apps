// To parse this JSON data, do
//
//     final cencelbookingModel = cencelbookingModelFromJson(jsonString);

import 'dart:convert';

CencelbookingModel cencelbookingModelFromJson(String str) => CencelbookingModel.fromJson(json.decode(str));

String cencelbookingModelToJson(CencelbookingModel data) => json.encode(data.toJson());

class CencelbookingModel {
  bool error;
  String message;

  CencelbookingModel({
    required this.error,
    required this.message,
  });

  factory CencelbookingModel.fromJson(Map<String, dynamic> json) => CencelbookingModel(
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}
