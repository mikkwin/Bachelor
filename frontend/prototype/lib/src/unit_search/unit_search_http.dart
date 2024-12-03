import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prototype/src/DAOs/Vehicle.dart';

Future<List<Vehicle>> getDevices(int offset, int amount, int filter, String token, String query) async {
  final response = await http.get(Uri.parse("https://140.82.33.21:5001/VehicleSearch?query=$query&filter=$filter&currentToken=$token&offset=$offset&amount=$amount"));

  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    List<Vehicle> vehicles = List<Vehicle>.from(l.map((model) => Vehicle.fromJson(model)));

    return vehicles;
  }
  else {
    throw Exception('Failed to load vehicle.');
  }
}

