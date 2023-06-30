import 'package:flutter/material.dart';

class DrawerSelectedIndexProivder with ChangeNotifier {
  int _index = 0;
  int get getSelectedIndex => _index;

  void setSelectedIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
