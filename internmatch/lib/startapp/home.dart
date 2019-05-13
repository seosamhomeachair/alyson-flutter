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

  @mustCallSuper
  initState() {
    eventHandler.initWebSocketConnection();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Internmatch"),
      ),
      body: new Container(
        child: Center(
          child: RaisedButton(
            child: Text("click here"),
            onPressed: (() => {}),
          ),
        ),
      ),
    );
  }
 
}
