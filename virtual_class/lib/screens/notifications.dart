import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_class/models/model_app_settings.dart';
import 'package:virtual_class/models/test_model.dart';


class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: MyTheme.myTheme['screen'],
      body: Center(child: Container(child: Column(
        children: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context);},),
          Checkbox(
                                onChanged: (bool value) {
                                  setState(() {
                                    Provider.of<Navigation>(context, listen: false).setBool(value);
                                  });
                                },
                                value: Provider.of<Navigation>(context, listen: false).val,
                              ),
        ],
      ))),
    );
  }
}
