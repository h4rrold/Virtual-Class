import 'package:flutter/material.dart';
import 'package:virtual_class/main.dart';

class Test extends ChangeNotifier {
  BuildContext mainacontext;
  String text;
  int count;

  setText(String t) {
    this.text = t;
    notifyListeners();
  }

setCount(int t) {
    this.count = t;
    notifyListeners();
  }
  String get getText=> this.text;

  setContext(BuildContext c) {
    this.mainacontext = c;
  }

  goHome() {
    Navigator.push(this.mainacontext, MaterialPageRoute(builder:(context) => MyHomePage(title: 'Home',)));
  }

  goNotifications() {
    Navigator.push(this.mainacontext, MaterialPageRoute(builder:(context) => MyHomePage(title: 'Notifications',)));
  }

  goClasses() {
    Navigator.push(this.mainacontext, MaterialPageRoute(builder:(context) => MyHomePage(title: 'Classes',)));
  }

  goSettings() {
    Navigator.push(this.mainacontext, MaterialPageRoute(builder:(context) => MyHomePage(title: 'Settings',)));
  }

  goLogout() {
    Navigator.push(this.mainacontext, MaterialPageRoute(builder:(context) => MyHomePage(title: 'Log out',)));
  }
}
