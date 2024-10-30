import 'package:flutter/material.dart';
import 'package:prototype/src/unit_search/unit_search_view.dart';

class PostMortem extends StatelessWidget {
const PostMortem({super.key});

static const routeName = '/Skaderapport';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skaderapport"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: TextEditingController(text: "A"),
              decoration: InputDecoration(
                labelText: "Fejl",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),

            TextField(
              controller: TextEditingController(text: "B"),
              decoration: InputDecoration(
                labelText: "Symptomer",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),


            TextField(
              controller: TextEditingController(text: "C"),
              decoration: InputDecoration(
                labelText: "Hvad vi fiksede",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32), // Spacer

            TextField(
              controller: TextEditingController(text: "D"),
              decoration: InputDecoration(
                labelText: "Endelig rapport",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context) => const UnitSearchView())
                );
              },
              child: const Text('Afslut'),
            ),
          ],
        ),
      ),
    );
  }
}
