import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_class/models/model_app_settings.dart';
import 'package:virtual_class/widgets/mydrawerappbar.dart';

class AppSettings extends StatefulWidget {
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  //bool _lights = Provider.of<AppSettingsModel>(context).getBoolVal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getappbar('Settings'),
      body: SwitchListTile(
        title: const Text('Dark mode'),
        value: Provider.of<AppSettingsModel>(context).getBoolVal(),
        onChanged: (bool value) {
          setState(() {
            Provider.of<AppSettingsModel>(context).changeTheme();
            //_lights = value;
          });
        },
        secondary: const Icon(Icons.color_lens),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AppSettingsModel>(context).changeTheme();
        },
        tooltip: 'Increment',
        child: Icon(Icons.format_paint),
      ),
    );
  }
}
