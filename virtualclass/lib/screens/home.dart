import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/navigation_model.dart';

class ClassFeedPage extends StatefulWidget {
  int classId;
  ClassFeedPage(this.classId);
  _ClassFeedPageState createState() => _ClassFeedPageState();
}

class _ClassFeedPageState extends State<ClassFeedPage> {
  List<Map<dynamic, dynamic>> classPostData = [];
  List<Map<dynamic, dynamic>> _array = [];

  var data = [
  {
    'id': 1,
    'post_title': 'Start developing with Google Flutter',
    'user_avatar':
        'http://apeps.kpi.ua/images/teachers/%D0%A2%D0%B8%D1%82%D0%B5%D0%BD%D0%BA%D0%BE%20%D0%A1%D0%B5%D1%80%D0%B3%D1%96%D0%B9%20%D0%92%D0%BE%D0%BB%D0%BE%D0%B4%D0%B8%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B8%D1%871.jpg',
    'created_at': '2019-05-20 16:20',
    'content':
        'Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.',
    'views_amount': 12,
    'attachment_url':
        'https://www.youtube.com/watch?v=cVxEfnzw1iE',
  },
  {
    'id': 2,
    'post_title': 'Start developing with Google Flutter',
    'user_avatar':
        'http://apeps.kpi.ua/images/teachers/%D0%A2%D0%B8%D1%82%D0%B5%D0%BD%D0%BA%D0%BE%20%D0%A1%D0%B5%D1%80%D0%B3%D1%96%D0%B9%20%D0%92%D0%BE%D0%BB%D0%BE%D0%B4%D0%B8%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B8%D1%871.jpg',
    'created_at': '2019-05-20 16:20',
    'content':
        'Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.',
    'views_amount': 12,
    'attachment_url':
        'https://www.youtube.com/watch?v=cVxEfnzw1iE',
  },
  {
    'id': 3,
    'post_title': 'Start developing with Google Flutter',
    'user_avatar':
        'http://apeps.kpi.ua/images/teachers/%D0%A2%D0%B8%D1%82%D0%B5%D0%BD%D0%BA%D0%BE%20%D0%A1%D0%B5%D1%80%D0%B3%D1%96%D0%B9%20%D0%92%D0%BE%D0%BB%D0%BE%D0%B4%D0%B8%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B8%D1%871.jpg',
    'created_at': '2019-05-20 16:20',
    'content':
        'Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.',
    'views_amount': 12,
    'attachment_url':
        'https://www.youtube.com/watch?v=cVxEfnzw1iE',
  },
  {
    'id': 4,
    'post_title': 'Start developing with Google Flutter',
    'user_avatar':
        'http://apeps.kpi.ua/images/teachers/%D0%A2%D0%B8%D1%82%D0%B5%D0%BD%D0%BA%D0%BE%20%D0%A1%D0%B5%D1%80%D0%B3%D1%96%D0%B9%20%D0%92%D0%BE%D0%BB%D0%BE%D0%B4%D0%B8%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B8%D1%871.jpg',
    'created_at': '2019-05-20 16:20',
    'content':
        'Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.',
    'views_amount': 12,
    'attachment_url':
        'https://www.youtube.com/watch?v=cVxEfnzw1iE',
  },
  {
    'id': 5,
    'post_title': 'Start developing with Google Flutter',
    'user_avatar':
        'http://apeps.kpi.ua/images/teachers/%D0%A2%D0%B8%D1%82%D0%B5%D0%BD%D0%BA%D0%BE%20%D0%A1%D0%B5%D1%80%D0%B3%D1%96%D0%B9%20%D0%92%D0%BE%D0%BB%D0%BE%D0%B4%D0%B8%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B8%D1%871.jpg',
    'created_at': '2019-05-20 16:20',
    'content':
        'Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.',
    'views_amount': 12,
    'attachment_url':
        'https://www.youtube.com/watch?v=cVxEfnzw1iE',
  },
  {
    'id': 6,
    'post_title': 'Start developing with Google Flutter',
    'user_avatar':
        'http://apeps.kpi.ua/images/teachers/%D0%A2%D0%B8%D1%82%D0%B5%D0%BD%D0%BA%D0%BE%20%D0%A1%D0%B5%D1%80%D0%B3%D1%96%D0%B9%20%D0%92%D0%BE%D0%BB%D0%BE%D0%B4%D0%B8%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B8%D1%871.jpg',
    'created_at': '2019-05-20 16:20',
    'content':
        'Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.Друзі, перший запис уроку з розробки на мобільних додатків на flutter вже на каналі.',
    'views_amount': 12,
    'attachment_url':
        'https://www.youtube.com/watch?v=cVxEfnzw1iE',
  },
];

