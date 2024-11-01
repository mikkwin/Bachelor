import 'package:flutter/material.dart';
import 'package:prototype/src/PostMortum/post_mortem_textfield.dart';
import 'package:prototype/src/unit_search/unit_search_view.dart';

class PostMortem extends StatelessWidget {
  const PostMortem({super.key});

  static const routeName = '/Skades_rapport';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skades rapport"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PostMortemTextfield(
              label: "Kundens problem",
              onTextChanged: (newText) {
                print("test: $newText"); // TODO: alter this.
              }
              ),

            const SizedBox(height: 32),
            
            PostMortemTextfield(
              label: "Hvad var løsningen",
              onTextChanged: (newText) {
                print("test: $newText"); // TODO: alter this.
              }
              ),

            const SizedBox(height: 32),

            PostMortemTextfield(
                label: "Hvilke hjælpe midler brugt",
                onTextChanged: (newText) {
                  print("test: $newText"); // TODO: alter this.
                }),

            const SizedBox(height: 32), // Spacer
            
            PostMortemTextfield(
              label: "Yderligere info",
              onTextChanged: (newText) {
                print("test: $newText"); // TODO: alter this.
              }
              ),
              
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UnitSearchView()));
              },
              child: const Text('Gem'),
            ),
          ],
        )),
      ),
    );
  }
}
