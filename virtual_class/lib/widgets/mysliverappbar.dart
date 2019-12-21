
import 'package:flutter/material.dart';
import 'package:virtual_class/models/settings.dart';
import 'package:virtual_class/widgets/mydrawer.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Opacity(
      child: Container(
        color: MyTheme.myTheme["screen"],
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "facebook",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                    color: MyTheme.myTheme['logo'],
                    textBaseline: TextBaseline.alphabetic),
              ),
            ),
            Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Row(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          height: 38.0,
                          width: 38.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[200], shape: BoxShape.circle),
                        ),
                        Positioned(
                          child: IconButton(
                            icon: Icon(
                              Icons.search,
                              size: 28.0,
                            ),
                            onPressed: () {
                               Navigator.pushNamed(context, '/search');
                            },
                            alignment: Alignment.center,
                            splashColor: Colors.transparent,
                          ),
                        )
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 8.0),
                        alignment: Alignment.center,
                        height: 38.0,
                        width: 38.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[200], shape: BoxShape.circle),
                        child: IconButton(
                          icon: Image.asset('assets/facebook-messenger.png',
                              height: 38.0,
                              width: 38.0,
                              alignment: Alignment.center),
                          onPressed: () {Navigator.pop(context);},
                          splashColor: Colors.transparent,
                        ))
                  ],
                ))
          ],
        ),
      ),
      opacity: (1 - shrinkOffset / expandedHeight),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
