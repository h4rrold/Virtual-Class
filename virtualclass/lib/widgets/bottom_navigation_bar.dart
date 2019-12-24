import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/model_app_settings.dart';

enum TabItem { home,message, settings }

Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.message: 'Message',
  TabItem.settings: 'Settings',
};

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab, this.changeIndex});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      //backgroundColor: MyTheme.myTheme['bnb'],
      //type: BottomNavigationBarType.fixed,
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Home'),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey),
        BottomNavyBarItem(
            icon: MyIcon(Icons.message),
            title: Text('Me'),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey),
        BottomNavyBarItem(
            icon: Icon(
              Icons.settings,
            ),
            title: Text('Settings'),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey),
      ],
      onItemSelected: (index) {
        return onSelectTab(TabItem.values[index]);
      },
      selectedIndex: currentTab.index,
    );
  }

  // BottomNavyBarItem _buildItem({TabItem tabItem}) {
  //   String text = tabName[tabItem];
  //   IconData icon = Icons.layers;
  //   return BottomNavyBarItem(
  //     activeColor: Colors.blue,
  //     icon: Icon(
  //       icon,
  //     ),
  //     inactiveColor: Colors.grey,
  //     title: Text(
  //       text,
  //     ),
  //   );
  // }
}

class MyIcon extends Icon {
  MyIcon(IconData icon) : super(icon);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Icon(this.icon,),
        Positioned(
          top:0,
          right: 0,
          child: Container(
            width: 10,
            height: 10,
            //color: Colors.red,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          ),
        )
      ],
    );
  }
}
