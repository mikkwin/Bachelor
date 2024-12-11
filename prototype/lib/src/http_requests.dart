import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prototype/src/DAOs/Vehicle.dart';
import 'package:prototype/src/DAOs/VehicleInfo.dart';
import 'package:prototype/src/DAOs/VehicleSettings.dart';
import 'package:prototype/src/DAOs/enums/ErrorCode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DAOs/VehicleReadings.dart';
import 'DAOs/enums/VehicleStatus.dart';


Future<void> saveData(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String?> getData(String key) async {
final prefs = await SharedPreferences.getInstance();
return prefs.getString(key);
}


Future<List<Vehicle>> getDevices(int offset, int amount, int filter, String token, String query) async {
  String url;
  print(query);
  if (query.isEmpty) {
    url = "https://140.82.33.21:5001/Data/VehicleSearch?query=default&filter=$filter&currentToken=$token&offset=$offset&amount=$amount";
  }
  else {
    url = "https://140.82.33.21:5001/Data/VehicleSearch?query=$query&filter=$filter&currentToken=$token&offset=$offset&amount=$amount";
  }



  print(url);

  final response = await http.get(Uri.parse(url));

  print(response.body);

  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    List<Vehicle> vehicles = List<Vehicle>.from(l.map((model) => Vehicle.fromMap(model)));

    return vehicles;
  }
  else {
    throw Exception('Failed to load vehicles.');
  }
}

Future<Vehicle> getDevice(String imei, String token) async {
  final response = await http.get(Uri.parse("https://140.82.33.21:5001/Data/getVehicle?imei=$imei&currentToken=$token"));

  if (response.statusCode == 200) {
    var vehicle = Vehicle.fromJson(response.body);
    return vehicle;
  }
  else if (response.statusCode > 200 && response.statusCode < 300) {
    Vehicle vehicle = Vehicle(id: 0, imei: "12345678901345");
    vehicle.OrgName = "Fejl fundet. Please gå tilbage og prøv igen.";
    return vehicle;
  }
  else {
    throw Exception('Failed to load vehicle.');
  }
}


Future<VehicleSettings> fetchSettings(String imei, String currentToken) async {
  String url =
      "https://140.82.33.21:5001/Settings/GetSettings?IMEI=$imei&currentToken=$currentToken";

  try {
    String? cached = await getData("VehicleSettingsResponseJson");

    if (cached != null && cached.isNotEmpty) {
     final Map<String, dynamic> jsonData = json.decode(cached);
      VehicleSettings setting = VehicleSettings.fromJson(jsonData);
     return setting;
    } else {
      final response = await http.get(Uri.parse(url));
       if (response.statusCode == 200) {
        await saveData("VehicleSettingsResponseJson", response.body);
        final Map<String, dynamic> jsonData = json.decode(response.body);
        VehicleSettings setting = VehicleSettings.fromJson(jsonData);

        return setting;
        } else {
        throw Exception("SETTINGS_FEJL");
      }
    }
  } catch (e) {
    print(e);
    throw Exception("Error: $e");
  }
}


Future<VehicleInfo> fetchData(String imei, String currentToken) async {
  String url = "https://140.82.33.21:5001/Data/GetVehicle?IMEI=$imei&currentToken=$currentToken";

  print(url);

  try {
    String? cached = await getData("VehicleReadingsResponseJson");

    final String rawData;

    if (cached != null) {
      rawData = cached;
    } else {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        rawData = response.body;
        await saveData("VehicleReadingsResponseJson", rawData);
      } else {
        throw Exception("DATA_FEJL");
      }
    }

    // Parse JSON response
    final decoded = json.decode(rawData);

    // Extract errors and readings
    final errors = decoded['errors'] as List<dynamic>? ?? [];
    final readings = decoded['readings'] as List<dynamic>? ?? [];

    // Map errors to ErrorCode enums
    List<ErrorCode> tempErr = [];
    try {
      tempErr = errors
          .whereType<int>() // Ensure each element is an integer
          .map((element) => ErrorCodeExtension.fromValue(element))
          .toList();
    } catch (e) {
      print("Error mapping Errors to ErrorCode: $e");
    }

    // Map readings to VehicleReadings objects
    List<VehicleReadings> tempRead = readings.map((reading) {
      return VehicleReadings(
        id: reading['id'] ?? 0,
        timestamp: reading['timestamp'] != null
            ? DateTime.parse(reading['timestamp'])
            : DateTime.now(),
        cumulativePower: (reading['cumulativePower'] as num?)?.toDouble() ?? 0.0,
        fullCharges: reading['fullCharges'] ?? 0,
        hardwareVersion: (reading['hardwareVersion'] as num?)?.toDouble() ?? 0.0,
        maxVolt: (reading['maxVolt'] as num?)?.toDouble() ?? 0.0,
        operationalTime: (reading['operationalTime'] as num?)?.toDouble() ?? 0.0,
        overDischarges: (reading['overDischarges'] as num?)?.toDouble() ?? 0.0,
        state: reading['state'] == true ? VehicleStatus.active : VehicleStatus.inactive,
        softwareVersion: (reading['softwareVersion'] as num?)?.toDouble() ?? 0.0,
        panelCurrent: (reading['panelCurrent'] as num?)?.toDouble() ?? 0.0,
        panelVoltage: (reading['panelVoltage'] as num?)?.toDouble() ?? 0.0,
      );
    }).toList();

    // Construct VehicleInfo object with safe parsing for numeric fields
    VehicleInfo info = VehicleInfo(
      id: decoded['id'] ?? 0,
      imei: decoded['imei'] ?? '',
      Errors: tempErr,
      Readings: tempRead,
    );

    return info;

  } catch (e) {
    print(e);
    throw Exception("Error: $e");
  }
}

// Helper method to safely parse a double
double _parseDouble(dynamic value) {
  if (value is num) {
    return value.toDouble(); // If it's already a number, convert it to double
  }
  return 0.0; // Return a default value of 0.0 if the value is not a valid number
}
