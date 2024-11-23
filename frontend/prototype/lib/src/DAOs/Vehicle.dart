import 'dart:convert';

import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {

  int id;
  String VehicleName = "";
  String LicensePlate = "";
  int imei;
  String CompanyCVR = "";
  String OrgName = "";
  int LastTechnicanSearch = -1;

  Vehicle({
    required this.id,
    required this.imei,
  });


  @override
  List<Object> get props => [id, imei];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imei': imei
    };
  }


  factory Vehicle.fromMap(Map<String, dynamic> map){
    return Vehicle(
    id: map['id'] as int,
    imei: map['imei'] as int,
    );
  }


  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) => Vehicle.fromMap(json.decode(source) as Map<String, dynamic>);

}