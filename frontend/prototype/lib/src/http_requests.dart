import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prototype/src/DAOs/Vehicle.dart';
import 'package:prototype/src/DAOs/VehicleReadings.dart';
import 'package:prototype/src/DAOs/VehicleSettings.dart';

Future<List<Vehicle>> getDevices(int offset, int amount, int filter, String token, String query) async {
  String url;
  if (query.isEmpty) {
    url = "https://140.82.33.21:5001/Data/VehicleSearch?query=default&filter=$filter&currentToken=$token&offset=$offset&amount=$amount";
  }
  else {
    url = "https://140.82.33.21:5001/Data/VehicleSearch?query=$query&filter=$filter&currentToken=$token&offset=$offset&amount=$amount";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    List<Vehicle> vehicles = List<Vehicle>.from(l.map((model) => Vehicle.fromMap(model)));

    return vehicles;
  }
  else {
    throw Exception('Failed to load vehicles.');
  }
}

Future<VehicleSettings> getSettings(String imei, String token) async {
  final response = await http.get(Uri.parse("https://140.82.33.21:5001/Settings/getSettings?imei=$imei&currentToken=$token"));
  var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
  if (response.statusCode == 200) {
    print(jsonResponse);
    var settings = VehicleSettings.fromMap(jsonResponse);


    return settings;
  }
  else {
    throw Exception('Failed to load settings.');
  }
}

Future<Map<String,dynamic>> getDevice(String imei, String token) async {
  final response = await http.get(Uri.parse("https://140.82.33.21:5001/Data/getVehicle?imei=$imei&currentToken=$token"));
  var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
  if (response.statusCode == 200) {

    var vehicle = Vehicle.fromMap(jsonResponse);

    var readings;

    try {
      readings = VehicleReadings.fromMap(jsonResponse['readings'][0]);
    } catch (e) {
      readings = {};
    }

    return {"vehicle": vehicle, "readings": readings, "settings": {}};
  }
  else if (response.statusCode > 200 && response.statusCode < 300) {
    Vehicle vehicle = Vehicle(id: 0, imei: "12345678901345");
    vehicle.OrgName = "Fejl fundet. Please gå tilbage og prøv igen.";
    return {"vehicle": vehicle};
  }
  else {
    throw Exception('Failed to load vehicle.');
  }
}