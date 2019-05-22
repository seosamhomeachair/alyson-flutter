import 'package:flutter/material.dart';
import '../utils/event_helper.dart';
import '../utils/event_handler.dart';

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
            onPressed: (() => {eventHandler.initWebSocketConnection()}),
          ),
        ),
      ),
    );
  }
 
}
