import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  static String domen = 'http://virtualclassvav.herokuapp.com/public/api/';
  static String token;

  static void settoken(String t){token = t;}

  static Future<dynamic> getrequest(String uri) async {
     print('http_token ' + token.toString());
    print(domen+uri);
    http.Response response = await http.get(domen + uri, headers: {"Authorization" : "Bearer $token","Content-type": "application/json", "Accept": "application/json"});
    print(response.statusCode);
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to load: ' + uri);
    }
  }

   static Future<dynamic> postrequest(String uri,{Map<String, String> headers, dynamic body, Encoding encoding}) async {
     //print(body);
     print(domen+uri);

    http.Response response = await http.post(domen + uri, body: body, headers: {"Authorization" : "Bearer $token","Content-type": "application/json", "Accept": "application/json"});
          print(response.statusCode);
          print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to load: ' + uri);
      return response.statusCode;
      //throw Exception('Failed to load');
    }
  }

   static Future<dynamic> putrequest(String uri,{Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response = await http.put(domen + uri, body: json,encoding: encoding??null);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to load: ' + uri);
      //throw Exception('Failed to load');
    }
  }

   static Future<void> delete(String uri,{Map<String, String> headers}) async {
    http.Response response = await http.delete(domen + 'delete/' + uri, headers: {"Authorization" : "Bearer $token","Content-type": "application/json", "Accept": "application/json"});

  if (response.statusCode == 200) {
    print("DELETED");
  } else {
    print('Failed to delete: ' + uri);
    return response.statusCode;
  }
}

static Future<int> getStatus()async{
  http.Response response = await http.get('http://virtualclassvav.herokuapp.com/public/api/classes');
      return  response.statusCode; 
}

}
