import 'package:flutter/material.dart';

class AppService {
  BuildContext context;
  AppService(this.context);
  snackBar(String text) {
    SnackBar snackbar = SnackBar(
      content: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Icon(Icons.info),
          ),
          const Expanded(child: SizedBox(width: 10)),
          Expanded(
            flex: 9,
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Vazir',
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  replaceNavigateTo(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  namedNavigateTo(String pageName) {
    Navigator.pushNamed(context, pageName);
  }

  replaceNamedNavigateTo(String pageName) {
    Navigator.pushReplacementNamed(context, pageName);
  }
}
