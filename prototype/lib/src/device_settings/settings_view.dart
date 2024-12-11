import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:prototype/src/DAOs/VehicleSettings.dart';
import 'package:prototype/src/device_settings/settings_textState.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class settingsView extends StatelessWidget {
  final VehicleSettings vehicleSettings;
  const settingsView({
    super.key, 
    required this.vehicleSettings
     });
  
  static const routeName = '/Device_settings';
  final String url = "https://140.82.33.21:5001/Settings/ChangeSettings?";



  @override
  Widget build(BuildContext context) {
   


    Future<void> sendVehicleSetting(VehicleSettings setting, String string) async {
      try {
        final url = Uri.parse("https://140.82.33.21:5001/Settings/UpdateSettings");
        final response = await http.patch(
          url,
          headers: {
            "Content-Type": "application/json",
          },
          //  body: json.encode(setting.toMap()), // Serialize the object to JSON
        );

        if (response.statusCode == 200) {
          print("Settings updated successfully!");
        } else {
          print("Failed to update settings: ${response.statusCode}");
        }
      } catch (e) {
        throw Exception("Error: $e");
      }


    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(  // Add SingleChildScrollView to make the content scrollable
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,  // Align from the top
            children: [
              const SizedBox(height: 10),
  SettingsTextstate(
  onTextChange: (text10a) {
    
    vehicleSettings.s010a = checkDouble(text10a); // Parse the text to double
  },
  label: "010a",
  initialText: vehicleSettings.s010a.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text3) {
    vehicleSettings.e003 = checkDouble(text3); // Parse the text to double
  },
  label: "e003",
  initialText: vehicleSettings.e003.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text4) {
    vehicleSettings.e004 = checkDouble(text4); // Parse the text to double
  },
  label: "e004",
  initialText: vehicleSettings.e004.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text5) {
    vehicleSettings.e005 = checkDouble(text5); // Parse the text to double
  },
  label: "e005",
  initialText: vehicleSettings.e005.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  
  onTextChange: (text6) {
    
    vehicleSettings.e006 = checkDouble(text6); // Parse the text to double
  },
  label: "e006",
  initialText: vehicleSettings.e006.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text7) {
    vehicleSettings.e007 = checkDouble(text7); // Parse the text to double
  },
  label: "e007",
  initialText: vehicleSettings.e007.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text8) {
    vehicleSettings.e008 = checkDouble(text8); // Parse the text to double
  },
  label: "e008",
  initialText: vehicleSettings.e008.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text9) {
    vehicleSettings.e009 = checkDouble(text9); // Parse the text to double
  },
  label: "e009",
  initialText: vehicleSettings.e009.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (textA) {
    vehicleSettings.e00a = checkDouble(textA); // Parse the text to double
  },
  label: "e00a",
  initialText: vehicleSettings.e00a.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (textB) {
    vehicleSettings.e00b = checkDouble(textB); // Parse the text to double
  },
  label: "e00b",
  initialText: vehicleSettings.e00b.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (textC) {
    vehicleSettings.e00c = checkDouble(textC); // Parse the text to double
  },
  label: "e00c",
  initialText: vehicleSettings.e00c.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (textD) {
    vehicleSettings.e00d = checkDouble(textD); // Parse the text to double
  },
  label: "e00d",
  initialText: vehicleSettings.e00d.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (textE) {
    vehicleSettings.e00e = checkDouble(textE); // Parse the text to double
  },
  label: "e00e",
  initialText: vehicleSettings.e00e.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text10) {
    vehicleSettings.e010 = checkDouble(text10); // Parse the text to double
  },
  label: "e010",
  initialText: vehicleSettings.e010.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text11) {
    vehicleSettings.e011 = checkDouble(text11); // Parse the text to double
  },
  label: "e011",
  initialText: vehicleSettings.e011.toString(),
  suffixText: "",
),
const SizedBox(height: 10),

SettingsTextstate(
  onTextChange: (text12) {
    vehicleSettings.e012 = checkDouble(text12); // Parse the text to double
  },
  label: "e012",
  initialText: vehicleSettings.e012.toString(),
  suffixText: "",
),

              
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                VehicleSettings VeToSend = VehicleSettings(serialId: vehicleSettings.serialId, imei: vehicleSettings.imei, s010a: vehicleSettings.s010a, e003:vehicleSettings.e003, e004: vehicleSettings.e004, e005: vehicleSettings.e005, e006: vehicleSettings.e006, e007: vehicleSettings.e007, e008: vehicleSettings.e008, e009: vehicleSettings.e009, e00a: vehicleSettings.e00a, e00b: vehicleSettings.e00b, e00c: vehicleSettings.e00c, e00d: vehicleSettings.e00d, e00e: vehicleSettings.e00e, e010: vehicleSettings.e010, e011: vehicleSettings.e011, e012: vehicleSettings.e012, e013: vehicleSettings.e013, e014: vehicleSettings.e014);
                 sendVehicleSetting(VeToSend, "fisk");
                  //Navigator.pop(context);
                },
                child: Text('Gem ændring'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );

    
    }
    double checkDouble(String string){
      if(string.contains(".")){
        print(double.parse(string));
        return double.parse(string);
        
      }
      else{
        String sDouble = "$string.0";
        print(double.parse(sDouble));
        return double.parse(sDouble);
        
      }
  }
}
