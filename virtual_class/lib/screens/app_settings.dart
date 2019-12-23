import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_class/models/model_app_settings.dart';
import 'package:virtual_class/widgets/mydrawerappbar.dart';

class AppSettings extends StatefulWidget {



  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  int _counter = 0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: getappbar('Settings'),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            Text(
              'Settings',
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Provider.of<AppSettingsModel>(context).changeTheme();
        },
        tooltip: 'Increment',
        child: Icon(Icons.format_paint),
      ), 
    );
  }
}
