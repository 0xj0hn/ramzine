import 'package:http/http.dart' as http;

class LicenseService {
  Future<bool> validateServerSide(String licenseKey) async {
    var url = Uri.parse("http://localhost/enc/");
    Map<String, dynamic> body = {"license_key": licenseKey};
    http.Response request = await http.post(url, body: body);
    print(request.body);
    return (request.statusCode == 200);
  }
}
