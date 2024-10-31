import 'package:flutter/material.dart';
import 'package:prototype/src/unit_page/unit_page_view.dart';


class DataPage extends StatelessWidget {
  const DataPage({super.key});

  static const routeName = '/Data';

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                  "Data",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                  )),
              SizedBox(
                height: 400,
                child: ListView(
                  children: const <Widget>[
                    ListTile(
                      leading: Icon(Icons.battery_5_bar),
                      title: Text("Batteriniveau: 78%"),
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
                      leading: Icon(Icons.numbers),
                      title: Text("Antal opladninger: 1245"),
                    ),
                    // Add more ListTile entries here if needed
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context) => const UnitPageView())
                  );
                },
                child: const Text('Tilbage'),
              ),
            ],
          )
      ),
    );
  }
}
