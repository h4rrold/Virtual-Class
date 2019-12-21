import 'package:provider/provider.dart';
import 'package:virtual_class/models/test_model.dart';
import 'package:virtual_class/screens/home.dart';
import 'package:virtual_class/screens/myprofile.dart';
import 'package:virtual_class/screens/notifications.dart';
import 'package:virtual_class/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String main = '/';
  static const String notifications = '/notifications';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  final dynamic map = {
    TabItem.home: Home(),
    TabItem.settings: MyProfile(),
    //TabItem.notifications: Notifications(),
  };

  Map<String, Widget> _routeBuilders() {
    return {
      TabNavigatorRoutes.main: map[tabItem],
      TabNavigatorRoutes.notifications: Notifications()
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders();
    return Consumer<Test>(builder: (context, model, wid) {
      return Navigator(
        key: this.navigatorKey,
        initialRoute: TabNavigatorRoutes.main,
        onGenerateRoute: (routeSettings) {
          print(tabName[tabItem]);
          print(routeSettings.toString());
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name],
            settings: routeSettings,
          );

          // return PageRouteBuilder(
          //   pageBuilder: (context, animation, secondaryAnimation) =>
          //       routeBuilders[routeSettings.name],
          //   settings: routeSettings,
          //   transitionsBuilder: (context, a1, a2, child) {

          //     return FadeTransition(
          //       opacity: a1,
          //       child: child
          //     );
          //   },
          //   transitionDuration: Duration(milliseconds: 500),
          // );
        },
        observers: [HeroController()],
      );
    });
  }
}
