import 'package:flutter/material.dart';
import 'package:prototype/src/unit_page/unit_page_view.dart';

/// Displays a list of SampleItems.
class UnitSearchView extends StatelessWidget {
  const UnitSearchView({super.key});

  static const routeName = '/unit_search';
  
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Search'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Please input device ID"), // Potententiel fremtidig tjek: Søg efter device
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ID',
                )
              )
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UnitPageView())
                    );
              }, 
              child: const Text("Search")
            ),
            const SizedBox(height: 20),
            Text(
              "History", 
              style: TextStyle(
                fontSize: screenWidth * 0.06,
              )),
            SizedBox(
              height: 400, // Set a fixed height for the ListView
              child: ListView(
                children: const <Widget>[
                  ListTile(
                    leading: Icon(Icons.car_crash),
                    title: Text("Device: 123456789012345"),
                    trailing: Icon(Icons.search),
                  ),
                  ListTile(
                    leading: Icon(Icons.car_crash),
                    title: Text("Device: 123456789012345"),
                    trailing: Icon(Icons.search),
                  ),
                  ListTile(
                    leading: Icon(Icons.car_crash),
                    title: Text("Device: 123456789012345"),
                    trailing: Icon(Icons.search),
                  ),
                  ListTile(
                    leading: Icon(Icons.car_crash),
                    title: Text("Device: 123456789012345"),
                    trailing: Icon(Icons.search),
                  ),
                  ListTile(
                    leading: Icon(Icons.car_crash),
                    title: Text("Device: 123456789012345"),
                    trailing: Icon(Icons.search),
                  ),
                  ListTile(
                    leading: Icon(Icons.car_crash),
                    title: Text("Device: 123456789012345"),
                    trailing: Icon(Icons.search),
                  ),
                  ListTile(
                    leading: Icon(Icons.car_crash),
                    title: Text("Device: 123456789012345"),
                    trailing: Icon(Icons.search),
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
