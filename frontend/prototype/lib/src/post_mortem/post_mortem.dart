import 'package:flutter/material.dart';
import 'package:prototype/src/post_mortem/post_mortem_provider.dart';
import 'package:prototype/src/post_mortem/post_mortem_textfield.dart';
import 'package:prototype/src/unit_search/unit_search_view.dart';
import 'package:provider/provider.dart';

class PostMortem extends StatelessWidget {
  final String token;
  const PostMortem({super.key, required this.token});

  static const routeName = '/Skades_rapport';

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PostMortemProvider>(context);

    String text1 = provider.textbox1;
    String text2 = provider.textbox2;
    String text3 = provider.textbox3;
    String text4 = provider.textbox4;

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
              initialText: text1,
              onTextChanged: (newText) {
                provider.saveChanges(newText, text2, text3, text4);
              }
              ),

            const SizedBox(height: 32),
            
            PostMortemTextfield(
              label: "Hvad var løsningen",
              initialText: text2,
              onTextChanged: (newText) {
                provider.saveChanges(text1, newText, text3, text4);
              }
              ),

            const SizedBox(height: 32),

            PostMortemTextfield(
                label: "Hvilke hjælpe midler brugt",
                initialText: text3,
                onTextChanged: (newText) {
                  provider.saveChanges(text1, text2, newText, text4);
                }),

            const SizedBox(height: 32), // Spacer
            
            PostMortemTextfield(
              label: "Yderligere info",
              initialText: text4,
              onTextChanged: (newText) {

                provider.saveChanges(text1, text2, text3, newText);
              }
              ),
              
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UnitSearchView(token: token)));
                    provider.clearChanges();
              },
              child: const Text('Gem'),
            ),
          ],
        )),
      ),
    );
  }
}
