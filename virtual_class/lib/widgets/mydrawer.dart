import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_class/main.dart';
import 'package:virtual_class/models/test_model.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Provider.of<Test>(context, listen: false).goHome();
                Navigator.pop(context);
              }),
          _createDrawerItem(
              icon: Icons.school,
              text: 'Classes',
              onTap: () {
                Provider.of<Test>(context, listen: false).goClasses();
                Navigator.pop(context);
              }),
          _createDrawerItem(
              icon: Icons.notifications,
              text: 'Notofications',
              onTap: () {
                Provider.of<Test>(context, listen: false).goNotifications();
                Navigator.pop(context);
              }),
          _createDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Provider.of<Test>(context, listen: false).goSettings();
                Navigator.pop(context);
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Log out',
              onTap: () {
                Provider.of<Test>(context, listen: false).goLogout();
                Navigator.pop(context);
              }),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/_1.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Vitaliy Furman",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
