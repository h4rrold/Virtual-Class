import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualclass/core/http_service.dart';

class Authorization extends ChangeNotifier {
  bool signedin;

  Future<String> getusertoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('signedin'));
    signedin = (pref.getString('signedin') == null) ? false : true;

    return pref.getString('signedin');
  }

  void setusertoken(String usertoken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('signedin', usertoken);
    //notifyListeners();
  }

  Future<bool> check() async {
    HttpService.settoken(await getusertoken());
    if (signedin)
      return true;
    else {
      return false;
    }
  }

  Future<dynamic> signin(
      {@required String email, @required String password}) async {
    Future.delayed(Duration(seconds: 1));

    var response =await HttpService.postrequest('login',
        body: '{"email": "$email", "password": "$password"}');
        print(response);
    return response;
  }

  void deletetoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('signedin');
    notifyListeners();
  }
}
