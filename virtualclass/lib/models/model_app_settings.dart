import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsModel extends ChangeNotifier {
  AppSettingsModel() {
    //mytheme = light;
    getSavedTheme();
    // getSavedTheme().then((String str){
    //   print(themename[str]);
    //   mytheme = themename[str] ?? light;});
    //themename.keys.firstWhere((key)=>themename[key]==mytheme);
    // mytheme = themename[getSavedTheme()] ?? light;
  }

  static final ThemeData light = ThemeData(
      primaryColor: Colors.blue.shade800,
      highlightColor: Colors.blue[400],
      hoverColor: Colors.blue[400],
      fontFamily: 'Roboto',
      inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(),
          labelStyle: TextStyle(color: Colors.blue[400]),
          hintStyle: TextStyle(color: Colors.grey[400]),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400])),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]))),
      buttonTheme: ButtonThemeData(minWidth: 111),
      textTheme: TextTheme(
          display1: TextStyle(
              color: Colors.blue[400],
              fontSize: 32,
              fontWeight: FontWeight.w500),
          body1: TextStyle(color: Colors.grey[850]),
          body2: TextStyle(color: Colors.grey[400], fontSize: 12),
          button: TextStyle(
              color: Colors.blue[400],
              fontSize: 12,
              fontWeight: FontWeight.w500))
              );

  static final ThemeData dark = ThemeData(
    
      primaryColor: Colors.blue.shade800,
      hoverColor: Colors.blue[400],
      brightness: Brightness.dark,
      
      fontFamily: 'Roboto',
     backgroundColor: Colors.grey[900],
          highlightColor: Colors.blue[400],
          inputDecorationTheme: InputDecorationTheme(
              errorStyle: TextStyle(),
              labelStyle: TextStyle(color: Colors.blue[400]),
              hintStyle: TextStyle(color: Colors.grey[400]),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[400])),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[400]))),
          buttonTheme: ButtonThemeData(minWidth: 111),
          textTheme: TextTheme(
              display1: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 32,
                  fontWeight: FontWeight.w500),
              body1: TextStyle(color: Colors.white),
              body2: TextStyle(color: Colors.white, fontSize: 12),
              button: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 12,
                  fontWeight: FontWeight.w500))
              );
  Map<String, ThemeData> themename = {'light': light, 'dark': dark};

  static var mytheme;

  Future<String> getSavedTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    mytheme = themename[pref.getString('apptheme')] ?? light;
    return pref.getString('apptheme');
  }

  void setSavedTheme(ThemeData theme) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('apptheme',
        themename.keys.firstWhere((key) => themename[key] == mytheme));
  }

  ThemeData get getTheme => mytheme;

  bool getBoolVal() {
    return mytheme == light ? false : true;
  }

  void changeTheme() {
    mytheme = mytheme == dark ? light : dark;
    setSavedTheme(mytheme);
    notifyListeners();
  }
}
