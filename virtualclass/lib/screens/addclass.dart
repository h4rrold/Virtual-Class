import 'package:flutter/material.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';



class ClassCreatePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getappbar('Create'),
        body: SingleChildScrollView(
      padding: EdgeInsets.only(top:12.0,left:8.0,right: 8.0,bottom: 14),
      child: Column(
        children:[
          Center(child: Text('Create class',style: Theme.of(context).textTheme.body1.copyWith(fontSize: 24,fontWeight: FontWeight.w500))),
          Container(
            child: Column(
              children: <Widget>[
                ClassCreateForm()
              ],
            ),
          )

        ]
      ),
    )
    );
  }

}
class ClassCreateForm extends StatefulWidget{
  _ClassCreateFormState createState() => _ClassCreateFormState();
}
class _ClassCreateFormState extends State<ClassCreateForm>{
 final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Container(
        
        padding:EdgeInsets.only(top: 12),
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
                  }
                  else if (val.length < 3){
                    return "Class name must have at least 3 symbols";
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
                maxLines: null,
                
                decoration: InputDecoration(
                  labelText: "Class bio",
                  helperText: 'If class don\'t have bio, leave this field empty',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                validator: (val) {
                    return null;
                },
                keyboardType: TextInputType.multiline,
                
              ),
            ),     
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: RaisedButton(
               child:
                 Text( 'Select class image')
               
               
              )

            ),
           
            OutlineButton(
              onPressed: () => (this._formKey.currentState.validate()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
              ),
              borderSide: BorderSide(color: Theme.of(context).hoverColor),
              padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
              child: Text('CREATE',
                  style: Theme.of(context).textTheme.button.copyWith(fontSize: 14)),
            )
          ],
        ),
      ),
    );
  
  }

}
