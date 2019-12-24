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
      hoverColor: Colors.blue[400],
      brightness: Brightness.light,
      fontFamily: 'Roboto',
      textTheme: TextTheme(
          body1: TextStyle(color: Colors.grey[850]),
          body2: TextStyle(color: Colors.grey[400], fontSize: 12),
          button: TextStyle(
              color: Colors.blue[600],
              fontSize: 12,
              fontWeight: FontWeight.w500)));

  static final ThemeData dark = ThemeData(
      primaryColor: Colors.blue.shade800,
      hoverColor: Colors.blue[400],
      brightness: Brightness.dark,
      fontFamily: 'Roboto',
      textTheme: TextTheme(
          body1: TextStyle(color: Colors.grey[850]),
          body2: TextStyle(color: Colors.grey[400], fontSize: 12),
          button: TextStyle(
              color: Colors.blue[600],
              fontSize: 12,
              fontWeight: FontWeight.w500)));
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

  bool getBoolVal(){
    return mytheme == light ? false : true;
  }

  void changeTheme() {

    mytheme = mytheme == dark ? light : dark;
     setSavedTheme(mytheme);
    notifyListeners();
  }
}
