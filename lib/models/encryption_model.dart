import 'package:flutter/material.dart';

class EncryptionModel extends ChangeNotifier {
  int currentValue = 0;
  changeCurrentValue(int? newValue) {
    currentValue = newValue ?? 0;
    notifyListeners();
  }
}
