import 'package:flutter/material.dart';
import 'package:virtualclass/main.dart';
import 'package:virtualclass/screens/app_settings.dart';
import 'package:virtualclass/screens/classes.dart';

class Navigation extends ChangeNotifier {
  BuildContext mainacontext;
  String text;
  int count;
  bool val= false;
  String apptitle = '';

  setText(String t) {
    this.text = t;
    notifyListeners();
  }

setTitle(String t) {
    this.apptitle = t;
    notifyListeners();
  }


  setBool(bool t) {
    this.val = t;
  }

setCount(int t) {
    this.count = t;
    notifyListeners();
  }
  String get getText=> this.text;

  setContext(BuildContext c) {
    this.mainacontext = c;
  }

  goNotifications() {
    Navigator.push(this.mainacontext, MaterialPageRoute(builder:(context) => MyHomePage(title: 'Notifications',)));
  }

  goClasses() {
    Navigator.push(this.mainacontext, MaterialPageRoute(builder:(context) => MyClasses()));
  }

  goSettings() {
    Navigator.push(this.mainacontext, MaterialPageRoute(builder:(context) => AppSettings()));
  }

  goLogout() {
    Navigator.push(this.mainacontext, MaterialPageRoute(builder:(context) => MyHomePage(title: 'Log out',)));
  }
}
