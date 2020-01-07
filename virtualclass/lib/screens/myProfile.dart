import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyProfile extends StatefulWidget {
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool loading;
  bool error = false;

  // void load(String email, String password) async{
  //   setState(() {
  //     loading = true;
  //      });
  //     var response = await Provider.of<Authorization>(context, listen: false)
  //         .signin(email: email, password: password);
  //     if (response == 401) {
  //       setState(() {
  //         error = true;
  //         loading = false;
  //       });
  //     } else {
  //       await Provider.of<Authorization>(context, listen: false)
  //           .setusertoken(response['access_token']);
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => MyStartPage()));
  //     }
   
  // }

  List<Widget> getContent() {
    if (loading)
      return [
        Center(
            child: SpinKitFadingCube(
          size: 100,
          color: Colors.white,
        ))
      ];
    else
      return [
        Container(
          child: MyProfileForm(),
        ),
     
      ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset("assets/start.jpeg").image,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
              repeat: ImageRepeat.noRepeat)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: getContent(),
      ),
    ));
  }
}

class MyProfileForm extends StatefulWidget {
  const MyProfileForm({Key key, this.refresh, this.error}) : super(key: key);

 _MyProfileFormState createState() => _MyProfileFormState();

  final Function refresh;
  final bool error;
}

class _MyProfileFormState extends State<MyProfileForm> {
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  RegExp allowedSybm = RegExp(r'^[a-zA-Z0-9]+$');
  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text('Sign in',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1)),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                errorMaxLines: 2,
                labelText: "Password",
                fillColor: Theme.of(context).backgroundColor,
                focusColor: Theme.of(context).hoverColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "Password cannot be empty";
                } else if (!allowedSybm.hasMatch(val)) {
                  return "Password can only haves latin characters and numbers";
                } else if (!(val.length >= 8)) {
                  return "Password should have at least 8 symbols";
                } else {
                  password = val;
                }
              },
              keyboardType: TextInputType.text,
            ),
          ),
          OutlineButton(
            onPressed: () {
              if (this._formKey.currentState.validate()) {
                widget.refresh(email, password);
              }
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            borderSide: BorderSide(color: Theme.of(context).hoverColor),
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
            child: Text('SIGN IN',
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
