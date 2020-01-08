
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/model_app_settings.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';


class MyProfile1 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyProfile1State();
  
    
    }
  
  class _MyProfile1State extends State<MyProfile1> {
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
            appBar: getappbar(context,'Chat', true),
       // backgroundColor: MyTheme.myTheme['screen'],
        
      
    );
  }
}
  
