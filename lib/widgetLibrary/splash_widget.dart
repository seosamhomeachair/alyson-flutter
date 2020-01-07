import 'package:flutter/material.dart';
import '../projectEnv.dart';

class SplashScreen extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: new BoxDecoration(color: new Color(Project.projectColor)),
      alignment: Alignment.center,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Image.asset(Project.img,
              width: 100, repeat: ImageRepeat.noRepeat, height: 100),
          new Text(Project.projectName,
              style: new TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
          Padding(padding: new EdgeInsets.all(10.0)),
          new CircularProgressIndicator()
        ],
      ),
    );
  }
}
