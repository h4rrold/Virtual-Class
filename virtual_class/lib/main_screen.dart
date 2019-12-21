import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:virtual_class/main.dart';
import 'package:virtual_class/screens/myprofile%20copy.dart';
import 'package:virtual_class/widgets/bottom_navigation_bar.dart';
import 'package:virtual_class/core/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:virtual_class/widgets/mydrawer.dart';

import 'models/test_model.dart';

abstract class HasVoidChange {
  VoidCallback get refresh;
}

abstract class HasChange {
  Function get refresh;
}

List stories = [
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/0.png'
  },
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/1.png'
  },
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/2.png'
  },
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/3.png'
  },
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/0.png'
  },
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/1.png'
  },
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/2.png'
  },
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/3.png'
  },
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/0.png'
  },
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/1.png'
  },
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/2.png'
  },
  {
    'name': 'Kyiv Days',
    'person_image': 'assets/kyiv.png',
    'story_image': 'assets/3.png'
  },
];

List posts = [
  {
    'index': 0,
    'news':
        'Молодіжні збірні України з баскетболу 3х3 сьогодні у Китаї розпочинають виступи на ЧС-2019',
    'news_image': 'assets/_0.png'
  },
  {
    'index': 1,
    'news': 'В Україні оголосили штормове попередження',
    'news_image': 'assets/_1.png'
  },
  {'index': 2, 'news': ':)', 'news_image': 'assets/_2.png'},
  {'index': 3, 'news': '', 'news_image': 'assets/_3.png'},
  {
    'index': 4,
    'news': 'Google впроваджує режим "інкогніто" у Картах',
    'news_image': 'assets/_4.png'
  }
];

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
    Provider.of<Test>(context).setContext(context);
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
        // drawerEdgeDragWidth: 0,
        // drawer: AppDrawer(),
        // appBar: AppBar(
        //   title: Text('Virtual Class'),
        // ),
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
    print('rebuild ' + tabItem.toString());
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
