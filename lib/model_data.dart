// To parse this JSON data, do
//
//     final modelData = modelDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ModelData {
  ModelData({
    required this.id,
    required this.data,
    required this.time,
    required this.modelDataFinal,
  });

  final int id;
  final String data;
  final String time;
  final bool modelDataFinal;

  factory ModelData.fromRawJson(String str) => ModelData.fromJson(jsonDecode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelData.fromJson(Map<String, dynamic> json) => ModelData(
    id: json["id"],
    data: json["data"],
    time: json["time"],
    modelDataFinal: json["final"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "data": data,
    "time": time,
    "final": modelDataFinal,
  };
}
