import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              icon: Icons.school,
              text: 'Classes',
              onTap: () {
                Navigator.pop(context);
                Provider.of<Navigation>(context, listen: false).goClasses();
                
              }),
          _createDrawerItem(
              icon: Icons.notifications,
              text: 'Notofications',
              onTap: () {
                Navigator.pop(context);
                Provider.of<Navigation>(context, listen: false).goNotifications();
              }),
          _createDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Navigator.pop(context);
                Provider.of<Navigation>(context, listen: false).goSettings();
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Log out',
              onTap: () {
                Navigator.pop(context);
                Provider.of<Navigation>(context, listen: false).goLogout();
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

Widget getappbar(String title){
   return AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              title,
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 16, left: 28),
              child: Center(
                  child: GestureDetector(
                      onTap: () => {},
                      child: UserAvatar(
                          'https://image.freepik.com/free-photo/_8353-6394.jpg'))))
        ],
      );
}

class UserAvatar extends StatelessWidget {
  String userAvatarUrl;
  UserAvatar(this.userAvatarUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 34,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.network(this.userAvatarUrl).image,
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat),
        shape: BoxShape.circle,
      ),
    );
  }
}