import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme extends ChangeNotifier {
  static Map<String, dynamic> myColorsDark = {
    'sysbar': SystemUiOverlayStyle.light,
    "logo": Colors.white,
    "screen": Colors.black,
    "bnb": Colors.black, //Color(0xFF0c0c0d),
    "bnbselitem": Colors.blue,
    "bnbunselitem": Colors.white,
    "changerTheme": Colors.white24,
    "changerThemeicon": Colors.white,
    "sizedbox": Colors.grey,
    "maintext": Colors.white70,
  };
  static Map<String, dynamic> myColorsLight = {
    'sysbar': SystemUiOverlayStyle.dark,
    "logo": Color(0xFF3b5998),
    "screen": Colors.white,
    "bnb": Colors.white,
    "bnbselitem": Colors.blue,
    "bnbunselitem": Colors.grey,
    "changerTheme": Colors.blue,
    "changerThemeicon": Colors.white,
    "sizedbox": Color(0xFFd6d6d6),
    "maintext": Colors.black,
  };
   static  var myTheme = myColorsLight;
  
  getTheme() => myTheme;

  changeTheme() {
    print('changeTheme()');
    MyTheme.myTheme = MyTheme.myTheme == MyTheme.myColorsLight
        ? MyTheme.myColorsDark
        : MyTheme.myColorsLight;
        //SystemChrome.setSystemUIOverlayStyle(myTheme['sysbar']);
        notifyListeners();
  }
}
