import 'package:flutter/material.dart';
import 'package:prototype/src/DAOs/VehicleSettings.dart';
import 'package:prototype/src/device_settings/settings_textState.dart';
import 'package:prototype/src/device_settings/temp_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class settingsView extends StatelessWidget {
  const settingsView({super.key});

  static const routeName = '/Device_settings';
  final String url = "https://localhost:5001/Settings/ChangeSettings?";



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TempProvider>(context);
    String setting10a = provider.textbox10a ;
    String setting3 = provider.textbox3 ;
    String setting4 = provider.textbox4 ;
    String setting5 = provider.textbox5 ;
    String setting6 = provider.textbox6 ;
    String setting7 = provider.textbox7 ;
    String setting8 = provider.textbox8 ;
    String setting9 = provider.textbox9 ;
    String settingA = provider.textboxA ;
    String settingB = provider.textboxB ;
    String settingC = provider.textboxC ;
    String settingD = provider.textboxD ;
    String settingE = provider.textboxE ;
    String setting10 = provider.textbox10 ;
    String setting11 = provider.textbox11 ;
    String setting12 = provider.textbox12 ;


    Future<void> sendVehicleSetting(VehicleSettings setting) async {
      try {
        final url = Uri.parse("https://localhost:5001/Settings/ChangeSettings");
        final response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(setting.toMap()), // Serialize the object to JSON
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
                  provider.saveChanges(text10a, setting3, setting4, setting5, setting6, setting7, setting8, setting9, settingA, settingB, settingC, settingD, settingE, setting10, setting11, setting12, text10a);
                },
                label: "010a",
                initialText: provider.textbox10a,
                suffixText: "W",
              ),
              const SizedBox(height: 10),
              SettingsTextstate(
                onTextChange: (text3) {
                  provider.saveChanges(setting10a, text3, setting4, setting5, setting6, setting7, setting8, setting9, settingA, settingB, settingC, settingD, settingE, setting10, setting11, setting12, text3);
                },
                label: "e003",
                initialText: provider.textbox3,
                suffixText: "",
              ),
              const SizedBox(height: 10),
              SettingsTextstate(
                onTextChange: (text4) {
                  provider.saveChanges(setting10a, setting3, text4, setting5, setting6, setting7, setting8, setting9, settingA, settingB, settingC, settingD, settingE, setting10, setting11, setting12, text4);
                },
                label: "e004",
                initialText: provider.textbox4,
                suffixText: "",
              ),
              const SizedBox(height: 10),
              SettingsTextstate(
                onTextChange: (text5) {
                  provider.saveChanges(setting10a, setting3, setting4, text5, setting6, setting7, setting8, setting9, settingA, settingB, settingC, settingD, settingE, setting10, setting11, setting12, text5);
                },
                label: "e005",
                initialText: provider.textbox5,
                suffixText: "",
              ),
              const SizedBox(height: 10),
              SettingsTextstate(
                onTextChange: (text6) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, text6, setting7, setting8, setting9, settingA, settingB, settingC, settingD, settingE, setting10, setting11, setting12, text6);
                },
                label: "e006",
                initialText: provider.textbox6,
                suffixText: "",
              ),
              const SizedBox(height: 10),
              SettingsTextstate(
                onTextChange: (text7) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, setting6, text7, setting8, setting9, settingA, settingB, settingC, settingD, settingE, setting10, setting11, setting12, text7);
                },
                label: "e007",
                initialText: provider.textbox7,
                suffixText: "",
              ),
              SettingsTextstate(
                onTextChange: (text8) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, setting6, setting7, text8, setting9, settingA, settingB, settingC, settingD, settingE, setting10, setting11, setting12, text8);
                },
                label: "e008",
                initialText: provider.textbox8,
                suffixText: "",
              ),
              SettingsTextstate(
                onTextChange: (text9) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, setting6, setting7, setting8, text9, settingA, settingB, settingC, settingD, settingE, setting10, setting11, setting12, text9);
                },
                label: "e009",
                initialText: provider.textbox9,
                suffixText: "",
              ),
              SettingsTextstate(
                onTextChange: (textA) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, setting6, setting7, setting8, setting9, textA, settingB, settingC, settingD, settingE, setting10, setting11, setting12, textA);
                },
                label: "e00a",
                initialText: provider.textboxA,
                suffixText: "",
              ),
              SettingsTextstate(
                onTextChange: (textB) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, setting6, setting7, setting8, setting9, settingA, textB, settingC, settingD, settingE, setting10, setting11, setting12, textB);
                },
                label: "e00b",
                initialText: provider.textboxB,
                suffixText: "",
              ),
              SettingsTextstate(
                onTextChange: (textC) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, setting6, setting7, setting8, setting9, settingA, settingB, textC, settingD, settingE, setting10, setting11, setting12, textC);
                },
                label: "e00c",
                initialText: provider.textboxC,
                suffixText: "",
              ),
              SettingsTextstate(
                onTextChange: (textD) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, setting6, setting7, setting8, setting9, settingA, settingB, settingC, textD, settingE, setting10, setting11, setting12, textD);
                },
                label: "e00d",
                initialText: provider.textboxD,
                suffixText: "",
              ),
              SettingsTextstate(
                onTextChange: (textE) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, setting6, setting7, setting8, setting9, settingA, settingB, settingC, settingD, textE, setting10, setting11, setting12, textE);
                },
                label: "e00e",
                initialText: provider.textboxE,
                suffixText: "",
              ),
              SettingsTextstate(
                onTextChange: (text10) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, setting6, setting7, setting8, setting9, settingA, settingB, settingC, settingD, settingE, text10, setting11, setting12, text10);
                },
                label: "e010",
                initialText: provider.textbox10,
                suffixText: "",
              ),
              SettingsTextstate(
                onTextChange: (text11) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, setting6, setting7, setting8, setting9, settingA, settingB, settingC, settingD, settingE, setting10, text11, setting12, text11);
                },
                label: "e011",
                initialText: provider.textbox11,
                suffixText: "",
              ),
              SettingsTextstate(
                onTextChange: (text12) {
                  provider.saveChanges(setting10a, setting3, setting4, setting5, setting6, setting7, setting8, setting9, settingA, settingB, settingC, settingD, settingE, setting10, setting11, text12, text12);
                },
                label: "e012",
                initialText: provider.textbox12,
                suffixText: "",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print(setting10a);
                  print(settingC);

                  Navigator.pop(context);
                },
                child: Text('Gem ændring'),
              ),
            ],
          ),
        ),
      ),
    );


  }
}
