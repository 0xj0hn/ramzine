import 'package:encdec/viewmodels/license_model.dart';
import 'package:encdec/services/app_service.dart';
import 'package:encdec/views/widgets/button_widget.dart';
import 'package:encdec/views/widgets/textfield_widget.dart';
import "package:flutter/material.dart";
import 'package:hive/hive.dart';

class LicenseScreen extends StatelessWidget {
  LicenseScreen({super.key});
  TextEditingController licenseKeyTxt = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ورود"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              const Center(
                child: Text(
                  "این قسمت نیازمند به اتصال اینترنت است.",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const Center(
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  controller: licenseKeyTxt,
                  label: "لایسنس خود را وارد کنید",
                  validator: LicenseModel().validateLicense,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomButton(
                  onPressed: () async {
                    bool isOk = _formKey.currentState!.validate();
                    AppService appService = AppService(context);
                    var box = Hive.box("auth");
                    if (isOk) {
                      bool isLicenseValidated = await LicenseModel()
                          .validateServerSide(licenseKeyTxt.text);
                      if (!isLicenseValidated) {
                        appService.snackBar("لایسنس شما اشتباه است!");
                      } else {
                        box.put("isLicenseEntered", true);
                        appService.replaceNamedNavigateTo("/home");
                      }
                    }
                  },
                  icon: Icons.login,
                  text: "ورود",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
