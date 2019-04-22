
import 'dart:collection';

import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../models/bridgeenvs.dart';
import '../models/keycloak_token.dart';
import '../models/session_data.dart';
import '../utils/database_helper.dart';
import '../utils/api_helper.dart';
import '../widgetLibrary/webview_widget.dart';
import 'dart:async';


class LoginToKeycloak extends StatefulWidget{
  
  @override
  State createState() => new KeycloakLogin();

}

class KeycloakLogin extends State<LoginToKeycloak>{
 
    var _flutterWebviewPlugin = new FlutterWebviewPlugin();
    var _url;

  //We need to call this function as it initates the State
    @override
    void initState() {
        initLogin();
    }

    void initLogin() async {
               
      await getEnvFromBridge(BridgeEnvs.bridgeUrl);

      /*initiating keycloack auth*/
      authKeycloak();
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
              body: new WebView(_url)
            );
    }

    void navigateToApp(){
      //dispose();
      print("Navigating back to Main App.");
      Navigator.of(context).pop();     
      Navigator.push(context, MaterialPageRoute(builder:(context) => Home() ));
    }

    /*disposes webviewplugin and webview scaffold*/
    @override
    void dispose(){
      _flutterWebviewPlugin.cleanCookies();
      _urlChangeListener.cancel();
      _flutterWebviewPlugin.close();
      _flutterWebviewPlugin.dispose();
      print("Webview Resources Disposed...");
      super.dispose();     
    }
    
       /*else{
         print("Force Enter to AppHome");
         navigateToApp();
       }*/

    StreamSubscription<String> _urlChangeListener;
    Queue <String> urlQueue = new Queue<String>();

    void authKeycloak () async{  

        print("Initiating Keycloack Login");

        setState(() {
          _url = BridgeEnvs.ENV_GENNY_INITURL;
        });

        
        /* listening to eny url change in the browser */
       _urlChangeListener = _flutterWebviewPlugin.onUrlChanged.listen((String url){            
              RegExp regExp = new RegExp("code=(.*)");
              navigateToApp();
              String code = regExp.firstMatch(url)?.group(1);
              if(code != null){
                getKeycloakSession(code);
              }
        });
    }

    getKeycloakSession(code){
        print("code::: $code");
        /* 
        
        Need to decode code and retrieve session information 
        
        
        */

        navigateToApp();
    }

      /*getting bridge envs*/
    getEnvFromBridge(endPoint) async{

        print("Fetching Envs From :::: " + endPoint);
        /* getting json object from */
        await BridgeApiHelper.makeApiRequest(endPoint).then((data){

            /* Looping through and saving the necessary envs value */
            BridgeEnvs.map.forEach((key,val) => {            
              BridgeEnvs.map[key](data[key]),
          });
            BridgeEnvs.fetchSuccess = true;
      });
    }

    /*Saving it to the database */
    void storeTokenInDB(String token) async {

      var db = new DatabaseHelper();  
      Session.accessToken = await db.saveToken(new KeyCloakToken("$token"));
    } 

    void fetchTokenFromDB() async{
        var db = new DatabaseHelper();  
        KeyCloakToken tokenFromDB = await db.retrieveToken(1);
    }

}



