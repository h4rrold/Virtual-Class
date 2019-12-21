
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_class/models/settings.dart';
import 'package:virtual_class/widgets/mydrawer.dart';

class MyProfile extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyProfileState();
  
    
    }
  
  class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    
    return 
           Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              
              title: Text('Settings'),
            ),
            body: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    
                  ),
                  Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                  child: IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                  ),
                )
                ],
              )

            ),
        backgroundColor: MyTheme.myTheme['screen'],
        
      
    );
  }
}
  
