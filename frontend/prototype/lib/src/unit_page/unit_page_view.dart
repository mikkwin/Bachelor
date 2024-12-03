import 'package:flutter/material.dart';
import 'package:prototype/src/DAOs/Vehicle.dart';
import 'package:prototype/src/device_settings/settings_view.dart';
import 'package:prototype/src/http_requests.dart';
import 'package:prototype/src/post_mortem/post_mortem.dart';
import 'package:prototype/src/Data/DataPage.dart';

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
                                        const settingsView()));
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
                            "Ingen fejl fundet",
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
