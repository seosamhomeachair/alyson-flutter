import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class WebView extends StatelessWidget{

      var _url;

      WebView(final url){
            _url = url;
            print("Webview Scafold Building with url = $_url");
      }

      @override
      Widget build(BuildContext context) {
        if(_url != null){
          return MaterialApp(
            routes: {
              "/":(_) => new WebviewScaffold(
                url: _url,
              ),
            }
          );
        }
        else{
          return Scaffold(
            appBar: AppBar(
            title: new Text('Login Into KeyClock'),
            ));
          }
      }
}
