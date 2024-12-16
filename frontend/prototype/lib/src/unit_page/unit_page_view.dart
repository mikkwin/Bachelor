import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype/src/DAOs/vehicle.dart';
import 'package:prototype/src/DAOs/vehicle_readings.dart';
import 'package:prototype/src/DAOs/vehicle_settings.dart';
import 'package:prototype/src/DAOs/enums/vehicle_status.dart';
import 'package:prototype/src/Data/data_page.dart';
import 'package:prototype/src/device_settings/settings_view.dart';
import 'package:prototype/src/http_requests.dart';
import 'package:prototype/src/post_mortem/post_mortem.dart';
import 'package:prototype/src/unit_page/unit_page_button.dart';
import 'package:prototype/src/unit_page/unit_page_info_panel.dart';
import 'package:prototype/src/DAOs/vehicle_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late Vehicle _vehicle = Vehicle(id: 1, imei: "12345678901245");
  VehicleSettings? _settings;
  bool _isLoading = false;
  late VehicleReadings _readings = VehicleReadings(
      id: 0,
      timestamp: DateTime.now(),
      cumulativePower: 0,
      fullCharges: 0,
      hardwareVersion: 0,
      maxVolt: 0,
      operationalTime: 0,
      overDischarges: 0,
      state: VehicleStatus.inactive,
      softwareVersion: 0,
      panelCurrent: 0,
      panelVoltage: 0);

  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  void initState() {
    _fetchInitialData();
    super.initState();
  }

  Future<void> _fetchInitialData() async {
    setState(() {
      _isLoading = true;
    });

    Vehicle deviceResponse;
    VehicleSettings settingsResponse;
    VehicleInfo infoResponse;

    try {
      deviceResponse = await getDevice(widget.deviceImei, widget.token);
      settingsResponse = await fetchSettings(widget.deviceImei, widget.token);
      infoResponse = await fetchData(widget.deviceImei, widget.token);
      setState(() {
        _isLoading = false;
        try {
          _readings = infoResponse.readings[0];
          _vehicle = deviceResponse;
          _settings = settingsResponse;
        } on (RangeError, TypeError) {
          _vehicle = deviceResponse;
          _settings = settingsResponse;
        }
      });
    } on RangeError {
      deviceResponse = await getDevice(widget.deviceImei, widget.token);
      settingsResponse = await fetchSettings(widget.deviceImei, widget.token);
      setState(() {
        _isLoading = false;
        try {
          _vehicle = deviceResponse;
          _settings = settingsResponse;
        } catch (e) {
          throw Exception(e);
        }
      });
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  void _openTextDialog(
      String title, void Function(String) onTextSubmitted) async {
    String dialogText = "";
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: TextEditingController(text: dialogText),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your text here...'),
            onChanged: (value) {
              dialogText = value;
            },
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context, dialogText);
                  onTextSubmitted(dialogText);
                },
                child: const Text("OK"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Device Page')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Device Page'),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "IMEI: ${_vehicle.imei}",
                        style: const TextStyle(fontSize: 20),
                      )),
                  InfoPanel(
                      info: "Firm",
                      infoText: _vehicle.orgName,
                      onButtonPress: () {
                        _openTextDialog(
                            "Firm",
                            (value) => setState(() {
                                  _vehicle.orgName = value;
                                }));
                      }),
                  InfoPanel(
                      info: "Make",
                      infoText: _vehicle.make,
                      onButtonPress: () {
                        _openTextDialog(
                            "Make",
                            (value) => setState(() {
                                  _vehicle.make = value;
                                }));
                      }),
                  InfoPanel(
                      info: "Model",
                      infoText: _vehicle.model,
                      onButtonPress: () {
                        _openTextDialog(
                            "Model",
                            (value) => setState(() {
                                  _vehicle.model = value;
                                }));
                      }),
                  InfoPanel(
                      info: "Year",
                      infoText: _vehicle.year,
                      onButtonPress: () {
                        _openTextDialog(
                            "Year",
                            (value) => setState(() {
                                  _vehicle.year = value;
                                }));
                      }),
                  InfoPanel(
                      info: "Nick",
                      infoText: _vehicle.vehicleName,
                      onButtonPress: () {
                        _openTextDialog(
                            "Nickname",
                            (value) => setState(() {
                                  _vehicle.vehicleName = value;
                                }));
                      }),
                  const Expanded(child: SizedBox()),
                  DataLoadingButton(
                      buttonName: "Data",
                      textStyle: const TextStyle(fontSize: 24),
                      enablePreview: _readings.id != 0,
                      data: _readings
                          .toMap()
                          .entries
                          .where((e) => e.key != "imei" && e.key != "id")
                          .map((e) {
                        if (e.key == "timestamp") {
                          return "${e.key}: ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(e.value))}";
                        } else if (e.value is double || e.value is num) {
                          return "${e.key}: ${(e.value as num).toStringAsFixed(2)}";
                        }
                        return "${e.key}: ${e.value}";
                      }).toList(),
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DataPage(
                                    token: widget.token,
                                    deviceImei: widget.deviceImei)));
                      }),
                  DataLoadingButton(
                      buttonName: "Settings",
                      textStyle: const TextStyle(fontSize: 24),
                      data: _settings!
                          .toMap()
                          .entries
                          .where((e) => e.key != "imei" && e.key != "serialId")
                          .map((e) => "${e.key}: ${e.value}")
                          .toList(),
                      enablePreview: _settings?.serialId != 0,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SettingsView(vehicleSettings: _settings!)));
                      }),
                  DataLoadingButton(
                      buttonName: "Rapport",
                      textStyle: const TextStyle(fontSize: 24),
                      enablePreview: false,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PostMortem(token: widget.token)));
                      }),
                ],
              )),
        ));
  }
}
