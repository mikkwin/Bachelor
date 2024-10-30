import 'package:flutter/material.dart';
import 'package:prototype/src/unit_search/unit_search_view.dart';
import 'package:prototype/src/unit_page/unit_page_view.dart';

class settingsView extends StatelessWidget {
  const settingsView({super.key});

  static const routeName = '/Device_settings';
  


  @override
  Widget build(BuildContext context) {
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
               const TextField (
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Setting 1',
                  floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label always at the top
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.0), // Adjust padding as needed
                    child: Text(
                      '50%|', // Your prefix text or icon
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
             const TextField (
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Setting 2',
                  floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label always at the top
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.0), // Adjust padding as needed
                    child: Text(
                      '50%|', // Your prefix text or icon
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Setting 3',
                  floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label always at the top
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.0), // Adjust padding as needed
                    child: Text(
                      '50%|', // Your prefix text or icon
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Setting 4',
                  floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label always at the top
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.0), // Adjust padding as needed
                    child: Text(
                      '50%|', // Your prefix text or icon
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
               const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Setting 5',
                  floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label always at the top
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.0), // Adjust padding as needed
                    child: Text(
                      '50%|', // Your prefix text or icon
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
             const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Setting 6',
                  floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps the label always at the top
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.0), // Adjust padding as needed
                    child: Text(
                      '50%|', // Your prefix text or icon
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                 
                },
                child: const Text('Gem ændring'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context) => const UnitPageView())
                  );
                },
                child: const Text('tilbage'),
              ),
            ],
          )
        ),
      ),
    );
  }
}