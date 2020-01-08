import 'package:flutter/material.dart';
import 'package:virtualclass/core/http_service.dart';

class ClassesModel extends ChangeNotifier {
  List<dynamic> userClassesData = [];
  int currentClassId;
  var currentclass;

  Future<dynamic> getclasses() async {
    var response = await HttpService.getrequest('classes');
    if (response is int) {
      return userClassesData;
    } else {
      userClassesData = response;
      return userClassesData;
    }
  }

  Future<dynamic> getclass() async {
    var response = await HttpService.getrequest('classes/$currentClassId');
    if (response is int) {
      return [];
    } else {
      currentclass = response;
      return currentclass;
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
  
  Future<dynamic> getClassMembers(int classId)async{
    var users = await HttpService.getrequest('classes/$classId/members');
    return users;
  }

  Future<dynamic> setClassMembers(int classId,String userEmail)async{
    var response = await HttpService.postrequest('classes/$classId/add_member',body: '{"email":"$userEmail"}');
    return response;
  }

  Future<dynamic> updateClassData(int classId,String className,String classBio)async{
    var response = await HttpService.putrequest('classes/$classId',body:'{"name" : "$className","description":"$classBio"}');
    return response;
  }
}
