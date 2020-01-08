import 'package:provider/provider.dart';
import 'package:virtualclass/screens/classChat.dart';
import 'package:virtualclass/widgets/bottom_navigation_bar.dart';
import 'package:virtualclass/core/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'models/classes_model.dart';
import 'models/navigation_model.dart';
import 'widgets/mydrawerappbar.dart';




// class MyTheme {
//   static Map<String, Color> myColorsDark = {
//     "logo": Colors.white,
//     "screen": Colors.black,
//     "bnb": Colors.transparent, //Color(0xFF0c0c0d),
//     "bnbselitem": Colors.blue,
//     "bnbunselitem": Colors.white,
//     "changerTheme": Colors.white24,
//     "changerThemeicon": Colors.white,
//     "sizedbox": Colors.grey,
//     "maintext": Colors.white70,
//   };
//   static Map<String, Color> myColorsLight = {
//     "logo": Color(0xFF3b5998),
//     "screen": Colors.white,
//     "bnb": Colors.white,
//     "bnbselitem": Colors.blue,
//     "bnbunselitem": Colors.grey,
//     "changerTheme": Colors.blue,
//     "changerThemeicon": Colors.white,
//     "sizedbox": Color(0xFFd6d6d6),
//     "maintext": Colors.black,
//   };
//   static var myTheme = myColorsLight;
// }

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  TabItem _currentTab = TabItem.home;

  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.settings: GlobalKey<NavigatorState>(),
  };
  void _selectTab(TabItem tabItem) {
    if (tabItem == TabItem.message) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyProfile1()));
    } else if (tabItem == _currentTab) {
      // pop to first route

      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<Test>(builder: (context, model, wid) {
    //  // print('build');
    //   model.setContext(context);
    Provider.of<Navigation>(context).setContext(context);
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.home) {
            // select 'main' tab
            _selectTab(TabItem.home);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        print(isFirstRouteInCurrentTab.toString());
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        drawerEdgeDragWidth: 0,
        drawer: AppDrawer(context),
      appBar: getappbar(context,Provider.of<ClassesModel>(context,listen: false).currentclass['name']),
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.home),
          _buildOffstageNavigator(TabItem.settings),
        ]),
        bottomNavigationBar:
            BottomNavigation(currentTab: _currentTab, onSelectTab: _selectTab),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