  @override
  void initState() {
    super.initState();
    classPostData = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            //controller: _scrollController,
            padding: EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
            itemCount: classPostData.length,
            itemBuilder: (context, index) {
              print(index);
              final int i = index ~/ 2;
              print(i);
              if (i >= _array.length) {
                if (classPostData.length - 1 >= i) _array.add(classPostData[i]);
                if (classPostData.length - 1 >= i + 1)
                  _array.add(classPostData[i + 1]);
                if (classPostData.length - 1 >= i + 2)
                  _array.add(classPostData[i + 2]);
              }
              print('--' + _array.length.toString());
              return Container(
                padding: EdgeInsets.only(bottom: 18.0),
                child: ClassPost(
                    _array[i]['id'],
                    _array[i]['post_title'],
                    _array[i]['user_avatar'],
                    _array[i]['created_at'],
                    _array[i]['attachment_url'],
                    _array[i]['content'],
                    _array[i]['views_amount']),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).hoverColor,
        ));
  }
}

class ClassPost extends StatefulWidget {
  ClassPost(this.postId, this.postName, this.creatorAvatar, this.createdDate,
      this.postAttachment, this.postText, this.postViewsAmount);
  int postId;
  String postName;
  String postText;
  String postAttachment;
  int postViewsAmount;
  String creatorAvatar;
  String createdDate;

  _ClassPostState createState() => _ClassPostState();
}

class _ClassPostState extends State<ClassPost> {
  YoutubePlayerController _controller;
  initState() => _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.postAttachment),
        flags: YoutubePlayerFlags(
          autoPlay: false,
          forceHideAnnotation: true,
        ),
      );
  _increaseViewAmount() => setState(() => ++widget.postViewsAmount);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 18),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey[400], offset: Offset(0, 1), blurRadius: 3),
        ],
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        children: <Widget>[
          postHeader(context),
          postContent(context),
          postFooter(context),
        ],
      ),
    );
  }

  Widget postHeader(context) => Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            UserAvatar(widget.creatorAvatar),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.postName,
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'added ' + widget.createdDate,
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget postContent(context) => Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: <Widget>[
            (widget.postAttachment.isNotEmpty)
                ? Container(
                    padding: EdgeInsets.only(bottom: 14.0),
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      topActions: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.link,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.postViewsAmount = 1;
                            });
                          },
                        )
                      ],
                    ),
                  )
                : SizedBox(width: 0, height: 0),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  (widget.postText.length > 100 ) ? widget.postText.substring(0,100) + "..." :  widget.postText,
                  style: Theme.of(context).textTheme.body2,
                ))
          ],
        ),
      );

  Widget postFooter(context) => Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(width: 1.0, color: Colors.lightBlue.shade600),
        )),
        padding: EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
                onTap: () => {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> SingleClassPostPage(widget.postId, widget.postName, widget.creatorAvatar, widget.createdDate,
      widget.postAttachment, widget.postText, widget.postViewsAmount)))
    
                        
                    },
                child: Text('VIEW MORE',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(fontSize: 14))),
            Text(widget.postViewsAmount.toString() + ' views',
                style: Theme.of(context).textTheme.body2),
          ],
        ),
      );
}

class SingleClassPostPage extends StatelessWidget {
 SingleClassPostPage(this.postId, this.postName, this.creatorAvatar, this.createdDate,
      this.postAttachment, this.postText, this.postViewsAmount);
  int postId;
  String postName;
  String postText;
  String postAttachment;
  int postViewsAmount;
  String creatorAvatar;
  String createdDate;
  @override
  Widget build(BuildContext context) {
     YoutubePlayerController _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(this.postAttachment) ,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          forceHideAnnotation: true,
        ),
      );
    return Scaffold(
       appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Some title',
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 16, left: 28),
                child: Center(
                    child: GestureDetector(
                        onTap: () => {},
                        child: UserAvatar(
                            'https://image.freepik.com/free-photo/_8353-6394.jpg'))))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
             Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 18.0,top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            UserAvatar(this.creatorAvatar),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.postName,
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'added ' + this.createdDate,
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: <Widget>[
             Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  this.postText,
                  style: Theme.of(context).textTheme.body2,
                )),
            (this.postAttachment.isNotEmpty)
                ? Container(
                    padding: EdgeInsets.only(bottom: 14,top: 14.0,left: 8.0,right:8.0),
                   child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      topActions: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.link,
                            color: Colors.red,
                          ),
                          
                        )
                      ],
                    ),
                  )
                : SizedBox(width: 0, height: 0),
           

          ],
        ),
      ),Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(width: 1.0, color: Theme.of(context).buttonColor),
        )),
        padding: EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            Text(this.postViewsAmount.toString() + ' views',
                style: Theme.of(context).textTheme.body2),
          ],
        ),
      )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
            
          },
          child: Icon(Icons.arrow_back_ios),
          backgroundColor: Theme.of(context).hoverColor,
        ));

  }
}
