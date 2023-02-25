import 'package:encdec/models/encryption_model.dart';
import 'package:encdec/services/encryption_service.dart';
import 'package:encdec/views/widgets/button_widget.dart';
import 'package:encdec/views/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  label: "رمز خود را وارد کنید.",
                  suffixIcon: Icon(Icons.password),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
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
                        subtitle: Text("این گزینه پیام داده شده را رمز میکند."),
                        value: 0,
                        groupValue: model.currentValue,
                        onChanged: model.changeCurrentValue,
                      ),
                      RadioListTile(
                        title: Text("رمزگشایی"),
                        subtitle: Text("این گزینه پیام رمز شده را برمیگرداند."),
                        value: 1,
                        groupValue: model.currentValue,
                        onChanged: model.changeCurrentValue,
                      ),
                    ],
                  );
                },
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: [
                    SelectableText(
                      "Answersdfsdfdsfsdf\n\n\n\n\\nsdfsdfsdfsdf\n\n\n\nsdf",
                      style: TextStyle(
                        color: Theme.of(context).canvasColor,
                      ),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: "something"));
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: Icon(
                    Icons.copy,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: "asdsad"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
