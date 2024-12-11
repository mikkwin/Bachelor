import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/src/DAOs/VehicleSettings.dart';
import 'package:prototype/src/device_settings/settings_textState.dart';

class SettingsView extends StatefulWidget {
  final VehicleSettings vehicleSettings;

  const SettingsView({
    super.key,
    required this.vehicleSettings,
  });

  static const routeName = '/Device_settings';

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String? errorMessage;

  Future<void> sendVehicleSetting(VehicleSettings setting) async {
    try {
      final url = Uri.parse("https://140.82.33.21:5001/Settings/UpdateSettings");
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(setting.toMap()), // Serialize the object to JSON
      );

      if (response.statusCode == 200) {
        print("Settings updated successfully!");
        setState(() {
          errorMessage = null; // Clear error if successful
        });
      } else {
        setState(() {
          errorMessage = "Failed to update settings: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred: $e";
      });
    }
  }

  double checkDouble(String string) {
    try {
      if (string.contains(".")) {
        return double.parse(string);
      } else {
        String sDouble = "$string.0";
        return double.parse(sDouble);
      }
    } catch (e) {
      throw Exception("Invalid input");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 10),
              if (errorMessage != null) ...[
                const SizedBox(height: 10),
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
              const SizedBox(height: 10),
              SettingsTextstate(
  onTextChange: (text10a) {
    try {
      widget.vehicleSettings.s010a = checkDouble(text10a);
      setState(() {
        errorMessage = null; // Clear error on valid input
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for s010a";
      });
    }
  },
  label: "010a",
  initialText: widget.vehicleSettings.s010a.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text3) {
    try {
      widget.vehicleSettings.e003 = checkDouble(text3);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e003";
      });
    }
  },
  label: "e003",
  initialText: widget.vehicleSettings.e003.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text4) {
    try {
      widget.vehicleSettings.e004 = checkDouble(text4);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e004";
      });
    }
  },
  label: "e004",
  initialText: widget.vehicleSettings.e004.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text5) {
    try {
      widget.vehicleSettings.e005 = checkDouble(text5);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e005";
      });
    }
  },
  label: "e005",
  initialText: widget.vehicleSettings.e005.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text6) {
    try {
      widget.vehicleSettings.e006 = checkDouble(text6);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e006";
      });
    }
  },
  label: "e006",
  initialText: widget.vehicleSettings.e006.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text7) {
    try {
      widget.vehicleSettings.e007 = checkDouble(text7);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e007";
      });
    }
  },
  label: "e007",
  initialText: widget.vehicleSettings.e007.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text8) {
    try {
      widget.vehicleSettings.e008 = checkDouble(text8);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e008";
      });
    }
  },
  label: "e008",
  initialText: widget.vehicleSettings.e008.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text9) {
    try {
      widget.vehicleSettings.e009 = checkDouble(text9);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e009";
      });
    }
  },
  label: "e009",
  initialText: widget.vehicleSettings.e009.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (textA) {
    try {
      widget.vehicleSettings.e00a = checkDouble(textA);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e00a";
      });
    }
  },
  label: "e00a",
  initialText: widget.vehicleSettings.e00a.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (textB) {
    try {
      widget.vehicleSettings.e00b = checkDouble(textB);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e00b";
      });
    }
  },
  label: "e00b",
  initialText: widget.vehicleSettings.e00b.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (textC) {
    try {
      widget.vehicleSettings.e00c = checkDouble(textC);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e00c";
      });
    }
  },
  label: "e00c",
  initialText: widget.vehicleSettings.e00c.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (textD) {
    try {
      widget.vehicleSettings.e00d = checkDouble(textD);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e00d";
      });
    }
  },
  label: "e00d",
  initialText: widget.vehicleSettings.e00d.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (textE) {
    try {
      widget.vehicleSettings.e00e = checkDouble(textE);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e00e";
      });
    }
  },
  label: "e00e",
  initialText: widget.vehicleSettings.e00e.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text10) {
    try {
      widget.vehicleSettings.e010 = checkDouble(text10);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e010";
      });
    }
  },
  label: "e010",
  initialText: widget.vehicleSettings.e010.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text11) {
    try {
      widget.vehicleSettings.e011 = checkDouble(text11);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e011";
      });
    }
  },
  label: "e011",
  initialText: widget.vehicleSettings.e011.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text12) {
    try {
      widget.vehicleSettings.e012 = checkDouble(text12);
      setState(() {
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Invalid input for e012";
      });
    }
  },
  label: "e012",
  initialText: widget.vehicleSettings.e012.toString(),
  suffixText: "",
),
const SizedBox(height: 10),


              if (errorMessage != null) ...[
                const SizedBox(height: 10),
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],

              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  VehicleSettings veToSend = VehicleSettings(
                    serialId: widget.vehicleSettings.serialId,
                    imei: widget.vehicleSettings.imei,
                    s010a: widget.vehicleSettings.s010a,
                    e003: widget.vehicleSettings.e003,
                    e004: widget.vehicleSettings.e004,
                    e005: widget.vehicleSettings.e005,
                    e006: widget.vehicleSettings.e006,
                    e007: widget.vehicleSettings.e007,
                    e008: widget.vehicleSettings.e008,
                    e009: widget.vehicleSettings.e009,
                    e00a: widget.vehicleSettings.e00a,
                    e00b: widget.vehicleSettings.e00b,
                    e00c: widget.vehicleSettings.e00c,
                    e00d: widget.vehicleSettings.e00d,
                    e00e: widget.vehicleSettings.e00e,
                    e010: widget.vehicleSettings.e010,
                    e011: widget.vehicleSettings.e011,
                    e012: widget.vehicleSettings.e012,
                    e013: widget.vehicleSettings.e013,
                    e014: widget.vehicleSettings.e014,
                  );
                  sendVehicleSetting(veToSend);
                },
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
