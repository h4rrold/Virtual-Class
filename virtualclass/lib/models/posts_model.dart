
import 'package:flutter/material.dart';
import 'package:virtualclass/core/http_service.dart';

class PostsModel extends ChangeNotifier{

  List<dynamic> classPostData;

  Future<List<dynamic>> getPosts(int classId) async {
      classPostData = await HttpService.getrequest("classes/$classId/posts");
      print('--------------------------------postData---------------------------------');
      print(classPostData);
      return classPostData;
  }
   Future<int> addPost(int classId,String postTitle,String postText,String attachmentUrl)async{
    var response = await HttpService.postrequest("classes/$classId/posts",body: '{"title": "$postTitle", "content": "$postText", "attachments:" "$attachmentUrl"}');
    return response;
   }
}