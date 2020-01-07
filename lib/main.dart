import 'package:flutter/material.dart';
import './startapp/startapp.dart';
//import './startapp/home.dart';

void main() async{

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Internmatch",
    /*Run the app*/
    home: new StartApp(),
  ));
}