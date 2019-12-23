import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppSettingsModel extends ChangeNotifier {
  static final ThemeData light = ThemeData(
          primaryColor: Colors.blue.shade800,
          hoverColor: Colors.blueAccent,
          fontFamily: 'Roboto',
          textTheme: TextTheme(
              body1: TextStyle(color: Colors.grey[850]),
              body2: TextStyle(color: Colors.grey[400], fontSize: 12),
              button: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w500)));

  static final ThemeData dark = ThemeData(
          primaryColor: Colors.red[300],
          hoverColor: Colors.blueAccent,
          fontFamily: 'Roboto',
          textTheme: TextTheme(
              body1: TextStyle(color: Colors.grey[850]),
              body2: TextStyle(color: Colors.grey[400], fontSize: 12),
              button: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w500)));

  
 static var mytheme = light;

 ThemeData get getTheme => mytheme;

 void changeTheme(){
   mytheme = mytheme == dark ? light : dark;
   notifyListeners();
 }

}
