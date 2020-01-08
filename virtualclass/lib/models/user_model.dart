import 'package:flutter/material.dart';
import 'package:virtualclass/core/http_service.dart';



class User extends ChangeNotifier{
  var user;

  Future<dynamic> getuser() async {
    user = await HttpService.getrequest('user');
    return user;
  }
  Future<dynamic> changeUserInfo(String userName,String userEmail,String userBio)async{
   var response = await HttpService.putrequest('user',body: '{"name":"$userName","email":"$userEmail","bio":"$userBio"}');
   return response;
  }
  void clearuser(){
    this.user = null;
  }

}