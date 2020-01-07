import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/authorization.dart';
import 'package:virtualclass/models/navigation_model.dart';
import 'package:virtualclass/models/user_model.dart';
import 'package:virtualclass/screens/myProfile.dart';

class AppDrawer extends StatelessWidget {
final BuildContext context;

  const AppDrawer( this.context,{Key key}) : super(key: key);

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
              text: 'Notifications',
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Log out"),
                        content: new Text(
                            "This will return you to the login screen"),
                        actions: <Widget>[
                          FlatButton(
                            child: new Text("Yes"),
                            onPressed: () {
                              Provider.of<User>(context, listen: false).clearuser();
                              Provider.of<Authorization>(context).deletetoken();
                            },
                          ),
                          FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
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
          color: Colors.blue.shade800,
            ),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text(Provider.of<User>(context, listen: false).user['name'],
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

Widget getappbar(context,String title){
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
                      onTap: () => {
                       Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MyProfile();
                    }))
                      },
                      child: UserAvatar(
                          Provider.of<User>(context, listen: false).user['avatar']))))
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