
import 'package:flutter/material.dart';
import 'package:virtualclass/core/http_service.dart';

class PostsModel extends ChangeNotifier{

  List<dynamic> classPostData;

  Future<List<dynamic>> getPosts(int classId) async {
    print('--------------------------------postData---------------------------------');
      classPostData = await HttpService.getrequest("classes/$classId/posts");
      return classPostData;
  }
   Future<dynamic> addPost(int classId,String postTitle,String postText,String attachmentUrl)async{
     print('Post content:$postText');
     print('---------ADD POST-------');
    var response = await HttpService.postrequest("classes/$classId/posts",body: '{"title": "$postTitle", "content": "$postText", "attachments": "$attachmentUrl"}');
    
    return response;
   }
   Future <dynamic> getPostViews(int id)async{
     var views = await HttpService.getrequest("posts/$id/views");
     return views;
   }
   Future <dynamic> increaseViewsAmount(int id)async{
     var views = await HttpService.postrequest("posts/$id/views");
     return views;
   }
}