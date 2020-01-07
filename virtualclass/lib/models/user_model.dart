import 'package:flutter/material.dart';
import 'package:virtualclass/core/http_service.dart';



class User extends ChangeNotifier{

  var user;

  Future<dynamic> getuser() async {
    user = await HttpService.getrequest('user');
    return user;
  }

  void clearuser(){
    this.user = null;
  }

}