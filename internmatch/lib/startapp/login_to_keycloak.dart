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
 //Session.tokenResponse = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJwU180dHhEMTJpUVJIZlJaLURRLTFaRWlGS3pWYkttVVFFWjdqOUdPaTZVIn0.eyJqdGkiOiI0ZGZmNzczNi0yMzc5LTRiMjctOWIxOC03ZmY1Y2Q5NDc4YmMiLCJleHAiOjE1NTc5MzkyMzMsIm5iZiI6MCwiaWF0IjoxNTU3ODk2MDMzLCJpc3MiOiJodHRwczovL2JvdW5jZXItc3RhZ2luZy5vdXRjb21lLWh1Yi5jb20vYXV0aC9yZWFsbXMvaW50ZXJubWF0Y2giLCJhdWQiOiJpbnRlcm5tYXRjaCIsInN1YiI6IjViZWQ4ZjAzLWVjNDQtNDg4Zi1iYjc2LTYyOTM4MjY2MmM4YiIsInR5cCI6IkJlYXJlciIsImF6cCI6ImludGVybm1hdGNoIiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiMjZiZTA4YmMtNzUyMC00ZDA1LWFmYjctYzczNmVmNmY2MTE2IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2ludGVybm1hdGNoLm91dGNvbWUtaHViLmNvbSIsImh0dHA6Ly9hbHlzb24uZ2VubnkubGlmZSIsImludGVybm1hdGNoLm91dGNvbWUtaHViLmNvbSIsImh0dHA6Ly9tZXNzYWdlczo4MDgwIiwiaHR0cDovL2xvY2FsaG9zdDo1MDAwIiwiaHR0cHM6Ly9pbnRlcm5tYXRjaC1zdGFnaW5nLm91dGNvbWUtaHViLmNvbSIsImh0dHA6Ly9hcGktc2VydmljZS5nZW5ueS5saWZlIiwiaHR0cDovL2FseXNvbjMuZ2VubnkubGlmZSIsImh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCIsImh0dHA6Ly9hbHlzb243Lmdlbm55LmxpZmUiLCJodHRwOi8vYnJpZGdlLmdlbm55LmxpZmUiLCJodHRwOi8vc29jaWFsOjgwODAiLCJodHRwOi8vYXBpLWludGVybm1hdGNoLm91dGNvbWUtaHViLmNvbSIsImh0dHBzOi8vYXBwMy1pbnRlcm5tYXRjaC5vdXRjb21lLWh1Yi5jb20iLCJodHRwOi8vbG9jYWxob3N0OjgyODAiLCJodHRwOi8vcXdhbmRhLXN0YWdpbmctaW50ZXJucy5vdXRjb21lLWh1Yi5jb20iLCJodHRwczovL2FwaS1pbnRlcm5tYXRjaC1zdGFnaW5nLm91dGNvbWUtaHViLmNvbSIsImh0dHA6Ly9pbnRlcm5tYXRjaC5nZW5ueS5saWZlIiwiaHR0cHM6Ly9hcHAzLWludGVybm1hdGNoLXN0YWdpbmcub3V0Y29tZS1odWIuY29tIiwiaHR0cHM6Ly9hcGktaW50ZXJubWF0Y2gub3V0Y29tZS1odWIuY29tIiwiaHR0cHM6Ly9xd2FuZGEtc3RhZ2luZy1pbnRlcm5zLm91dGNvbWUtaHViLmNvbSIsImh0dHA6Ly9icmlkZ2U6ODA4OCIsImh0dHA6Ly9ydWxlc3NlcnZpY2U6ODA4MCIsImh0dHA6Ly9hbHlzb24uZ2VubnkubGlmZTozMDAwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJ1bWFfYXV0aG9yaXphdGlvbiIsInVzZXIiXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJuYW1lIjoiTmVlbGt1bWFyIFBhdGVsIiwicHJlZmVycmVkX3VzZXJuYW1lIjoibmVlbHA5Njk2QGdtYWlsLmNvbSIsImdpdmVuX25hbWUiOiJOZWVsa3VtYXIiLCJmYW1pbHlfbmFtZSI6IlBhdGVsIiwiZW1haWwiOiJuZWVscDk2OTZAZ21haWwuY29tIn0.aOxHo--h4wdgUEVK0wwrHjRQbjP7gbN_NwDCVzDj4L3gaKOZibQwR2DeP7ocMVY2eyQCQIZGNNEEN07u3wv_KxMmWMnXJ_c3Ll54tRCgVGreVR_u_ophXZYAyFJ3bQX1LLGnNS-I2UpC4yUEmUw6aeyYg18U8Rr7X_smcTmaaPQZfHP0NKYZw__EL1-IC0jFVWmfD7HSda4kbikVAAIsjIn5knbjEqT4NZaj5yZjWgMO0JzVzyT4KYSP5qDVJSFzLfwYh0w-n0kTAHPNwLDcJHL7hE3qRbunzsXz2wFzrHK9hz9SDcL-11Hm3IivMqhpK0-sqiidCnLSpzsgO__gRw" as AuthorizationTokenResponse;
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
