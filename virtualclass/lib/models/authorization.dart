import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualclass/core/http_service.dart';

class Authorization extends ChangeNotifier {
  bool signedin;
  var user;

  Future<String> getusertoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('signedin'));
    signedin = (pref.getString('signedin') == null) ? false : true;

    return pref.getString('signedin');
  }

  void setusertoken(String usertoken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('signedin', usertoken);
  }

  Future<bool> check() async {
    HttpService.settoken(await getusertoken());
    if (signedin)
      return true;
    else {
      return false;
    }
  }

  Future<dynamic> signin({String email, String password}) async {
    Future.delayed(Duration(seconds: 1));

    var response = await HttpService.postrequest('login',
        body: '{"email": "$email", "password": "$password"}');
    if (response == 200) {
      HttpService.settoken(response['access_token']);
      this.user = await HttpService.getrequest('user');
      print(user);
    }
    return response;
  }

  Future<dynamic> signup({String name, String email, String password}) async {
    Future.delayed(Duration(seconds: 1));

    var response = await HttpService.postrequest('register',
        body: '{"name": "$name", "email": "$email", "password": "$password"}');
    if (response == 200) {
      HttpService.settoken(response['access_token']);
      this.user = await HttpService.getrequest('user');
    }
    return response;
  }

  void deletetoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('signedin');
    notifyListeners();
  }
}
