import 'package:encdec/services/license_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LicenseModel extends ChangeNotifier {
  bool licenseMode = false;
  String? validateLicense(String? licenseValue) {
    if (licenseValue!.isEmpty) {
      return "لایسنس خود را وارد کنید.";
    } else {
      return null;
    }
  }

  Future<bool> validateServerSide(String licenseKey) async {
    bool isValidated = await LicenseService().validateServerSide(licenseKey);
    return isValidated;
  }
}
