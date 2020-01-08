import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/classes_model.dart';
import 'package:virtualclass/screens/signin.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';
import 'main_screen.dart';
import 'models/authorization.dart';
import 'models/model_app_settings.dart';
import 'models/navigation_model.dart';
import 'models/notifications_model.dart';
import 'models/posts_model.dart';
import 'models/user_model.dart';
import 'screens/start_home.dart';

void main() {
  runApp(MultiProvider(
    providers: <SingleChildCloneableWidget>[
      ChangeNotifierProvider(create: (context) => AppSettingsModel()),
      ChangeNotifierProvider(create: (context) => Navigation()),
      ChangeNotifierProvider(create: (context) => Authorization()),
      ChangeNotifierProvider(create: (context) => ClassesModel()),
      ChangeNotifierProvider(create: (context) => PostsModel()),
      ChangeNotifierProvider(create: (context) => User()),
      ChangeNotifierProvider(create: (context) => NotificationsModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  Widget body;
  Future<Widget> checkData(BuildContext context) async {
    await Provider.of<AppSettingsModel>(context, listen: false).getSavedTheme();
    //await Provider.of<Authorization>(context, listen: false).deletetoken();
    //await Provider.of<Authorization>(context, listen: false).setusertoken('qwerty');

    if (await Provider.of<Authorization>(context, listen: false).check()) {
      await Provider.of<User>(context, listen: false).getuser();
      body = MyStartPage(
        title: 'Home',
      );
    } else
      body = SignIn();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Consumer<Authorization>(builder: (context, model, _child) {
      //print('тема ' + model.getTheme.toString());
      return FutureBuilder(
          future: checkData(context),
          builder: (context, snapshot) {
            // if (!snapshot.hasData) {
            //   return Container(
            //     color: Colors.white,
            //     child: Center(
            //         child: SizedBox(
            //             height: 200.0,
            //             width: 200.0,
            //             child: CircularProgressIndicator(
            //                 valueColor: AlwaysStoppedAnimation(Colors.blue),
            //                 strokeWidth: 1.0))),
            //   );
            // } else if (snapshot.hasData) {
            // return MaterialApp(
            //   debugShowCheckedModeBanner: false,
            //   title: 'Flutter Demo',
            //   theme: model.getTheme,
            //   home: MyStartPage(
            //     title: 'Home',
            //   ),
            // );
            // } else if (snapshot.hasError) {
            //   return Text("${snapshot.error}");
            // }

            // if(snapshot.hasData) return MaterialApp(
            //     debugShowCheckedModeBanner: false,
            //     title: 'Flutter Demo',

            //     theme: model.getTheme,
            //     home: MyStartPage(
            //       title: 'Home',
            //     ),
            //   );
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
                  color: Colors.white,
                  child: Center(
                      child: SizedBox(
                          height: 200.0,
                          width: 200.0,
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.blue),
                              strokeWidth: 1.0))),
                );

              case ConnectionState.done:

                ///task is complete with an error (eg. When you
                ///are offline)
                if (snapshot.hasError)
                  return Text(
                    'Error:\n\n${snapshot.error}',
                    textAlign: TextAlign.center,
                  );

                ///task is complete with some data
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Virtual Class',
                  theme: Provider.of<AppSettingsModel>(context).getTheme,
                  //theme: model.getTheme,
                  home: body,
                );
            }
          });
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  File _image;
  
  


Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);


    setState(() {
      _image = image;
    });
  }
  // Future<dynamic> getI()async{
  //   return await _fimage.readAsString();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getappbar(context, widget.title, true),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            :Image.file(_image)
            //: Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
