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
  factory VehicleSettings.fromJson(Map<String, dynamic> jsonData) {
    return VehicleSettings(
      serialId: jsonData['serialId'] as int,
      imei: jsonData['imei'] as String,
      s010a: (jsonData['s010a'] as num).toDouble(),
      e003: (jsonData['e003'] as num).toDouble(),
      e004: (jsonData['e004'] as num).toDouble(),
      e005: (jsonData['e005'] as num).toDouble(),
      e006: (jsonData['e006'] as num).toDouble(),
      e007: (jsonData['e007'] as num).toDouble(),
      e008: (jsonData['e008'] as num).toDouble(),
      e009: (jsonData['e009'] as num).toDouble(),
      e00a: (jsonData['e00a'] as num).toDouble(),
      e00b: (jsonData['e00b'] as num).toDouble(),
      e00c: (jsonData['e00c'] as num).toDouble(),
      e00d: (jsonData['e00d'] as num).toDouble(),
      e00e: (jsonData['e00e'] as num).toDouble(),
      e010: (jsonData['e010'] as num).toDouble(),
      e011: (jsonData['e011'] as num).toDouble(),
      e012: (jsonData['e012'] as num).toDouble(),
      e013: (jsonData['e013'] as num).toDouble(),
      e014: (jsonData['e014'] as num).toDouble(),
    );
  }
}
