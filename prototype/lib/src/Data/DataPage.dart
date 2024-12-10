import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prototype/src/DAOs/VehicleReadings.dart';
import 'package:prototype/src/DAOs/enums/VehicleStatus.dart';
import 'package:prototype/src/Data/Graph.dart';
import 'package:prototype/src/Data/data_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class DataPage extends StatefulWidget {

  final String deviceImei;
  final String token;

  const DataPage(
      {super.key, required this.token, required this.deviceImei});
  static const routeName = '/data_page';


@override
createState() => _DataPageViewState();

}



class _DataPageViewState extends State<DataPage> {
  final GlobalKey<LineChartWidgetState> chartKey = GlobalKey<LineChartWidgetState>();


  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<Map<String, dynamic>> fetchData() async {

    String url = "https://140.82.33.21:5001/Data/GetVehicle?IMEI=${widget.deviceImei}&currentToken=${widget.token}";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await saveData("VehicleReadingsResponseJson", response.body);
        String? cached = await getData("VehicleReadingsResponseJson");

        if(cached != null){
        final decoded = json.decode(cached);
        final readings = decoded['readings'] as List;
        if (decoded != null) {
          List<VehicleReadings> temp = [];

          readings.forEach((reading) {
            print("Timestamp: ${reading['timestamp']}");
            print("Panel Voltage: ${reading['panelVoltage']}");
            print("Panel Current: ${reading['panelCurrent']}");

            readings.forEach((reading) {
              var x = VehicleReadings(
                id: reading['id'] ?? 0,
                // Default to 0 if null
                timestamp: reading['timestamp'] != null
                    ? DateTime.parse(reading['timestamp'])
                    : DateTime.now(),
                // Default to current time if null
                cumulativePower: (reading['cumulativePower'] as num?)
                    ?.toDouble() ?? 0.0,
                // Default to 0.0 if null
                fullCharges: reading['fullCharges'] ?? 0,
                // Default to 0 if null
                hardwareVersion: (reading['hardwareVersion'] as num?)
                    ?.toDouble() ?? 0.0,
                // Default to 0.0 if null
                maxVolt: (reading['maxVolt'] as num?)?.toDouble() ?? 0.0,
                // Default to 0.0 if null
                operationalTime: (reading['operationalTime'] as num?)
                    ?.toDouble() ?? 0.0,
                // Default to 0.0 if null
                overDischarges: (reading['overDischarges'] as num?)
                    ?.toDouble() ?? 0.0,
                // Default to 0.0 if null
                state: reading['state'] != null
                    ? VehicleStatus.active
                    : VehicleStatus.inactive,
                // Default to a fallback state
                softwareVersion: (reading['softwareVersion'] as num?)
                    ?.toDouble() ?? 0.0,
                // Default to 0.0 if null
                panelCurrent: (reading['panelCurrent'] as num?)?.toDouble() ??
                    0.0,
                // Default to 0.0 if null
                panelVoltage: (reading['panelVoltage'] as num?)?.toDouble() ??
                    0.0, // Default to 0.0 if null
              );

              temp.add(x);
            });
            // Add other logic here
          });


          chartKey.currentState?.addReadings(temp, 0); // Add readings to the graph

        }
        }
        return json.decode(response.body);
      } else {
        throw Exception("DATA_FEJL");
      }
    } catch (e) {
      print(e);
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

      // Format the timestamp
      String timestamp = firstReading['timestamp'] != null
          ? DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(firstReading['timestamp']))
          : 'N/A';

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
            title: Text("Panel Amp: ${(panelCurrent ?? 0.0).toStringAsFixed(3)}"),
          ),
          
          ListTile(
            leading: const Icon(Icons.flash_on),
            title: Text("Panel Volt: $panelVoltage"),
          ),
        ],
      );
    }
  },
)


          ),
          Expanded(
            child: LineChartWidget(key: chartKey), // Graph widget
          ),
        ],
      ),
    );
  }
}
