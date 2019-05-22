import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:internmatch/utils/app_auth_helper.dart';
import 'package:internmatch/widgetLibrary/detailView_widget.dart';
import '../utils/event_helper.dart';
import '../utils/event_handler.dart';
import '../utils/app_auth_helper.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new MainHome();
}

class MainHome extends State<Home> {
  final eventHelper = new EventHelper();

   /* @mustCallSuper
  initState() {
    eventHandler.initWebSocketConnection();
  } */
 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Internmatch"),
      ),
      body: new Container(
       constraints: BoxConstraints.expand(),
       color: Colors.tealAccent,
       child: Stack (
         alignment: AlignmentDirectional.center,
         children: <Widget>[
           Container(
                height: 200.0,
                width: 200.0,
                color: Colors.red,
              ),
              Container(
                height: 150.0,
                width: 150.0,
                color: Colors.blue,
              ),
              Container(
                height: 100.0,
                width: 100.0,
                color: Colors.green,
              ),
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.yellow,
              ),
         ],
       )

       
      ),
    );
  }
 
}
