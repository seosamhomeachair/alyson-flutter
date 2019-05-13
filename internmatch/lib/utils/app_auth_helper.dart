import 'package:flutter/widgets.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import '../models/bridgeenvs.dart';

class AppAuthHelper{
static FlutterAppAuth appAuth = new FlutterAppAuth();
    static var _redirectUrl = "io.demo-app.appauth://oauth/login_success";
    
     static authTokenResponse() async{
      var result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          BridgeEnvs.clientID,
          _redirectUrl,
         // discoveryUrl: '${BridgeEnvs.url}/realms/${BridgeEnvs.realm}/account'
         discoveryUrl: '${BridgeEnvs.authUrl}',
         clientSecret: '${BridgeEnvs.credentialsSecret['secret']}'
          ),);
          print("Result from Key Cloak :: ${result.accessToken}");
          print("Autorization Additional Parameters  :: ${result.authorizationAdditionalParameters}");
          print("Additional parameters :: ${result.tokenAdditionalParameters}");
          return result;
    }
}