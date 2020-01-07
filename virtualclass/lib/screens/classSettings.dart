import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';




class ClassSettings extends StatelessWidget {
  String classTitle;
  String classImage;
  String classBio;
  List<Map<dynamic, dynamic>> classMembers;
  ClassSettings(
      this.classTitle, this.classImage, this.classBio, this.classMembers);
  @override
  Widget build(BuildContext context) {
    Widget classInfo() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.32,
              height: MediaQuery.of(context).size.width * 0.32,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400],
                      offset: Offset(0, 1),
                      blurRadius: 3),
                ],
                image: DecorationImage(
                    image: Image.network(this.classImage).image,
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat),
                shape: BoxShape.circle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                this.classTitle,
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                this.classBio,
                style: Theme.of(context).textTheme.body2.copyWith(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    }

    Widget classNotification() {
      return Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400], offset: Offset(0, 1), blurRadius: 3),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.notifications_active,
                    color: Theme.of(context).accentColor,
                    size: 22,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.0),
                    child: Text(
                      'Notifications',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            NotificationSwitch()
          ],
        ),
      );
    }

    Widget membersList() {
      const int _lazyAmount = 6;
      List<Map<dynamic, dynamic>> _lazyArray = [];
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
             boxShadow: [
            BoxShadow(
                color: Colors.grey[400], offset: Offset(0, 1), blurRadius: 3),
          ],
          ),
          margin: EdgeInsets.only(top:16.0),
          
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
              separatorBuilder: (context, index) => Divider(height: 0,
      ),
              itemCount: classMembers.length,
              itemBuilder: (context, index) {
                if (index >= _lazyArray.length) {
                  for (int j = 0; j < _lazyAmount; j++) {
                    if (classMembers.length - 1 >= index + j) {
                      _lazyArray.add(classMembers[index + j]);
                    }
                  }
                }
                return Container(
                  //color: Theme.of(context).backgroundColor,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  //color: Theme.of(context).backgroundColor,
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: UserAvatar(_lazyArray[index]['avatar']),
                    ),
                    Text(_lazyArray[index]['name'],style: Theme.of(context).textTheme.body2.copyWith(fontSize:17,fontWeight: FontWeight.normal),),
                  ]),
                );
              }),
        ),
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[classInfo(), classNotification(), membersList()],
        ),
      ),
    );
  }
}

class NotificationSwitch extends StatefulWidget {
  @override
  _NotificationSwitch createState() => _NotificationSwitch();
}

class _NotificationSwitch extends State<NotificationSwitch> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Switch(
          value: _value, onChanged: (value) => setState(() => _value = value)),
    );
  }
}
