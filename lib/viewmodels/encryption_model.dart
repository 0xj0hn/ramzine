import 'package:encdec/services/encryption_service.dart';
import 'package:flutter/material.dart';

class EncryptionModel extends ChangeNotifier {
  int currentValue = 0;
  String resultValue = "";
  changeCurrentValue(int? newValue) {
    currentValue = newValue ?? 0;
    notifyListeners();
  }

  encrypt(String key, String message) async {
    String cipherText;
    try {
      cipherText = await Encryption().encrypt(key, message);
    } catch (e) {
      cipherText = e.toString();
    }
    resultValue = cipherText;
    notifyListeners();
  }

  decrypt(String key, String message) async {
    String plainText;
    try {
      plainText = await Encryption().decrypt(key, message);
    } catch (e) {
      plainText = e.toString();
    }
    resultValue = plainText;
    notifyListeners();
  }
}
