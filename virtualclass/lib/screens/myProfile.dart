import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:virtualclass/models/user_model.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';

class MyProfile extends StatefulWidget {
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Map<dynamic, dynamic> userProfileInfo = {};
  Future<void> getUserInfo() async {
    userProfileInfo = await Provider.of<User>(context, listen: true).getuser();
  }
  void refreshData(){
    setState(() {
      getUserInfo();
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserInfo(),
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
                appBar: getappbar(context, 'My profile', false),
                body: SingleChildScrollView(
                  padding:
                      const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
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
                                image: Image.network(userProfileInfo['avatar'])
                                    .image,
                                fit: BoxFit.cover,
                                repeat: ImageRepeat.noRepeat),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            userProfileInfo['name'],
                            style: Theme.of(context).textTheme.body1.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            userProfileInfo['bio'] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .body2
                                .copyWith(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: MyProfileForm(userProfileInfo['name'],
                              userProfileInfo['email'], userProfileInfo['bio'] ?? '',this.refreshData),
                        )
                      ],
                    ),
                  ),
                ),
              );
          }
        });
  }
}

class MyProfileForm extends StatefulWidget {
  MyProfileForm(this.name, this.email, this.userBio,this.refreshFunc);
  String name;
  String email;
  String userBio;
  Function refreshFunc;
  _MyProfileFormState createState() => _MyProfileFormState();
}

class _MyProfileFormState extends State<MyProfileForm> {
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
                initialValue: widget.email,
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
                    widget.email = val;
                  }
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                maxLines: null,
                initialValue: widget.userBio,
                decoration: InputDecoration(
                  labelText: "Bio",
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
                
          
                  await Provider.of<User>(context, listen: true).changeUserInfo(
                      widget.name, widget.email, widget.userBio);
                  setState(() {
                    widget.refreshFunc();
                  });
                 
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
