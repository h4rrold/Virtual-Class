import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/main_screen.dart';
import 'package:virtualclass/models/classes_model.dart';
import 'package:virtualclass/models/navigation_model.dart';
import 'package:virtualclass/models/user_model.dart';
import 'package:virtualclass/screens/postAdd.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';

class ClassSettings extends StatefulWidget {
  _ClassSettingState createState() => _ClassSettingState();
}

class _ClassSettingState extends State<ClassSettings> {
  Map<dynamic, dynamic> _classData = {};
  List<dynamic> _classMembers = [];
  int _classId;
  Future<void> _getData() async {
    this._classId =
        Provider.of<ClassesModel>(context, listen: false).currentClassId;
    _classData = await Provider.of<ClassesModel>(context, listen: false)
        .getclass();
    _classMembers = await Provider.of<ClassesModel>(context, listen: false)
        .getClassMembers(this._classId);
  }
  void refresh(){
    setState(() {
      _getData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
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
            return Scaffold(
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.32,
                          height: MediaQuery.of(context).size.width * 0.32,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400],
                                  offset: Offset(0, 1),
                                  blurRadius: 3),
                            ],
                            image: DecorationImage(
                                image: Image.network(this._classData['image'])
                                    .image,
                                fit: BoxFit.cover,
                                repeat: ImageRepeat.noRepeat),
                            shape: BoxShape.circle,
                          ),
                        ),
                        (Provider.of<User>(context,listen: false).user['id'] == this._classData['owner_id']) ? Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ClassDataForm( this._classId,this._classData['name'],this._classData['description'],this.refresh)
                        ) : Container(
                          child: Column(
                            children: <Widget>[
                          Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            this._classData['name'] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .body2
                                .copyWith(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            this._classData['description'] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .body2
                                .copyWith(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                            ],
                          ),
                        ),
                       
                        
                        (Provider.of<User>(context,listen: false).user['id'] == this._classData['owner_id']) ? Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
                             return AddMemberScreen(_classId);
                            })),
                            child: Text('ADD MEMBER',
                                style: Theme.of(context).textTheme.button.copyWith(fontSize: 16)),
                          ),
                        ) : Container(),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                             boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400],
                                  offset: Offset(0, 1),
                                  blurRadius: 3),
                            ],
                             color: Theme.of(context).backgroundColor,
                          ),
                         
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              separatorBuilder: (context, index) => Divider(
                                    height: 0,
                                  ),
                              itemCount: this._classMembers.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  //color: Theme.of(context).backgroundColor,
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  //color: Theme.of(context).backgroundColor,
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16.0),
                                      child: UserAvatar(
                                          this._classMembers[index]['avatar']),
                                    ),
                                    Text(
                                      this._classMembers[index]['name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .body2
                                          .copyWith(
                                              fontSize: 17,
                                              fontWeight: FontWeight.normal),
                                    ),
                                  ]),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
        }
      },
    );
  }
}


class AddMemberScreen extends StatefulWidget{
  int classId;
  AddMemberScreen(this.classId);
  _AddMemberScreenState createState() => _AddMemberScreenState();

}
class _AddMemberScreenState extends State<AddMemberScreen>{
  bool loading = false;
  bool error = false;
void load(String email) async {
    setState(() {
      loading = true;
    });
    var response = await Provider.of<ClassesModel>(context,listen: false).setClassMembers(widget.classId, email);
    if (response == 401) {
      setState(() {
        error = true;
        loading = false;
      });
    } else {
    Navigator.pop(context);
    }
  }

  Widget getContent() {
    if (loading)
      return 
        Center(
            child: SpinKitFadingCube(
          size: 100,
          color: Colors.white,
        ));
    else return AddMemberForm(refresh:load,error:error);
    
 



}
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getContent(),
    );
  }
}

class AddMemberForm extends StatefulWidget {
  const AddMemberForm({Key key, this.refresh, this.error}) : super(key: key);

  _AddMemberFormState createState() => _AddMemberFormState();

  final Function refresh;
  final bool error;
}

class _AddMemberFormState extends State<AddMemberForm> {
  String email;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
                fillColor: Theme.of(context).backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "Email cannot be empty";
                } else if (!val.contains('@')) {
                  return 'Enter correct email';
                } else {
                  email = val;
                }
              },
              keyboardType: TextInputType.emailAddress,
            ),
          ),

          OutlineButton(
            onPressed: () {
              if (this._formKey.currentState.validate()) {
                widget.refresh(email);
              }
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            borderSide: BorderSide(color: Theme.of(context).hoverColor),
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
            child: Text('SUBMIT',
                style:
                    Theme.of(context).textTheme.button.copyWith(fontSize: 14)),
          ),
          widget.error == false
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    'The user credentials were incorrect',
                    style: TextStyle(color: Colors.red),
                  ),
                )
        ],
      ),
    );
  }
}

class ClassDataForm extends StatefulWidget {
  ClassDataForm(this.classId,this.name,this.userBio,this.refreshFunc);
  String name;
  String userBio;
  int classId;
  Function refreshFunc;
  _ClassDataFormState createState() => _ClassDataFormState();
}

class _ClassDataFormState extends State<ClassDataForm> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  RegExp allowedSybm = RegExp(r'^[a-zA-Z0-9]+$');
  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return Form(
        key: this._formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                initialValue: widget.name,
                decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return "Name cannot be empty";
                  } else {
                    widget.name = val;
                  }
                },
                keyboardType: TextInputType.text,
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                maxLines: null,
                initialValue: widget.userBio,
                decoration: InputDecoration(
                  labelText: "Class bio",
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                validator: (val) {
                  widget.userBio = val;
                },
                keyboardType: TextInputType.multiline,
              ),
            ),
            OutlineButton(
              onPressed: () async {
                if (this._formKey.currentState.validate()) {
                  await Provider.of<ClassesModel>(context, listen: true).updateClassData(widget.classId,
                      widget.name, widget.userBio);
                      await Provider.of<ClassesModel>(context, listen: false).getclass();
                  Navigator.pushReplacement(Provider.of<Navigation>(context,listen: false).mainacontext, MaterialPageRoute(builder: (context)=>MainScreen()));

                 
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              borderSide: BorderSide(color: Theme.of(context).hoverColor),
              padding:
                  EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
              child: Text('SAVE CHANGES',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontSize: 14)),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: SpinKitFadingCube(
          size: 100,
          color: Colors.blue,
        ),
      );
    }
  }
}