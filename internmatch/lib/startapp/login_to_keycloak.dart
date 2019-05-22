import 'package:flutter/material.dart';
import 'home.dart';
import '../utils/app_auth_helper.dart';
import '../models/bridgeenvs.dart';
import '../models/keycloak_token.dart';
import '../models/session_data.dart';
import '../utils/database_helper.dart';
import '../utils/api_helper.dart';

class LoginToKeycloak extends StatefulWidget {
  @override
  State createState() => new KeycloakLogin();
}

class KeycloakLogin extends State<LoginToKeycloak> {
  //We need to call this function as it initates the State
  @override
  void initState() {
    initLogin();
  }

  void initLogin() async {
    await getEnvFromBridge(BridgeEnvs.bridgeUrl);
  }

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Logging to Key Cloak."),
      ),
    );
  }

  void navigateToApp() {
    //dispose();
    print("Navigating back to Main App.");
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  /*else{
         print("Force Enter to AppHome");
         navigateToApp();
       }*/
  authKeycloak() async {
    print("Auth to Key Cloak Login.....");
    Session.tokenResponse = await AppAuthHelper.authTokenResponse();
 //Session.tokenResponse = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJwU180dHhEMTJpUVJIZlJaLURRLTFaRWlGS3pWYkttVVFFWjdqOUdPaTZVIn0.eyJqdGkiOiJkZGY1NWNmNi03M2ZiLTRkZmItYmRhZC1kMjVjM2U0NWNmYWQiLCJleHAiOjE1NTcyMzA1NDYsIm5iZiI6MCwiaWF0IjoxNTU3MTg3MzQ2LCJpc3MiOiJodHRwczovL2JvdW5jZXItc3RhZ2luZy5vdXRjb21lLWh1Yi5jb20vYXV0aC9yZWFsbXMvaW50ZXJubWF0Y2giLCJhdWQiOiJkdW1teSIsInN1YiI6Ijc3MGZhNDA2LWRlZmYtNGRiMi1hYzJlLTlhNTdkNjE0YTUwMCIsInR5cCI6IkJlYXJlciIsImF6cCI6ImR1bW15IiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiOGFjZWNlYzQtYWY0Zi00Y2MyLTkxODEtY2I0MjY5MDhjNGE1IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6W10sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJ1bWFfYXV0aG9yaXphdGlvbiIsInVzZXIiXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJieXJvbiJ9.lztbVG-Ps79V9bLT1fI-aFRLvtMMyORG6xOH0XDdeTCiC_IAGtA_mE8qhMi7uQEjw_hh9VDCy3WX24vd5-wbx9zq_fHIhztEINfZOVcWiYe-KJIJyc0_6D_Ut_xjK_o4MbaObK1qE852eClwlAUCyaDUpiNBKuQ-kvX0hOE0prIeCyghfjdCso8nm5UiI699w_BjrbgttNW3s81zndo3FkBfIkov5BGq6CXuMNbSPm8qApXgJT9nIhyAN5mINRN3i92eo4bN0n34oYghVP9m7tYZKH1zl5zB6YmbVzAmo8GPi4t5l4BVGheKyzxQZiCrvChLaWnvwWHr5hFTvfVG6w" as AuthorizationTokenResponse;
    print("Response Received...");
    
    print("Token :: ${Session.tokenResponse.accessToken}");
    navigateToApp();
  }

  /*getting bridge envs*/
  getEnvFromBridge(endPoint) async {
    print("Fetching Envs From :::: " + endPoint);
    /* getting json object from */
    await bridgeApiHelper.makeApiRequest(endPoint).then((data) {
      /* Looping through and saving the necessary envs value */
      BridgeEnvs.map.forEach(
        (key, val) => BridgeEnvs.map[key](data[key]),
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

  void fetchTokenFromDB() async {
    var db = new DatabaseHelper();
    KeyCloakToken tokenFromDB = await db.retrieveToken(1);
  }
}
