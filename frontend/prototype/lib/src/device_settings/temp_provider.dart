import 'package:flutter/material.dart';

class TempProvider with ChangeNotifier {
  String textbox1 = '12';
  String textbox2 = '57';
  String textbox3 = '15';
  String textbox4 = '57';
  String textbox5 = '78';
  String textbox6 = '100';

  void saveChanges(String text1, String text2, String text3, String text4, String text5, String text6) {
    textbox1 = text1;
    textbox2 = text2;
    textbox3 = text3;
    textbox4 = text4;
    textbox5 = text5;
    textbox6 = text6;

    notifyListeners();
  }

  void clearChanges () {
    textbox1 = '';
    textbox2 = '';
    textbox3 = '';
    textbox4 = ''; 
    textbox5 = '';
    textbox6 = "";

    notifyListeners();
  }
}