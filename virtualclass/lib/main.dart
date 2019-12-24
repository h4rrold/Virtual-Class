import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtualclass/widgets/mydrawerappbar.dart';
import 'main_screen.dart';
import 'models/drawer_pages.dart';
import 'models/model_app_settings.dart';
import 'models/navigation_model.dart';
import 'screens/start_home.dart';

void main() => runApp(MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider(create: (context) => AppSettingsModel()),
        ChangeNotifierProvider(create: (context) => Navigation()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsModel>(builder: (context, model, _child) {
      //print('тема ' + model.getTheme.toString());
      return FutureBuilder(
          future: model.getSavedTheme(),
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
                  title: 'Flutter Demo',
                  theme: model.getTheme,
                  home: MyStartPage(
                    title: 'Home',
                  ),
                );
            }
          });
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: getappbar(widget.title),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
