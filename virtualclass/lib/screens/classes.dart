import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/main_screen.dart';
import 'package:virtualclass/models/classes_model.dart';
import 'package:virtualclass/screens/addclass.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';

class MyClasses extends StatefulWidget {
  _MyClassesState createState() => _MyClassesState();
}

class _MyClassesState extends State<MyClasses> {
  Future<void> getclasses() async {
    _userClassesData =
        await Provider.of<ClassesModel>(context, listen: false).getclasses();
  }

  List<dynamic> _userClassesData;

  @override
  Widget build(BuildContext context) {
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

                if (snapshot.hasError)
                  return Text(
                    'Error:\n\n${snapshot.error}',
                    textAlign: TextAlign.center,
                  );

                ///task is complete with some data
                return Scaffold(
                    appBar: getappbar(context,'My classes'),
                    body: (_userClassesData.isNotEmpty) ? Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          itemCount: _userClassesData.length,
                          itemBuilder: (context, int index) => UserClassItem(
                              _userClassesData[index]['id'],
                              _userClassesData[index]['name'],
                              _userClassesData[index]['owner']['name'],
                              _userClassesData[index]['image'],
                              index),
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.count(index % 3 != 0 ? 1 : 2, 1),
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 10.0,
                        )
                        ) : Center(
                         
                          child: Text(
                                              'Sorry, you don’t have any classes yet.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body2
                                                  .copyWith(fontSize: 16),
                                                  textAlign: TextAlign.center,
                                            ),
                        ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ClassCreatePage();
                        }));
                      },
                      child: Icon(Icons.add),
                      backgroundColor: Theme.of(context).hoverColor,
                    ));
            }
            ;
          }),
      onRefresh: getclasses,
    );
  }
}

class UserClassItem extends StatelessWidget {
  final int _itemIndex;
  final int _classId;
  final String _classOwnerName;
  final String _className;
  final String _classImage;
  UserClassItem(this._classId, this._className, this._classOwnerName,
      this._classImage, this._itemIndex);
  @override
  // Depending on index this widget will build differently
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<ClassesModel>(context, listen: false).currentClassId = this._classId;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      },
      child: (this._itemIndex % 3 != 0)
          ? Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[600],
                      offset: Offset(0, 1),
                      blurRadius: 3),
                ],
                color: Theme.of(context).backgroundColor,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 24.0, bottom: 12.0, left: 12.0, right: 12.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Image.network(this._classImage).image,
                          fit: BoxFit.contain,
                          repeat: ImageRepeat.noRepeat,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(this._className,
                            style: Theme.of(context).textTheme.body1.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                        Text(this._classOwnerName,
                            style: Theme.of(context).textTheme.body2)
                      ],
                    ),
                  ),
                ],
              ))
          : Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[600],
                      offset: Offset(0, 1),
                      blurRadius: 3),
                ],
                color: Theme.of(context).backgroundColor,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 18.0,bottom: 55.00),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: Image.network(this._classImage).image,
                      fit: BoxFit.contain,
                      repeat: ImageRepeat.noRepeat,
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.0, left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(this._className,
                            style: Theme.of(context).textTheme.body1.copyWith(
                                fontSize: 23, fontWeight: FontWeight.w500)),
                        Text(this._classOwnerName,
                            style: Theme.of(context).textTheme.body2)
                      ],
                    ),
                  ),
                ],
              )),
    );
  }
}
