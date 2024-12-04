import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototype/src/DAOs/Vehicle.dart';
import 'package:prototype/src/DAOs/VehicleInfo.dart';
import 'package:prototype/src/DAOs/enums/ErrorCode.dart';
import 'package:prototype/src/device_settings/settings_view.dart';
import 'package:prototype/src/http_requests.dart';
import 'package:prototype/src/post_mortem/post_mortem.dart';
import 'package:prototype/src/Data/DataPage.dart';
import 'package:prototype/src/DAOs/VehicleSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../DAOs/VehicleReadings.dart';
import '../DAOs/enums/VehicleStatus.dart';

class UnitPageView extends StatefulWidget {
  final String deviceImei;
  final String token;

  const UnitPageView(
      {super.key, required this.token, required this.deviceImei});
  static const routeName = '/unit_page';
  

  @override
  createState() => _UnitPageViewState();
}

class _UnitPageViewState extends State<UnitPageView> {
  Vehicle _vehicle = Vehicle(id: 1, imei: 12345678901245);
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }



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
      final String url = "https://140.82.33.21:5001/Data/getVehicle?imei=${_vehicle.imei}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String? cached = await getData("VehicleErrorsResponseJson");
        print("1");
        await saveData("VehicleErrorsResponseJson", response.body);
        print("2");
        if(cached == null){
          print("2.1");
          final decoded = json.decode(response.body);
          final errors = decoded['Errors'] as List;
          if (decoded != null) {
            print("2.2");
            List<ErrorCode> temp = [];

            errors.forEach((error) {
              print(error.toString());
              print(error);
              temp.add(error);
            });
          }
        }

        if(cached != null){
          print("3.1");
          final decoded = json.decode(cached);
          final errors = decoded['Errors'] as List;
          if (decoded != null) {
            List<ErrorCode> temp = [];
            print("3.2");
            errors.forEach((error) {
              print(error.toString());
              print(error);
              temp.add(error);
            });
          }
        }
        print("4");
        return json.decode(response.body);


      } else {
        throw Exception("PAGE_FEJL");
      }
    } catch (e) {
      print(e);
      throw Exception("Error: $e");
    }
  }

  Future<void> _fetchInitialData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _vehicle = await getDevice(widget.deviceImei, widget.token);
    } catch (e) {
      throw Exception("Error fetching device: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final VehicleSettings VeToSend = VehicleSettings(serialId: 12345, imei: "123456789123456", s010a: 1, e003:2, e004: 3, e005: 4, e006: 5, e007: 6, e008: 7, e009: 8, e00a: 9, e00b: 10, e00c: 11, e00d: 12, e00e: 13, e010: 14, e011: 15, e012: 16, e013: 17, e014: 18);

    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          var vehicleInfo = snapshot.data!['errors'][0];

      print(vehicleInfo);
    }

    return ListView();
                      },
                    )
    ),

                    Row(children: [
                      Container(
                        height: screenWidth * 0.08,
                        width: screenWidth * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.01),
                            child:
                                Center(child: Text("IMEI: ${_vehicle.imei}"))),
                      ),
                      const Expanded(child: SizedBox()),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                         settingsView(vehicleSettings: VeToSend, token: widget.token)));
                          },
                          child: const Icon(Icons.settings))
                    ]),
                    Container(
                      height: screenWidth * 0.08,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.01),
                          child: Center(
                              child: Text("Firma: ${_vehicle.OrgName}"))),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Row(children: [
                      Icon(
                        Icons.crisis_alert_rounded,
                        size: 80,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            "Fejl: ",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid),
                          ),
                        ],
                      )
                    ]),
                    const SizedBox(height: 20),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenWidth * 0.02),
                        child: const Text(
                            "Ingen fejl diagnosticeret i automat diagnosticering."),
                      ),
                    )),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PostMortem()));
                            },
                            child: const Text("Skades Rapport")),
                        const Expanded(child: SizedBox()),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DataPage()));
                            },
                            child: const Text("Data"))
                      ],
                    ),
                    SizedBox(
                      height: screenWidth * 0.15,
                    )
                  ],
                ))));
  }
}
