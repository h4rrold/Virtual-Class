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
}
