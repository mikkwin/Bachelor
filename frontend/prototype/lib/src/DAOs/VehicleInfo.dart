import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:prototype/src/DAOs/enums/ErrorCode.dart';

import 'VehicleReadings.dart';

class VehicleInfo extends Equatable {

  int id;
  String imei;
  String ProductType = "";
  double LatCords = 0.0;
  double LonCords = 0.0;
  List<ErrorCode> Errors;
  List<VehicleReadings> Readings;



  VehicleInfo({
    required this.id,
    required this.imei,
    required this.Errors,
    required this.Readings
  });


  @override
  List<Object> get props => [id, imei];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imei': imei
    };
  }


  factory VehicleInfo.fromMap(Map<String, dynamic> map){
    return VehicleInfo(
      id: map['id'] as int,
      imei: map['imei'] as String,
      Errors: map['errors'] as List<ErrorCode>,
      Readings: map['readings'] as List<VehicleReadings>
    );
  }


  String toJson() => json.encode(toMap());

  factory VehicleInfo.fromJson(String source) => VehicleInfo.fromMap(json.decode(source) as Map<String, dynamic>);

}