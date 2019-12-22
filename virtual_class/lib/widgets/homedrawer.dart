import 'package:flutter/material.dart';
import '../main.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.school,
              text: 'Classes',
              onTap: () {
                Navigator.popAndPushNamed(context, '/1');
                //Navigator.pop(context);
              }),
          _createDrawerItem(
              icon: Icons.notifications,
              text: 'Notofications',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder:(context) => MyHomePage(title: 'Notifications',)));
                
              }),
          _createDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => MyHomePage(title: 'Settings',)));
                Navigator.pop(context);
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Log out',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => MyHomePage(title: 'Exit',)));
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
