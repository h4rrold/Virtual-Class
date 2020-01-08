import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/classes_model.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';

class ClassCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getappbar(context,'Create', true),
        body: SingleChildScrollView(
          padding:
              EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0, bottom: 14),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
            Center(
                child: Text('Create class',
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 24, fontWeight: FontWeight.w500))),
            Container(
              height:  500,
              child: ClassCreateForm(),
            )
          ]),
        ));
  }
}

class ClassCreateForm extends StatefulWidget {
  _ClassCreateFormState createState() => _ClassCreateFormState();
}

class _ClassCreateFormState extends State<ClassCreateForm> {
  bool loading = false;

  String name;
  String bio;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (!loading)
      return Form(
        key: this._formKey,
        child: Container(
          padding: EdgeInsets.only(top: 12),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Class name",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Class cannot be empty";
                    } else if (val.length < 3) {
                      return "Class name must have at least 3 symbols";
                    } else {
                      name = val;
                    }
                  },
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: "Class bio",
                    helperText:
                        'If class don\'t have bio, leave this field empty',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  validator: (val) {
                    bio = val;
                  },
                  keyboardType: TextInputType.multiline,
                ),
              ),
              OutlineButton(
                onPressed: () async {
                  if (this._formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    var response =
                        await Provider.of<ClassesModel>(context, listen: false)
                            .addclass(name, bio);
                    if (response != 400)
                      Navigator.pop(context);
                    else
                      setState(() {
                        loading = false;
                      });
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                borderSide: BorderSide(color: Theme.of(context).hoverColor),
                padding:
                    EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
                child: Text('CREATE',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(fontSize: 14)),
              )
            ],
          ),
        ),
      );
    else
      return Center(
        child: SpinKitFadingCube(
          size: 100,
          color: Colors.blue,
        ),
      );
  }
}
