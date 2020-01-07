
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/model_app_settings.dart';
import 'package:virtualclass/models/navigation_model.dart';
import 'package:virtualclass/models/user_model.dart';


class MyProfile extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyProfileState();
  
    
    }
  
  class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    print('rebuild Settings');
    return 
           Scaffold(
            // drawer: AppDrawer(),
            // appBar: AppBar(
              
            //   title: Text('Settings'),
            // ),
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
                      print(Provider.of<User>(context, listen: false).user);
                    },
                  ),
                ),
                Text(Provider.of<User>(context, listen: false).user.toString())
                ],
              )

            ),
       // backgroundColor: MyTheme.myTheme['screen'],
        
      
    );
  }
}
  
