import 'package:flutter/material.dart';
import 'package:prototype/src/DAOs/Vehicle.dart';
import 'package:prototype/src/DAOs/VehicleReadings.dart';
import 'package:prototype/src/DAOs/VehicleSettings.dart';
import 'package:prototype/src/DAOs/enums/VehicleStatus.dart';
import 'package:prototype/src/Data/DataPage.dart';
import 'package:prototype/src/device_settings/settings_view.dart';
import 'package:prototype/src/http_requests.dart';
import 'package:prototype/src/unit_page/unit_page_button.dart';
import 'package:prototype/src/unit_page/unit_page_info_panel.dart';

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
  Vehicle _vehicle = Vehicle(id: 1, imei: "12345678901245");
  //late VehicleSettings _settings;
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
  bool _isLoading = false;

  @override
  void initState() {
    _fetchInitialData();
    super.initState();
  }

  Future<void> _fetchInitialData() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> response;

    try {
      response = await getDevice(widget.deviceImei, widget.token);
      setState(() {
        _isLoading = false;
        _readings = response["readings"];
        _vehicle = response["vehicle"];
      });
    } catch (e) {
      throw Exception("Error fetching device: $e");
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
      body: const Center(child: CircularProgressIndicator()), // Show loader while loading
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
                      infoText: _vehicle.OrgName,
                      onButtonPress: () {
                        _openTextDialog(
                            "Firm",
                            (value) => setState(() {
                                  _vehicle.OrgName = value;
                                }));
                      }),
                  InfoPanel(
                      info: "Make",
                      infoText: _vehicle.Make,
                      onButtonPress: () {
                        _openTextDialog(
                            "Make",
                            (value) => setState(() {
                                  _vehicle.Make = value;
                                }));
                      }),
                  InfoPanel(
                      info: "Model",
                      infoText: _vehicle.Model,
                      onButtonPress: () {
                        _openTextDialog(
                            "Model",
                            (value) => setState(() {
                                  _vehicle.Model = value;
                                }));
                      }),
                  InfoPanel(
                      info: "Year",
                      infoText: _vehicle.Year,
                      onButtonPress: () {
                        _openTextDialog(
                            "Year",
                            (value) => setState(() {
                                  _vehicle.Year = value;
                                }));
                      }),
                  InfoPanel(
                      info: "Nick",
                      infoText: _vehicle.VehicleName,
                      onButtonPress: () {
                        _openTextDialog(
                            "Nickname",
                            (value) => setState(() {
                                  _vehicle.VehicleName = value;
                                }));
                      }),
                  const Expanded(child: SizedBox()),
                  DataLoadingButton(
                      buttonName: "Data",
                      textStyle: const TextStyle(fontSize: 24),
                      data: [
                        "Cumulative Power: ${_readings.cumulativePower.toStringAsFixed(2)}",
                        "Charges: ${_readings.fullCharges.toStringAsFixed(2)}",
                        "Max Volt: ${_readings.maxVolt.toStringAsFixed(2)}",
                        "PanelCurrent: ${_readings.panelCurrent.toStringAsFixed(2)}"
                      ],
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DataPage()));
                      }),
                  DataLoadingButton(
                      buttonName: "Settings",
                      textStyle: const TextStyle(fontSize: 24),
                      data: ["test1", "test2", "test3"],
                      onPress: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => settingsView(vehicleSettings: _settings) ));
                      }),
                  DataLoadingButton(
                      buttonName: "Rapport",
                      textStyle: const TextStyle(fontSize: 24),
                      enablePreview: false,
                      onPress: () {}),
                ],
              )),
        ));
  }
}
