import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:prototype/src/DAOs/enums/error_code.dart';

import 'vehicle_readings.dart';

class VehicleInfo extends Equatable {
  int id;
  String imei;
  String productType = "";
  double latCords = 0.0;
  double lonCords = 0.0;
  List<ErrorCode> errors;
  List<VehicleReadings> readings;

  VehicleInfo(
      {required this.id,
      required this.imei,
      required this.errors,
      required this.readings});

  @override
  List<Object> get props => [id, imei];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'imei': imei};
  }

  factory VehicleInfo.fromMap(Map<String, dynamic> map) {
    return VehicleInfo(
        id: map['id'] as int,
        imei: map['imei'] as String,
        errors: map['errors'] as List<ErrorCode>,
        readings: map['readings'] as List<VehicleReadings>);
  }

  String toJson() => json.encode(toMap());

  factory VehicleInfo.fromJson(String source) =>
      VehicleInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
