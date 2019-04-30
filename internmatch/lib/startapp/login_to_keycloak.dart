import 'dart:collection';
import 'package:flutter/material.dart';
import 'home.dart';
import '../utils/app_auth_helper.dart';
import '../models/bridgeenvs.dart';
import '../models/keycloak_token.dart';
import '../models/session_data.dart';
import '../utils/database_helper.dart';
import '../utils/api_helper.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'dart:async';


class LoginToKeycloak extends StatefulWidget{
  
  @override
  State createState() => new KeycloakLogin();

}

class KeycloakLogin extends State<LoginToKeycloak>{ 
  //We need to call this function as it initates the State
    @override
    void initState() {
        initLogin();
    }

    void initLogin() async {
               
      await getEnvFromBridge(BridgeEnvs.bridgeUrl);
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            title: Text("Logging to Key Cloak."),
          ),
                
             );
    }

    void navigateToApp(){
      //dispose();
      print("Navigating back to Main App.");
      Navigator.of(context).pop();     
      Navigator.push(context, MaterialPageRoute(builder:(context) => Home() ));
    }

    
       /*else{
         print("Force Enter to AppHome");
         navigateToApp();
       }*/
    authKeycloak() async{
      
        Session.tokenResponse = await AppAuthHelper.authTokenResponse();
        print("Token :: ${Session.tokenResponse.accessToken}");
        navigateToApp();
    }

      /*getting bridge envs*/
    getEnvFromBridge(endPoint) async{

        print("Fetching Envs From :::: " + endPoint);
        /* getting json object from */
        await bridgeApiHelper.makeApiRequest(endPoint).then((data){

            /* Looping through and saving the necessary envs value */
            BridgeEnvs.map.forEach((key,val) =>
            BridgeEnvs.map[key](data[key]),
          );
          
            BridgeEnvs.fetchSuccess = true;
            authKeycloak();
      });
    }

    /*Saving it to the database */
    void storeTokenInDB(String token) async {

      var db = new DatabaseHelper();  
      //Session.tokenResponse.accessToken = await db.saveToken(new KeyCloakToken("$token"));
    } 

    void fetchTokenFromDB() async{
        var db = new DatabaseHelper();  
        KeyCloakToken tokenFromDB = await db.retrieveToken(1);
    }

}