import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:prototype/src/DAOs/enums/ErrorCode.dart';
import 'package:prototype/src/DAOs/enums/VehicleStatus.dart';

class VehicleReadings extends Equatable {

  int id;
  DateTime timestamp;
  double cumulativePower;
  int fullCharges;
  double hardwareVersion;
  double maxVolt;
  double operationalTime;
  double overDischarges;
  VehicleStatus state;
  double softwareVersion;
  double panelCurrent;
  double panelVoltage;

  VehicleReadings({
    required this.id,
    required this.timestamp,
    required this.cumulativePower,
    required this.fullCharges,
    required this.hardwareVersion,
    required this.maxVolt,
    required this.operationalTime,
    required this.overDischarges,
    required this.state,
    required this.softwareVersion,
    required this.panelCurrent,
    required this.panelVoltage,
  });

  @override
  List<Object> get props => [
    id,
    timestamp,
    cumulativePower,
    fullCharges,
    hardwareVersion,
    maxVolt,
    operationalTime,
    overDischarges,
    state,
    softwareVersion,
    panelCurrent,
    panelVoltage,
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'cumulativePower': cumulativePower,
      'fullCharges': fullCharges,
      'hardwareVersion': hardwareVersion,
      'maxVolt': maxVolt,
      'operationalTime': operationalTime,
      'overDischarges': overDischarges,
      'state': state.value,
      'softwareVersion': softwareVersion,
      'panelCurrent': panelCurrent,
      'panelVoltage': panelVoltage,
    };
  }

  factory VehicleReadings.fromMap(Map<String, dynamic> map) {

    return VehicleReadings(
      id: map['id'] as int,
      timestamp: DateTime.parse(map['timestamp']),
      cumulativePower: map['cumulativePower'] as double,
      fullCharges: map['fullcharges'] as int,
      hardwareVersion: map['hardwareVersion'] as double,
      maxVolt: double.parse("${map['maxVolt']}"),
      operationalTime: double.parse("${map['operationalTime']}"),
      overDischarges: double.parse("${map['overdischarges']}"),
      state: VehicleStatusExtension.fromValue(map['state'] as int),
      softwareVersion: map['softwareVersion'] as double,
      panelCurrent: map['panelCurrent'] as double,
      panelVoltage: double.parse("${map['panelVoltage']}"),
    );
  }


  String toJson() => json.encode(toMap());

  factory VehicleReadings.fromJson(String source) => VehicleReadings.fromMap(json.decode(source) as Map<String, dynamic>);

}