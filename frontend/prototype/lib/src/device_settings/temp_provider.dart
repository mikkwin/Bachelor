import 'package:flutter/material.dart';

class TempProvider with ChangeNotifier {
  String textbox10a = '120W';
  String textbox3 = '57';
  String textbox4 = '15';
  String textbox5 = '57';
  String textbox6 = '78';
  String textbox7 = '100';
  String textbox8 = '100';
  String textbox9 = '100';
  String textboxA = '100';
  String textboxB = '100';
  String textboxC = '100';
  String textboxD = '100';
  String textboxE = '100';
  String textbox10 = '100';
  String textbox11 = '100';
  String textbox12 = '100';




  void saveChanges(
      String text10a,
      String text3,
      String text4,
      String text5,
      String text6,
      String text7,
      String text8,
      String text9,
      String textA,
      String textB,
      String textC,
      String textD,
      String textE,
      String text10,
      String text11,
      String text12,
      String text
      ) {
    textbox10a = text10a;
    textbox3 = text3;
    textbox4 = text4;
    textbox5 = text5;
    textbox6 = text6;
    textbox7 = text7;
    textbox8 = text8;
    textbox9 = text9;
    textboxA = textA;
    textboxB = textB;
    textboxC = textC;
    textboxD = textD;
    textboxE = textE;
    textbox10 = text10;
    textbox11 = text11;
    textbox12 = text12;

    notifyListeners();
  }

  void clearChanges() {
    textbox10a = '';
    textbox3 = '';
    textbox4 = '';
    textbox5 = '';
    textbox6 = '';
    textbox7 = '';
    textbox8 = '';
    textbox9 = '';
    textboxA = '';
    textboxB = '';
    textboxC = '';
    textboxD = '';
    textboxE = '';
    textbox10 = '';
    textbox11 = '';
    textbox12 = '';

    notifyListeners();
  }

}