import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData? currentTheme;
  final box = Hive.box("theme");
  ThemeModel() {
    currentTheme = box.get("isDarkTheme") ? darkTheme : lightTheme;
  }

  ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xff075e54),
    fontFamily: "Vazir",
    colorScheme: const ColorScheme.light(
      primary: Color(0xff075e54),
      secondary: Color(0xff075e54),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 1.0,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w100,
        color: Colors.white,
        fontFamily: "Vazir",
        fontSize: 20,
      ),
      backgroundColor: Color(0xff075e54),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(
        const Color(0xff075e54),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(
        const Color(0xff075e54),
      ),
    ),
    backgroundColor: const Color(0xffece5dd),
    iconTheme: const IconThemeData(color: Colors.white),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(foregroundColor: Colors.white),
  );

  ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xffbd93f9),
    fontFamily: "Vazir",
    colorScheme: const ColorScheme.dark(
      primary: Color(0xffbd93f9),
      secondary: Color(0xffff79c6),
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Color(0xffbd93f9),
      titleTextStyle: TextStyle(
        color: Color(0xffbd93f9),
        fontFamily: "Vazir",
        fontSize: 20,
      ),
      backgroundColor: Color(0xff282a36),
      elevation: 1.0,
      centerTitle: true,
    ),
    cardColor: const Color(0xff44475a),
    scaffoldBackgroundColor: const Color(0xff282a36),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(const Color(0xffbd93f9)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(
        const Color(0xffbd93f9),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xffbd93f9),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Color(0xffbd93f9),
    ),
  );

  bool get isDarkMode {
    return currentTheme == darkTheme;
  }

  toggleTheme() {
    if (isDarkMode) {
      box.put("isDarkTheme", !isDarkMode);
      currentTheme = lightTheme;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: const Color(0xffece5dd),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: lightTheme.primaryColor,
        statusBarBrightness: Brightness.dark,
      ));
    } else {
      box.put("isDarkTheme", !isDarkMode);
      currentTheme = darkTheme;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: darkTheme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: darkTheme.scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
      ));
    }
    notifyListeners();
  }
}
