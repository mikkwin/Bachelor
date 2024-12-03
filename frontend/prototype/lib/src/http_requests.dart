import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prototype/src/DAOs/Vehicle.dart';

Future<List<Vehicle>> getDevices(int offset, int amount, int filter, String token, String query) async {
  String url;
  if (query.isEmpty) {
    url = "https://140.82.33.21:5001/Data/VehicleSearch?query=1234&filter=$filter&currentToken=$token&offset=$offset&amount=$amount";
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

Future<Vehicle> getDevice(String imei, String token) async {
  final response = await http.get(Uri.parse("https://140.82.33.21:5001/Data/getVehicle?imei=$imei&currentToken=$token"));

  if (response.statusCode == 200) {
    return Vehicle.fromJson(response.body);
  }
  else if (response.statusCode > 200 && response.statusCode < 300) {
    Vehicle vehicle = Vehicle(id: 0, imei: 12345678901345);
    vehicle.OrgName = "Fejl fundet. Please gå tilbage og prøv igen.";
    return vehicle;
  }
  else {
    throw Exception('Failed to load vehicle.');
  }
}