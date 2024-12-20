import 'package:flutter/material.dart';

class PostMortemProvider with ChangeNotifier {
  String textbox1 = '';
  String textbox2 = '';
  String textbox3 = '';
  String textbox4 = '';

  void saveChanges(String text1, String text2, String text3, String text4) {
    textbox1 = text1;
    textbox2 = text2;
    textbox3 = text3;
    textbox4 = text4;

    notifyListeners();
  }

  void clearChanges () {
    textbox1 = '';
    textbox2 = '';
    textbox3 = '';
    textbox4 = '';

    notifyListeners();
  }
}