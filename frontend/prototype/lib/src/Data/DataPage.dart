import 'package:flutter/material.dart';
import 'package:prototype/src/unit_page/unit_page_view.dart';


class DataPage extends StatelessWidget {
  const DataPage({super.key});

  static const routeName = '/Data';

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data'),
      ),
      body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 400,
                child: ListView(
                  children: const <Widget>[
                    ListTile(
                      leading: Icon(Icons.battery_5_bar),
                      title: Text("Batteriniveau: 78%"),
                    ),
                    ListTile(
                      leading: Icon(Icons.battery_5_bar),
                      title: Text("Akkumuleret: 12345"),
                    ),
                    ListTile(
                      leading: Icon(Icons.calendar_month_sharp),
                      title: Text("Installationsdato: 14/1/2019"),
                    ),
                    ListTile(
                      leading: Icon(Icons.speed),
                      title: Text("Opladningshastighed: 152kWh"),
                    ),
                    ListTile(
                      leading: Icon(Icons.speed),
                      title: Text("Batteri Amp: 100"),
                    ),
                    ListTile(
                      leading: Icon(Icons.speed),
                      title: Text("Batteri Volt: 100"),
                    ),
                    ListTile(
                      leading: Icon(Icons.speed),
                      title: Text("Panel Amp: 100"),
                    ),
                    ListTile(
                      leading: Icon(Icons.speed),
                      title: Text("Panel Volt: 100"),
                    ),
                    // Add more ListTile entries here if needed
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
