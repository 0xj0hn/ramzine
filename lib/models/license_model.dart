import 'package:flutter/material.dart';

class LicenseModel extends ChangeNotifier {
  final List<String> licenseKeys = [
    "e4c59617c96aa4966b9c8d0f1f102d4d",
  ];
  bool licenseMode = false;

  String? validateLicense(String? licenseValue) {
    bool isValidated = false;
    licenseKeys.forEach((licenseKey) {
      if (licenseKey == licenseValue) {
        isValidated = true;
      }
    });
    if (isValidated) {
      return null;
    } else {
      return "لایسنس شما اشتباه است.";
    }
  }
}
