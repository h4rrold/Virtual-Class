import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/model_app_settings.dart';
import 'package:virtualclass/models/navigation_model.dart';
import 'package:virtualclass/models/notifications_model.dart';
import 'package:virtualclass/screens/start_home.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';


class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {

  List<dynamic> _userNotifications;

   Future<void> getnotifications() async {
    _userNotifications =
        await Provider.of<NotificationsModel>(context, listen: false).getNotifications();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getnotifications(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {

          ///when the future is null
          case ConnectionState.none:
            return Text(
              'null',
              textAlign: TextAlign.center,
            );

          case ConnectionState.active:

          ///when data is being fetched
          case ConnectionState.waiting:
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Center(
                  child: SpinKitFadingCube(
                size: 100,
                color: Colors.blue,
              )),
            );

          case ConnectionState.done:
            if (snapshot.hasError)
              return Text(
                'Error:\n\n${snapshot.error}',
                textAlign: TextAlign.center,
              );

            ///task is complete with some data
            return Scaffold(
              appBar: getappbar(context, 'Notifications', true),
                body: RefreshIndicator(
                  child: (_userNotifications.isNotEmpty)
                      ? ListView.builder(
                          padding:
                              EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
                          itemCount: _userNotifications.length,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.only(bottom: 18.0),
                                child: NotificationExcerpt(
                _userNotifications[index]['class']['image'],
                _userNotifications[index]['class']['name'],
                'new post',
                _userNotifications[index]['content'],
                _userNotifications[index]['created_at']));
                          })
                      : Center(
                          child: Text(
                          'Sorry, there are no notifications yet.',
                          style: Theme.of(context)
                              .textTheme
                              .body2
                              .copyWith(fontSize: 16),
                        )),
                  onRefresh: getnotifications,
                ),
                );
        }
      },
    );
  }
}
