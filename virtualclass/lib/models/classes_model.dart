import 'package:flutter/material.dart';
import 'package:virtualclass/core/http_service.dart';

class ClassesModel extends ChangeNotifier {
  var userClassesData;
  int currentClassId;

  Future<dynamic> getclasses() async {
    userClassesData = await HttpService.getrequest('classes');
    return userClassesData;
  }

  Future<dynamic> getSomeclasses() async {
    var response = await HttpService.getrequest('classes?amount=5');
      return response;
  }

  Future<dynamic> addclass(String name, String bio)async{
  
    var response = await HttpService.postrequest('classes',
        body: '{"name": "$name", "description": "$bio"}');
        print(response);
    return response;
  }

  Future<dynamic> deleteClass(int id)async{
  
    var response = await HttpService.postrequest('$id');
        print(response);
    return response;
  }
}
