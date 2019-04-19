import 'package:flutter/material.dart';
import 'login_to_keycloak.dart';
import '../widgetLibrary/splash_widget.dart';

class StartApp extends StatefulWidget {
  final Widget child; 

  StartApp({Key key, this.child}) : super(key: key);

  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {

  var currentView;
  @override
  void initState(){
      super.initState();
      currentView = new SplashScreen();
      new Future.delayed(
        const Duration(seconds: 5),
        () => Navigator.push(context, 
        MaterialPageRoute(builder: (context) => LoginToKeycloak()),
        ));
  } 

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      body: currentView
    );
  }
}