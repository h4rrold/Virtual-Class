import 'package:flutter/material.dart';
import 'package:virtualclass/core/http_service.dart';

class ClassesModel extends ChangeNotifier {
  List<dynamic> userClassesData = [];
  int currentClassId;

  Future<dynamic> getclasses() async {
    var response = await HttpService.getrequest('classes');
    if (response is int) {
      return userClassesData;
    } else {
      userClassesData = response;
      return userClassesData;
    }
  }

  Future<dynamic> getSomeclasses() async {
    var response = await HttpService.getrequest('classes?amount=5');
    if (response is int) {
      return userClassesData;
    } else {
      userClassesData = response;
      return userClassesData;
    }
  }

  Future<dynamic> addclass(String name, String bio) async {
    var response = await HttpService.postrequest('classes',
        body: '{"name": "$name", "description": "$bio"}');
    print(response);
    return response;
  }

  Future<dynamic> deleteClass(int id) async {
    var response = await HttpService.postrequest('$id');
    print(response);
    return response;
  }
}
