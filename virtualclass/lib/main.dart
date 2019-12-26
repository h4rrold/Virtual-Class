import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/models/classes_model.dart';
import 'package:virtualclass/screens/signin.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';
import 'main_screen.dart';
import 'models/authorization.dart';
import 'models/model_app_settings.dart';
import 'models/navigation_model.dart';
import 'models/posts_model.dart';
import 'screens/start_home.dart';

void main() {
  runApp(MultiProvider(
    providers: <SingleChildCloneableWidget>[
      ChangeNotifierProvider(create: (context) => AppSettingsModel()),
      ChangeNotifierProvider(create: (context) => Navigation()),
      ChangeNotifierProvider(create: (context) => Authorization()),
      ChangeNotifierProvider(create: (context) => ClassesModel()),
      ChangeNotifierProvider(create: (context) => PostsModel()),
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
    
    if (await Provider.of<Authorization>(context, listen: false).check())
      body = MyStartPage(
        title: 'Home',
      );
    else
      body = SignIn();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]);
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getappbar(widget.title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Provider.of<Navigation>(context).setText('UUUUURRRAA');
                Provider.of<Navigation>(context).setCount(20);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return MainScreen();
                }));
              },
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
