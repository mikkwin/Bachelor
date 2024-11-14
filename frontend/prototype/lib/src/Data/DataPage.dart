import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataPage extends StatefulWidget {
  @override
  _dataPageState createState() => _dataPageState();
}

class _dataPageState extends State<DataPage> {
  final String url = "https://localhost:5001/Data/getVehicle?IMEI=8945222";

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!['readings'].isEmpty) {
              return Text('No data available.');
            } else {
              var firstReading = snapshot.data!['readings'][0];

              String timestamp = firstReading['timestamp'] ?? 'N/A';
              int overdischarges = firstReading['overdischarges'] ?? 0;
              double panelCurrent = firstReading['panelCurrent']?.toDouble() ?? 0.0;
              double panelVoltage = firstReading['panelVoltage']?.toDouble() ?? 0.0;

              return ListView(
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.battery_5_bar),
                    title: Text("Sidste data: $timestamp"),
                  ),
                  ListTile(
                    leading: Icon(Icons.warning_amber_outlined),
                    title: Text("Overdischarges: $overdischarges"),
                  ),
                  ListTile(
                    leading: Icon(Icons.battery_full),
                    title: Text("Batteri Amp: 100"),
                  ),
                  ListTile(
                    leading: Icon(Icons.battery_charging_full),
                    title: Text("Batteri Volt: 100"),
                  ),
                  ListTile(
                    leading: Icon(Icons.solar_power),
                    title: Text("Panel Amp: $panelCurrent"),
                  ),
                  ListTile(
                    leading: Icon(Icons.flash_on),
                    title: Text("Panel Volt: $panelVoltage"),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}