import 'package:encdec/services/app_service.dart';
import 'package:encdec/viewmodels/encryption_model.dart';
import 'package:encdec/viewmodels/license_model.dart';
import 'package:encdec/views/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController secretKeyTxt = TextEditingController();
  TextEditingController messageTxt = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    var box = Hive.box("auth");
    Future.delayed(Duration.zero, () async {
      bool isValidated =
          await LicenseModel().validateServerSide(box.get("license"));
      if (!isValidated) {
        box.put("isLicenseEntered", false);
        AppService(context).replaceNamedNavigateTo("/license");
      }
    });
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EncryptionModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "رمزینه",
              ),
              Icon(
                Icons.enhanced_encryption_outlined,
                size: 17,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: secretKeyTxt,
                    label: "رمز خود را وارد کنید.",
                    suffixIcon: Icon(Icons.password),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "رمز باید وارد شود!";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: messageTxt,
                    label: "پیام خود را وارد کنید.",
                    maxLines: 7,
                    suffixIcon: Icon(Icons.message),
                  ),
                ),
                Consumer<EncryptionModel>(
                  builder: (context, model, child) {
                    return Column(
                      children: [
                        RadioListTile(
                          title: Text("رمزنگاری"),
                          subtitle:
                              Text("این گزینه پیام داده شده را رمز میکند."),
                          value: 0,
                          groupValue: model.currentValue,
                          onChanged: model.changeCurrentValue,
                        ),
                        RadioListTile(
                          title: Text("رمزگشایی"),
                          subtitle:
                              Text("این گزینه پیام رمز شده را برمیگرداند."),
                          value: 1,
                          groupValue: model.currentValue,
                          onChanged: model.changeCurrentValue,
                        ),
                      ],
                    );
                  },
                ),
                Consumer<EncryptionModel>(
                  builder: (context, model, child) {
                    return Visibility(
                      visible: model.resultValue.isEmpty,
                      replacement: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(
                          children: [
                            SelectableText(
                              model.resultValue,
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                              ),
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: model.resultValue));
                              },
                            ),
                          ],
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: const Text("محل قرارگیری رمز..."),
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    icon: const Icon(
                      Icons.copy,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: Provider.of<EncryptionModel>(context,
                                  listen: false)
                              .resultValue,
                        ),
                      ); //store result to clipboard
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      Text("تهیه شده توسط محمدمهدی بنیادی"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            String secretKey = secretKeyTxt.text;
            String message = messageTxt.text;
            var provider = Provider.of<EncryptionModel>(context, listen: false);
            if (_formKey.currentState!.validate()) {
              if (provider.currentValue == 0) {
                //encryption
                provider.encrypt(secretKey, message);
              } else {
                provider.decrypt(secretKey, message);
              }
            }
          },
          child: const Icon(Icons.check_rounded),
        ),
      ),
    );
  }
}
