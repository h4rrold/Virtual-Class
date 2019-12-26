
import 'package:flutter/material.dart';
import 'package:virtualclass/core/http_service.dart';

class PostsModel extends ChangeNotifier{

  List<dynamic> classPostData;

  Future<List<dynamic>> getPosts(int classId) async {
      classPostData = await HttpService.getrequest("classes/$classId/posts");
      return classPostData;
  }
}