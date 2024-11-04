import 'package:flutter/material.dart';
import 'package:prototype/src/unit_page/unit_page_view.dart';

const List<String> searchType = <String>[
  'IMEI',
  'Firma',
  'Stelnummer',
  'Nummerplade'
];

class DropDownButtonSearchType extends StatefulWidget {
  const DropDownButtonSearchType({super.key});

  @override
  State<StatefulWidget> createState() => _DropDownButtonSearchTypeState();
}

class _DropDownButtonSearchTypeState extends State<DropDownButtonSearchType> {
  String dropdownValue = searchType.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: searchType.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList());
  }
}

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
          const SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
              child: const TextField(
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search Parameter',
              ))),
          const DropDownButtonSearchType(),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UnitPageView()));
              },
              child: const Text("Search")),
          const SizedBox(height: 20),
          Text("History",
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
      )),
    );
  }
}
