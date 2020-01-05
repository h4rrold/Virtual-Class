import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/classes_model.dart';
import 'package:virtualclass/models/posts_model.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';

class ClassFeedPage extends StatefulWidget {
  int classId;
  ClassFeedPage(this.classId);
  _ClassFeedPageState createState() => _ClassFeedPageState();
}

class _ClassFeedPageState extends State<ClassFeedPage> {
  List<dynamic> classPostData = [];
  List<Map<dynamic, dynamic>> _array = [];
  var posts;

  Future<void> getPosts() async {
    var currentClassId =
        Provider.of<ClassesModel>(context, listen: false).currentClassId;
    classPostData = await Provider.of<PostsModel>(context, listen: false)
        .getPosts(currentClassId);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: FutureBuilder(
        future: getPosts(),
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
                  body: ListView.builder(
                      //controller: _scrollController,
                      padding:
                          EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
                      itemCount: classPostData.length,
                      itemBuilder: (context, index) {
                        print(index);
                        final int i = index ~/ 2;
                        print(i);
                        if (i >= _array.length) {
                          if (classPostData.length - 1 >= i)
                            _array.add(classPostData[i]);
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
                              _array[i]['title'],
                              _array[i]['user']['avatar'],
                              _array[i]['created_at'],
                              '',
                              _array[i]['content'],
                              Random().nextInt(30),
                            ));
                      }),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.add),
                    backgroundColor: Theme.of(context).hoverColor,
                  ));
          }
        },
      ),
      onRefresh: getPosts,
    );
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
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  (widget.postText.length > 100)
                      ? widget.postText.substring(0, 100) + "..."
                      : widget.postText,
                  style: Theme.of(context).textTheme.body2,
                  textAlign: TextAlign.left,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleClassPostPage(
                                  widget.postId,
                                  widget.postName,
                                  widget.creatorAvatar,
                                  widget.createdDate,
                                  widget.postAttachment,
                                  widget.postText,
                                  widget.postViewsAmount)))
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
  SingleClassPostPage(
      this.postId,
      this.postName,
      this.creatorAvatar,
      this.createdDate,
      this.postAttachment,
      this.postText,
      this.postViewsAmount);
  int postId;
  String postName;
  String postText;
  String postAttachment;
  int postViewsAmount;
  String creatorAvatar;
  String createdDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 18.0, top: 12),
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
                            style: Theme.of(context).textTheme.body1.copyWith(
                                fontSize: 17, fontWeight: FontWeight.w500),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        this.postText,
                        style: Theme.of(context).textTheme.body2,
                        textAlign: TextAlign.left,
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                    width: 1.0, color: Theme.of(context).buttonColor),
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
