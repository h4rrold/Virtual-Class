
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_class/models/model_app_settings.dart';
import 'package:virtual_class/widgets/mydrawerappbar.dart';


class MyProfile1 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyProfile1State();
  
    
    }
  
  class _MyProfile1State extends State<MyProfile1> {
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
            appBar: getappbar('Chat'),
       // backgroundColor: MyTheme.myTheme['screen'],
        
      
    );
  }
}
  
