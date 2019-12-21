
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_class/models/settings.dart';
import 'package:virtual_class/widgets/mydrawer.dart';

class MyProfile1 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyProfile1State();
  
    
    }
  
  class _MyProfile1State extends State<MyProfile1> {
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: (){Navigator.pop(context);},),
              title: Text('Чат'),
            ),
        backgroundColor: MyTheme.myTheme['screen'],
        
      
    );
  }
}
  
