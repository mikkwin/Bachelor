import 'package:flutter/material.dart';
import 'package:prototype/src/device_settings/settings_textState.dart';
import 'package:prototype/src/device_settings/temp_provider.dart';
import 'package:provider/provider.dart';

class settingsView extends StatelessWidget {
  const settingsView({super.key});

  static const routeName = '/Device_settings';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TempProvider>(context);
    String setting1 = provider.textbox1 ;
    String setting2 = provider.textbox2 ;
    String setting3 = provider.textbox3 ;
    String setting4 = provider.textbox4 ;
    String setting5 = provider.textbox5 ;
    String setting6 = provider.textbox6 ;



    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                SettingsTextstate(
                  onTextChange: (text) {
                    provider.saveChanges(text, setting2, setting3, setting4, setting5, setting6);                 
                  },
                  label: "Batteri type",
                  initialText: provider.textbox1,
                  suffixText: "%",
                ),
                const SizedBox(height: 10),
                SettingsTextstate(
                  onTextChange: (text) {
                    provider.saveChanges(setting1, text, setting3, setting4, setting5, setting6);
                  },
                  label: "Setting 2",
                  initialText:provider.textbox2,
                  suffixText: "%",
                ),
                const SizedBox(height: 10),
                SettingsTextstate(
                  onTextChange: (text) {
                    provider.saveChanges(setting1, setting2, text, setting4, setting5, setting6);
                  },
                  label: "Setting 3",
                  initialText: provider.textbox3,
                  suffixText: "%",
                ),
                const SizedBox(height: 10),
                SettingsTextstate(
                  onTextChange: (text) {
                   provider.saveChanges(setting1, setting2, setting3, text, setting5, setting6);
                  },
                  label: "Setting 4",
                  initialText: provider.textbox4,
                  suffixText: "%",
                ),
                const SizedBox(height: 10),
                SettingsTextstate(
                  
                  onTextChange: (text) {
                    provider.saveChanges(setting1, setting2, setting3, setting4, text, setting6);
                  },
                  label: "Setting 5",
                  initialText: provider.textbox5,
                  suffixText: "%",
                ),
                const SizedBox(height: 10),
                SettingsTextstate(
                  onTextChange: (text) {
                    provider.saveChanges(setting1, setting2, setting3, setting4, setting5, text);
                  },
                  label: "Setting 6",
                  initialText: provider.textbox6,
                  suffixText: "%",
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Gem ændring'), 
                ),
              ],
            )),
      ),
    );
  }
}
