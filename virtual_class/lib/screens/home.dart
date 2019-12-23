import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/model_app_settings.dart';
import '../models/test_model.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  Random random = new Random();
  BoxShape shap = BoxShape.circle;
  bool temp;



  @override
  Widget build(BuildContext context) {
    this.temp = Provider.of<Navigation>(context, listen: false).val;
    print('rebuild Home');
    return Scaffold(
      // drawer: AppDrawer(),
      // appBar: AppBar(
      //   actions: <Widget>[
      //     Center(
      //       child: Padding(
      //         padding: const EdgeInsets.only(right: 20),
      //         child: Container(
      //           width: 40,
      //           height: 40,
      //           decoration: BoxDecoration(
      //             //color: Colors.red,
      //             image: DecorationImage(image: Image.asset("assets/xkml4m51.png").image,fit: BoxFit.contain),
      //           shape: BoxShape.circle),
      //         ),
      //       ),
      //     )
      //   ],
      //   // title: 'Text(Provider.of<Test>(context).text?? 'AAAAA')',
      //   title: Text('Class'),
      // ),
      //backgroundColor: MyTheme.myTheme['screen'],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5.0),
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              shape: shap,
                              image: DecorationImage(
                                  image:
                                      Image.asset("assets/xkml4m51.png").image,
                                  fit: BoxFit.cover,
                                  repeat: ImageRepeat.noRepeat)),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                onChanged: (bool value) {
                                  setState(() {
                                    Provider.of<Navigation>(context, listen: false).setBool(value);
                                  });
                                },
                                value: temp,
                              ),
                              Text("Що у вас нового?" + temp.toString(),
                                  style: TextStyle(
                                      fontSize: 16.0
                                      //color: MyTheme.myTheme["maintext"]
                                      )),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 0.4,
                                color: Colors.grey,
                                style: BorderStyle.solid)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                height: 25.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 0.4,
                                          color: Colors.grey,
                                          style: BorderStyle.solid)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.red,
                                      size: 20.0,
                                    ),
                                    SizedBox(
                                      width: 3.0,
                                    ),
                                    Text(
                                      "Ефір",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          //color: MyTheme.myTheme["maintext"]
                                          ),
                                    )
                                  ],
                                )),
                          ),
                          Expanded(
                              child: Container(
                                  height: 25.0,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 0.4,
                                            color: Colors.grey,
                                            style: BorderStyle.solid)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.photo_library,
                                        color: Colors.green,
                                        size: 20.0,
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        "Фото",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                           // color: MyTheme.myTheme["maintext"]
                                            ),
                                      )
                                    ],
                                  ))),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.location_on,
                                          color: Colors.pink, size: 20.0),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        "Відмітки",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            //color: MyTheme.myTheme["maintext"]
                                            ),
                                      )
                                    ],
                                  )))
                        ],
                      ),
                    ),
                    Container(
                      //color: MyTheme.myTheme["sizedbox"],
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SliverFixedExtentList(
            itemExtent: 500.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(image: DecorationImage(image: Image.asset("assets/xkml4m51.png").image)),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        
                        IconButton(
                          icon: Icon(Icons.notifications),
                          onPressed: () {
                            Navigator.pushNamed(context, '/notifications');
                          },
                          
                        ),
                        IconButton(
                          icon: Icon(Icons.exit_to_app),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          
                        ),
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            
                          },
                          
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: Provider.of<Navigation>(context, listen: false).count??5,
            ),
          ),
        ],
      ),
    );
  }
}
