import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';

class MyClasses extends StatefulWidget {
  _MyClassesState createState() => _MyClassesState();
}

class _MyClassesState extends State<MyClasses> {
  List<int> _userClassesId = [12, 32, 12, 42, 122, 1111];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: getappbar('My classes'),
        body: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: _userClassesId.length,
            itemBuilder: (context, int index) =>
                UserClassItem(_userClassesId[index], index),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(index % 3 != 0 ? 1 : 2, 1),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 10.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
      },
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).hoverColor,
    ),
       );
  }
}

class UserClassItem extends StatelessWidget {
  final int _itemIndex;
  final int _classId;
  UserClassItem(this._classId, this._itemIndex);
  @override
  // Depending on index this widget will build differently
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: (this._itemIndex % 3 != 0)
          ? Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400],
                      offset: Offset(0, 1),
                      blurRadius: 3),
                ],
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 24.0, bottom: 12.0, left: 12.0, right: 12.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Image.network(
                                  'https://seeklogo.com/images/F/flutter-logo-5086DD11C5-seeklogo.com.png')
                              .image,
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
                        Text('Flutter class',
                            style: Theme.of(context).textTheme.body1.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text('Sergiy Tytenko',
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
                      color: Colors.grey[400],
                      offset: Offset(0, 1),
                      blurRadius: 3),
                ],
                color: Colors.white,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 24.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/1200px-React-icon.svg.png')
                            .image,
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
                        Text('Flutter class',
                            style: Theme.of(context).textTheme.body1.copyWith(
                                fontSize: 23, fontWeight: FontWeight.w500)),
                        Text('Sergiy Tytenko',
                            style: Theme.of(context).textTheme.body2)
                      ],
                    ),
                  ),
                ],
              )),
    );
  }
}
