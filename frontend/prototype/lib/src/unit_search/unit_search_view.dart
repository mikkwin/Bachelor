import 'package:flutter/material.dart';
import 'package:prototype/src/login/login_view.dart';
import 'package:prototype/src/unit_page/unit_page_view.dart';
import 'package:prototype/src/unit_search/unit_search_button.dart';

/// Displays a list of SampleItems.
class UnitSearchView extends StatelessWidget {
  const UnitSearchView({super.key});

  static const routeName = '/unit_search';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    var stel = "ABCD1234567890";
    var nummer = "EGA12345";
    var firma = "VIA";
    var _text = "";

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Future.delayed(Duration.zero, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Device Search'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text("Filter"),
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 30),
                  Expanded(
                    child: UnitSearchButton(
                      initialText: "Imei",
                      icon: const Icon(Icons.fingerprint),
                      onPressed: () {
                        _showDialog(context); // Trigger the dialog when button is pressed
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: UnitSearchButton(
                      initialText: "Firma",
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        _showDialog(context); // Trigger the dialog when button is pressed
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: UnitSearchButton(
                      initialText: "Plade",
                      icon: const Icon(Icons.local_shipping),
                      onPressed: () {
                        _showDialog(context); // Trigger the dialog when button is pressed
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: UnitSearchButton(
                      initialText: "Online",
                      icon: const Icon(Icons.link),
                      onPressed: () {
                        _showDialog(context); // Trigger the dialog when button is pressed
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(30),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              // Wrapping the ListView in Expanded directly
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: const <Widget>[
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("IMEI: 123456789012345"),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("IMEI: 123456789012345"),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("IMEI: 123456789012345"),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("IMEI: 123456789012345"),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("IMEI: 123456789012345"),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("IMEI: 123456789012345"),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("IMEI: 123456789012345"),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("IMEI: 123456789012345"),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("IMEI: 123456789012345"),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("IMEI: 123456789012345"),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("IMEI: 123456789012345"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show a dialog
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controller = TextEditingController();

        return AlertDialog(
          title: const Text('Enter Value'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // To prevent content from expanding unnecessarily
            children: [
              const Text('Please enter a value below:'),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter something...',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                // You can access the text entered in _controller.text
                print("User entered: ${_controller.text}");
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
