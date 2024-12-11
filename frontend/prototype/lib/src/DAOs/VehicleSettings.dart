import 'dart:convert';


class VehicleSettings {
  int serialId;
  String imei;
  double s010a;
  double e003;
  double e004;
  double e005;
  double e006;
  double e007;
  double e008;
  double e009;
  double e00a;
  double e00b;
  double e00c;
  double e00d;
  double e00e;
  double e010;
  double e011;
  double e012;
  double e013;
  double e014;

  VehicleSettings({
    required this.serialId,
    required this.imei,
    required this.s010a,
    required this.e003,
    required this.e004,
    required this.e005,
    required this.e006,
    required this.e007,
    required this.e008,
    required this.e009,
    required this.e00a,
    required this.e00b,
    required this.e00c,
    required this.e00d,
    required this.e00e,
    required this.e010,
    required this.e011,
    required this.e012,
    required this.e013,
    required this.e014,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'serialId': serialId,
      'imei': imei,
      's010a': s010a,
      'e003': e003,
      'e004': e004,
      'e005': e005,
      'e006': e006,
      'e007': e007,
      'e008': e008,
      'e009': e009,
      'e00a': e00a,
      'e00b': e00b,
      'e00c': e00c,
      'e00d': e00d,
      'e00e': e00e,
      'e010': e010,
      'e011': e011,
      'e012': e012,
      'e013': e013,
      'e014': e014,
    };
  }

  // Factory constructor to create a VehicleSetting object from a map
  factory VehicleSettings.fromMap(Map<String, dynamic> map) {
    return VehicleSettings(
      serialId: map['serialId'],
      imei: map['imei'],
      s010a: double.parse("${map["s010a"]}"),
      e003: double.parse("${map["e003"]}"),
      e004: double.parse("${map["e004"]}"),
      e005: double.parse("${map["e005"]}"),
      e006: double.parse("${map["e006"]}"),
      e007: double.parse("${map["e007"]}"),
      e008: double.parse("${map["e008"]}"),
      e009: double.parse("${map["e009"]}"),
      e00a: double.parse("${map["e00a"]}"),
      e00b: double.parse("${map["e00b"]}"),
      e00c: double.parse("${map["e00c"]}"),
      e00d: double.parse("${map["e00d"]}"),
      e00e: double.parse("${map["e00e"]}"),
      e010: double.parse("${map["e010"]}"),
      e011: double.parse("${map["e011"]}"),
      e012: double.parse("${map["e012"]}"),
      e013: double.parse("${map["e013"]}"),
      e014: double.parse("${map["e014"]}"),
    );
  }

  // Method to convert object to JSON string (for API usage)
  String toJson() => json.encode(toMap());

  // Factory constructor to create object from JSON string
  factory VehicleSettings.fromJson(String source) =>
      VehicleSettings.fromMap(json.decode(source));
}
