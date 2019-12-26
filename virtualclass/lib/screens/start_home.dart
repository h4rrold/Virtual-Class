import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/classes_model.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';
import '../models/navigation_model.dart';

class MyStartPage extends StatefulWidget {
  MyStartPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyStartPageState createState() => _MyStartPageState();
}

class _MyStartPageState extends State<MyStartPage> {
  List<dynamic> _homeClassData;
  Future<void> getclasses() async {
    _homeClassData = await Provider.of<ClassesModel>(context, listen: false)
        .getSomeclasses();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Navigation>(context).setContext(context);
    // TODO: implement build
    return RefreshIndicator(
      child: FutureBuilder(
          future: getclasses(),
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
                  appBar: getappbar('Home'),
                  drawer: AppDrawer(),
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
                              NotificationList(),
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
                                    ClassCarousel(this._homeClassData)
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
      onRefresh: getclasses,
    );
  }
}

class NotificationList extends StatefulWidget {
  var notificationData;

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
          Container(
            padding: EdgeInsets.only(bottom: 12),
            child: NotificationExcerpt(
                'https://image.freepik.com/free-photo/_8353-6394.jpg',
                'Pablo Molini',
                'replied to you',
                'Hi. Today I will sent you the circuit. Be ready to start to work!',
                'today at 21:40'),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 12),
            child: NotificationExcerpt(
                'https://image.freepik.com/free-photo/_8353-6394.jpg',
                'Pablo Molini',
                'replied to you',
                'Hi. Today I will sent you the circuit. Be ready to start to work!',
                'today at 21:40'),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 12),
            child: NotificationExcerpt(
                'https://image.freepik.com/free-photo/_8353-6394.jpg',
                'Pablo Molini',
                'replied to you',
                'Hi. Today I will sent you the circuit. Be ready to start to work!',
                'today at 21:40'),
          ),
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

final List<String> imgList = [
  'https://seeklogo.com/images/F/flutter-logo-5086DD11C5-seeklogo.com.png',
  'https://seeklogo.com/images/F/flutter-logo-5086DD11C5-seeklogo.com.png',
];

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
                      Container(
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
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(i['name'],
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(fontSize: 18)),
                            Text('Sergiy Tytenko',
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
        )
      ],
    );
  }
}
