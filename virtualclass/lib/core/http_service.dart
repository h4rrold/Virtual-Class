import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<dynamic> getrequest(String uri) async {
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

   Future<dynamic> postrequest(String uri,{Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response = await http.post(uri, headers: headers, body: json,encoding: encoding??null);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

   Future<dynamic> putrequest(String uri,{Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response = await http.put(uri, headers: headers, body: json,encoding: encoding??null);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

   Future<void> deletePost(String uri,{Map<String, String> headers}) async {
    http.Response response = await http.delete(uri);

  if (response.statusCode == 200) {
    print("DELETED");
  } else {
    throw "Can't delete.";
  }
}

static Future<int> getStatus()async{
  http.Response response = await http.get('http://virtualclassvav.herokuapp.com/public/api/classes');
      return  response.statusCode; 
}

}
