import 'package:flutter/material.dart';
import 'package:prototype/src/DAOs/Vehicle.dart';
import 'package:prototype/src/DAOs/VehicleInfo.dart';
import 'package:prototype/src/DAOs/VehicleReadings.dart';
import 'package:prototype/src/DAOs/enums/ErrorCode.dart';
import 'package:prototype/src/device_settings/settings_view.dart';
import 'package:prototype/src/http_requests.dart';
import 'package:prototype/src/post_mortem/post_mortem.dart';
import 'package:prototype/src/Data/DataPage.dart';
import 'package:prototype/src/DAOs/VehicleSettings.dart';
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
  Vehicle _vehicle = Vehicle(id: 1, imei: "12345678901245");
  VehicleSettings? _settings;
  VehicleInfo? _info;
  bool _isLoading = false;

  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }


  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _vehicle = await getDevice(widget.deviceImei, widget.token);
      print(1);
      _info = await fetchData(widget.deviceImei, widget.token);
      print(2);
      _settings = await fetchSettings(widget.deviceImei, widget.token);

      if(_info != null) {
        List<ErrorCode> codes = _info!.Errors;
        List<VehicleReadings> readings = _info!.Readings;


      }
      if(_settings != null) {
        print("Settings e00d:  ${_settings!.e00d}");
      }

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
                                         settingsView(vehicleSettings: VeToSend)));
                          },
                          child: const Icon(Icons.settings))
                    ]),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenWidth * 0.02),
                        child: Text(
                            "Firm: ${_vehicle.OrgName}\nLicense plate: ${_vehicle.LicensePlate}\nVehicle nickname: ${_vehicle.VehicleName}"),
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
                                      builder: (context) => DataPage(
                                          token: widget.token,
                                          deviceImei: widget.deviceImei)));
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
