import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/authorization.dart';
import 'package:virtualclass/models/user_model.dart';
import 'package:virtualclass/screens/signin.dart';
import 'package:virtualclass/screens/start_home.dart';

class SignUp extends StatefulWidget {
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading;
  bool error = false;

  void load(String name, String email, String password) async {
    setState(() {
      loading = true;
    });
    var response = await Provider.of<Authorization>(context, listen: false)
        .signup(name: name, email: email, password: password);

    if (response is int) {
      setState(() {
        error = true;
        loading = false;
      });
    } else {
      await Provider.of<Authorization>(context, listen: false)
          .setusertoken(response['access_token']);
      await Provider.of<User>(context, listen: false).getuser();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyStartPage()));
    }
  }

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
      return <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[600], offset: Offset(0, 1), blurRadius: 3),
            ],
          ),
          child: SignUpForm(
            refresh: load,
            error: error,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: RichText(
              text: TextSpan(
                  text: 'Already have account? ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  children: [
                    TextSpan(
                        text: 'Sing in',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (BuildContext context) =>
                                        SignIn()));
                          })
                  ]),
            ),
          ),
        )
      ];
  }

  @override
  void initState() {
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset('assets/start.jpeg').image,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.darken),
                repeat: ImageRepeat.noRepeat)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getContent()),
      ),
    ));
  }
}

class SignUpForm extends StatefulWidget {
  final Function refresh;
  final bool error;

  const SignUpForm({Key key, this.refresh, this.error}) : super(key: key);
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String firstname;
  String lastname;
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
              child: Text('Sign up',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1)),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Firstname",
                fillColor: Theme.of(context).backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "Firstname cannot be empty";
                } else {
                  this.firstname = val;
                }
              },
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Lastname",
                fillColor: Theme.of(context).backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "Lastname cannot be empty";
                } else {
                  this.lastname = val;
                }
              },
              keyboardType: TextInputType.text,
            ),
          ),
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
                  this.email = val;
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
                  this.password = val;
                }
              },
              keyboardType: TextInputType.text,
            ),
          ),
          OutlineButton(
            onPressed: () {
              if (this._formKey.currentState.validate()) {
                widget.refresh(this.lastname + " " + this.firstname, this.email,
                    this.password);
              }
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            borderSide: BorderSide(color: Theme.of(context).hoverColor),
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
            child: Text('SIGN UP',
                style:
                    Theme.of(context).textTheme.button.copyWith(fontSize: 14)),
          ),
          widget.error == false
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    'The email has already been taken',
                    style: TextStyle(color: Colors.red),
                  ),
                )
        ],
      ),
    );
  }
}
