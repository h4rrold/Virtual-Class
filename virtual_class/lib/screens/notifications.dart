
import 'package:flutter/material.dart';
import 'package:virtual_class/models/settings.dart';
import 'package:virtual_class/widgets/mydrawer.dart';

class Notifications extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => NotificationsState();
  
    
    }
  
  class NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return
   Scaffold(
          
            appBar: AppBar(
              toolbarOpacity: 0.8,
            
              
              title: Text('grgr'),
            ),
          
        backgroundColor: MyTheme.myTheme['screen'],
        body: Center(child: Text('Notifications')),
        
      
   );
  }
}
  