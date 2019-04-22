import 'package:flutter/material.dart';
import 'package:internmatch/widgetLibrary/detailView_widget.dart';
import '../utils/event_helper.dart';
import '../utils/event_handler.dart';

class Home extends StatefulWidget{
  
  @override
  State createState() => new MainHome();

}

class MainHome extends State<Home> { 

   var token ;
   final eventHelper = new EventHelper();

    @mustCallSuper  
    initState(){

      eventHandler.initWebSocketConnection();
    }  

   @override
    Widget build(BuildContext context) {
        return new Scaffold(
            body: new DetailView("baseEntityDummy")
        );
  }  
}
