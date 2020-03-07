import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xff212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color:Colors.black),
  dividerColor: Colors.black12
);
final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xffe5e5e5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color:Colors.white),
  dividerColor: Colors.white54
);

class ThemeNotifier with ChangeNotifier{
  ThemeData _themeData;
  ThemeNotifier(this._themeData);

  getTheme()=> _themeData;
  setTheme(ThemeData themeData) async{
    _themeData = themeData;
    notifyListeners();
  }
  
}