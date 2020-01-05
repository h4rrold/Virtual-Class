import 'package:flutter/material.dart';
import 'package:virtualclass/core/http_service.dart';

class ClassesModel extends ChangeNotifier {
  List<dynamic> userClassesData;
  int currentClassId;

  Future<List<dynamic>> getclasses() async {
    userClassesData = await HttpService.getrequest('classes');
    return userClassesData;
  }

  Future<List> getSomeclasses() async {
    userClassesData = await HttpService.getrequest('classes?amount=5');
    return userClassesData;
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
