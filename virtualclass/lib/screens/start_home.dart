import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/classes_model.dart';
import 'package:virtualclass/models/notifications_model.dart';
import 'package:virtualclass/screens/classes.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';
import '../main_screen.dart';
import '../models/navigation_model.dart';

class MyStartPage extends StatefulWidget {
  MyStartPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyStartPageState createState() => _MyStartPageState();
}

class _MyStartPageState extends State<MyStartPage> {
  List<dynamic> _homeClassData = [];
  List<dynamic> _notifications = [];
  Future<void> getclassesNotifications() async {
    _homeClassData = await Provider.of<ClassesModel>(context, listen: false)
        .getSomeclasses();
    _notifications =
        await Provider.of<NotificationsModel>(context, listen: false)
            .getSomecnotifications();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Navigation>(context).setContext(context);
    // TODO: implement build
    return RefreshIndicator(
      child: FutureBuilder(
          future: getclassesNotifications(),
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

                ///task is complete with an error (eg. When you
                ///are offline)
                if (snapshot.hasError)
                  return Text(
                    'Error:\n\n${snapshot.error}',
                    textAlign: TextAlign.center,
                  );

                ///task is complete with some data
                return Scaffold(
                  appBar: getappbar(context, 'Home', true),
                  drawer: AppDrawer(context),
                  body: Container(
                    padding: EdgeInsets.only(
                        top: 22, right: 16, left: 16, bottom: 24),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: Center(
                                  child: Text(
                                    'Recent notifications',
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(fontSize: 22),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              (!_notifications.isEmpty)
                                  ? NotificationList(
                                      notificationData: _notifications,
                                    )
                                  : Padding(
                                    padding: const EdgeInsets.only(bottom:10.0),
                                    child: Center(
                                        child: Text(
                                        'Sorry, there are no notifications yet.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .body2
                                            .copyWith(fontSize: 16),
                                      )),
                                  ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Center(
                                  child: InkWell(
                                    onTap: () => {},
                                    child: Text('View more notifications',
                                        style:
                                            Theme.of(context).textTheme.button),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 12),
                                      child: Text('Your classes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .body1
                                              .copyWith(fontSize: 21)),
                                    ),
                                    (this._homeClassData.isNotEmpty)
                                        ? ClassCarousel(this._homeClassData)
                                        : Text(
                                            'Sorry, you don’t have any classes yet.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2
                                                .copyWith(fontSize: 16),
                                          )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
            }
          }),
      onRefresh: getclassesNotifications,
    );
  }
}

class NotificationList extends StatefulWidget {
  final List<dynamic> notificationData;

  const NotificationList({Key key, this.notificationData}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          ...widget.notificationData.map((notificaton) => Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: NotificationExcerpt(
                notificaton['class']['image'],
                notificaton['class']['name'],
                'new post',
                notificaton['content'],
                notificaton['created_at']),
          ))
        ],
      ),
    );
  }
}

class NotificationExcerpt extends StatelessWidget {
  String notificationAvatar;
  String notificationAuthor;
  String notificationText;
  String notificationAction;
  String notificationDate;
  NotificationExcerpt(this.notificationAvatar, this.notificationAuthor,
      this.notificationAction, this.notificationText, this.notificationDate);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.grey[600], offset: Offset(0, 1), blurRadius: 3),
      ], color: Theme.of(context).backgroundColor),
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                child: UserAvatar(this.notificationAvatar),
                onTap: () => {},
              )),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text.rich(TextSpan(
                            text: this.notificationAuthor + ' ',
                            style: Theme.of(context).textTheme.body1.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                  text: this.notificationAction,
                                  style: Theme.of(context).textTheme.body2)
                            ])),
                        Text(this.notificationDate,
                            style: Theme.of(context).textTheme.body2)
                      ],
                    ),
                  ),
                  Text(this.notificationText,
                      style: Theme.of(context).textTheme.body2)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ClassCarousel extends StatefulWidget {
  List<dynamic> carouselData;
  ClassCarousel(this.carouselData);
  _ClassCarouselState createState() => _ClassCarouselState();
}

class _ClassCarouselState extends State<ClassCarousel> {
  int _current = 0;
  @override
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CarouselSlider(
          height: MediaQuery.of(context).size.height * 0.25,
          items: widget.carouselData.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async{
                          Provider.of<ClassesModel>(context, listen: false)
                              .currentClassId = i['id'];
                              await Provider.of<ClassesModel>(context, listen: false).getclass();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          width: 105,
                          height: 105,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[600],
                                  offset: Offset(0, 1),
                                  blurRadius: 3),
                            ],
                            color: Theme.of(context).backgroundColor,
                            image: DecorationImage(
                                image: Image.network(i['image']).image,
                                fit: BoxFit.contain,
                                repeat: ImageRepeat.noRepeat),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(i['name'],
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(fontSize: 18)),
                            Text(i['owner']['name'],
                                style: Theme.of(context).textTheme.body2)
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }).toList(),
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        ),
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map(widget.carouselData, (index, url) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[600],
                            offset: Offset(0, 1),
                            blurRadius: 3),
                      ],
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Theme.of(context).hoverColor
                          : Theme.of(context).backgroundColor),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyClasses()));
                  },
                  child: Text('View all your classes',
                      style: Theme.of(context).textTheme.button)),
            )
          ],
        )
      ],
    );
  }
}
