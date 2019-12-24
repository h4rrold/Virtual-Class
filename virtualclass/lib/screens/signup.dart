import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:virtualclass/screens/signin.dart';

class SignUp extends StatefulWidget {
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.network(
                        'https://static.locals.md/2019/11/photo-1519389950473-47ba0277781c.jpeg')
                    .image,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.darken),
                repeat: ImageRepeat.noRepeat)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding:
                  EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400],
                      offset: Offset(0, 1),
                      blurRadius: 3),
                ],
              ),
              child: SignInForm(),
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
                                        builder: (BuildContext context) =>
                                            SignIn()));
                              })
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class SignInForm extends StatefulWidget {
  _SignInFormState createState() => _SignInFormState();
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
              child: Text('Sign up',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1)),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Firstname",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "Firstname cannot be empty";
                } else {
                  return null;
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
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return "Lastname cannot be empty";
                } else {
                  return null;
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
              this._formKey.currentState.validate();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            borderSide: BorderSide(color: Theme.of(context).hoverColor),
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
            child: Text('SIGN UP',
                style:
                    Theme.of(context).textTheme.button.copyWith(fontSize: 14)),
          )
        ],
      ),
    );
  }
}
