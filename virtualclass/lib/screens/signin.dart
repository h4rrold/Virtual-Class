import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/main_screen.dart';
import 'package:virtualclass/models/authorization.dart';
import 'package:virtualclass/screens/signup.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:virtualclass/screens/start_home.dart';

class SignIn extends StatefulWidget {
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading;

  void load() {
    setState(() {
      loading = true;
      Provider.of<Authorization>(context, listen: false).test().then((_) {
        setState(() {
          loading = false;
          Provider.of<Authorization>(context, listen: false)
              .setusertoken('qwerty');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyStartPage()));
        });
      });
    });
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
      return [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400], offset: Offset(0, 1), blurRadius: 3),
            ],
          ),
          child: SignInForm(
            refresh: load,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: RichText(
              text: TextSpan(
                  text: 'Don\'t have an acount? ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  children: [
                    TextSpan(
                        text: 'Sing up',
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
                                        SignUp()));
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

class SignInForm extends StatefulWidget {
  const SignInForm({Key key, this.refresh}) : super(key: key);

  _SignInFormState createState() => _SignInFormState();

  final Function refresh;
}

class _SignInFormState extends State<SignInForm> {
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
                fillColor: Colors.white,
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
                  return null;
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
                fillColor: Colors.white,
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
                  return null;
                }
              },
              keyboardType: TextInputType.text,
            ),
          ),
          OutlineButton(
            onPressed: () {
              if (this._formKey.currentState.validate()) {
                widget.refresh();
              }
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            borderSide: BorderSide(color: Theme.of(context).hoverColor),
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
            child: Text('SIGN IN',
                style:
                    Theme.of(context).textTheme.button.copyWith(fontSize: 14)),
          )
        ],
      ),
    );
  }
}
