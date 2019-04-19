
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../models/bridgeenvs.dart';
import '../models/keycloak_token.dart';
import '../models/session_data.dart';
import '../utils/database_helper.dart';
import '../utils/api_helper.dart';
import '../widgetLibrary/webview_widget.dart';


class LoginToKeycloak extends StatefulWidget{
  
  @override
  State createState() => new KeycloakLogin();

}

class KeycloakLogin extends State<LoginToKeycloak>{
 
    var _flutterWebviewPlugin = new FlutterWebviewPlugin();
    var _url;

  //We need to call this function as it initates the State
    @override
    @mustCallSuper
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

      dispose();
      print("Navigating to App Home.");
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new Home()));
    }

    /*disposes webviewplugin and webview scaffold*/
    void dispose(){

      _flutterWebviewPlugin.close();
      _flutterWebviewPlugin.dispose();
      super.dispose();
      print("Webview Resources Disposed...");
    }

    checkToken(url){
            
            RegExp regExp = new RegExp("code=(.*)");
            String token = regExp.firstMatch(url)?.group(1);

            if(token != null){
              print("Access Token: " + Session.accessToken);
              Session.accessToken = token ;
              //storeInDB(keycloakSetting._token);
              navigateToApp();
       }
    }

    void authKeycloak(){  

        print("Initiating Keycloack Login");

        setState(() {
          _url = BridgeEnvs.ENV_GENNY_INITURL;
        });

        /* listening to eny url change in the browser */
        _flutterWebviewPlugin.onUrlChanged.listen((String url){
              print("Url Changed to ::: "+ url);
              checkToken(url);
        });
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



