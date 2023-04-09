import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LicenseModel extends ChangeNotifier {
  final List<String> licenseKeys = [
    "e4c59617c96aa4966b9c8d0f1f102d4d",
  ];
  bool licenseMode = false;

  String? validateLicense(String? licenseValue) {
    if (licenseValue!.isEmpty) {
      return "لایسنس خود را وارد کنید.";
    } else {
      return null;
    }
  }

  Future<bool> validateServerSide(String licenseKey) async {
    var url = Uri.parse("http://localhost/enc/");
    Map<String, dynamic> body = {"license_key": licenseKey};
    http.Response request = await http.post(url, body: body);
    return (request.statusCode == 200);
  }
}
