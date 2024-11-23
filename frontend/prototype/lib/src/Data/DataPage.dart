import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prototype/src/DAOs/VehicleReadings.dart';
import 'package:prototype/src/Data/Graph.dart';
import 'package:prototype/src/Data/data_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final GlobalKey<LineChartWidgetState> chartKey = GlobalKey<LineChartWidgetState>();
  final String url = "https://localhost:5001/Data/GetVehicle?IMEI=8945222";

  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await saveData("VehicleReadingsResponseJson", response.body);
        String? cached = await getData("VehicleReadingsResponseJson");
        if (cached != null) {
          var snap = json.decode(cached);
          if (snap['readings'] != null) {
            List<dynamic> readingsJson = snap['readings'];
            print(readingsJson);
            List<VehicleReadings> parsedReadings = readingsJson.map((reading) {
              return VehicleReadings.fromMap(reading as Map<String, dynamic>);
            }).toList();

            chartKey.currentState?.addReadings(parsedReadings); // Add readings to the graph
          }
        }
        return json.decode(response.body);
      } else {
        throw Exception("DATA_FEJL");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graph and Data Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: LineChartWidget(key: chartKey), // Graph widget
          ),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!['readings'].isEmpty) {
                  return const Center(child: Text('No data available.'));
                } else {
                  var firstReading = snapshot.data!['readings'][0];

                  String timestamp = firstReading['timestamp'] ?? 'N/A';
                  int overdischarges = firstReading['overdischarges'] ?? 0;
                  double panelCurrent = firstReading['panelCurrent']?.toDouble() ?? 0.0;
                  double panelVoltage = firstReading['panelVoltage']?.toDouble() ?? 0.0;

                  return ListView(
                    padding: const EdgeInsets.all(20),
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.battery_5_bar),
                        title: Text("Sidste data: $timestamp"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.warning_amber_outlined),
                        title: Text("Overdischarges: $overdischarges"),
                      ),
                      const ListTile(
                        leading: Icon(Icons.battery_full),
                        title: Text("Batteri Amp: 100"),
                      ),
                      const ListTile(
                        leading: Icon(Icons.battery_charging_full),
                        title: Text("Batteri Volt: 100"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.solar_power),
                        title: Text("Panel Amp: $panelCurrent"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.flash_on),
                        title: Text("Panel Volt: $panelVoltage"),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
