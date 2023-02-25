import 'package:encdec/models/license_model.dart';
import 'package:encdec/views/widgets/button_widget.dart';
import 'package:encdec/views/widgets/textfield_widget.dart';
import "package:flutter/material.dart";

class LicenseScreen extends StatelessWidget {
  LicenseScreen({super.key});
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  label: "لایسنس خود را وارد کنید",
                  validator: LicenseModel().validateLicense,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomButton(
                  onPressed: () {
                    bool isOk = _formKey.currentState!.validate();
                    if (isOk) {
                      print("ok");
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
