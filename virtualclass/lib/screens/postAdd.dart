import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:virtualclass/models/posts_model.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
class ClassAddPostPage extends StatelessWidget{
  int classId;
  ClassAddPostPage(this.classId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
      padding: EdgeInsets.only(top:12.0,left:8.0,right: 8.0,bottom: 14),
      child: Column(
        children:[
          Center(child: Text('Add post in Flutter Class',style: Theme.of(context).textTheme.body1.copyWith(fontSize: 18))),
          Container(
            child: Column(
              children: <Widget>[
                AddPostForm(this.classId)
              ],
            ),
          )

        ]
      ),
    )
    );
  }

}
class AddPostForm extends StatefulWidget{
  int classId;
  AddPostForm(this.classId);
  _AddPostFormState createState() => _AddPostFormState();
}
class _AddPostFormState extends State<AddPostForm>{
  bool loading = false;
  String postTitle;
  String postText;
  String attachmentUrl;
 final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if(!loading)
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
                  labelText: "Post title",
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return "Post title cannot be empty";
                  
                  } else {
                   this.postTitle = val;
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
                  labelText: "Post text",
                  
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                validator: (val) {
                   this.postText = val;
                },
                keyboardType: TextInputType.multiline,
                
              ),
            ),     
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Attachment url",
                  helperText: 'If post don\'t have attachment, leave this field empty',
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                validator: (val) {
    
                  this.attachmentUrl = val;
                  
                },
                keyboardType: TextInputType.url,
              ),
            ),
           
            OutlineButton(
              onPressed: () async  {
                if(this._formKey.currentState.validate()){
                  setState(() => loading = true);
                  var response =
                        await Provider.of<PostsModel>(context, listen: false)
                            .addPost(widget.classId,this.postTitle,this.postText,this.attachmentUrl);
                   
                    if (response != 400)
                      Navigator.pop(context);
                    else
                      setState(() {
                        loading = false;
                      });
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
              ),
              borderSide: BorderSide(color: Theme.of(context).hoverColor),
              padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
              child: Text('PUBLISH',
                  style: Theme.of(context).textTheme.button.copyWith(fontSize: 14)),
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
