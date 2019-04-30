import 'package:flutter_appauth/flutter_appauth.dart';
import '../models/bridgeenvs.dart';

class AppAuthHelper{
static FlutterAppAuth appAuth = new FlutterAppAuth();
    static var _redirectUrl = "io.demo-app.appauth://oauth/login_success";
    
     static Future<AuthorizationTokenResponse> authTokenResponse() async{
      AuthorizationTokenResponse result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          BridgeEnvs.clientID,
          _redirectUrl,
         // discoveryUrl: '${BridgeEnvs.url}/realms/${BridgeEnvs.realm}/account'
         discoveryUrl: '${BridgeEnvs.authUrl}',
         clientSecret: '${BridgeEnvs.credentialsSecret['secret']}'
          ),);
          return result;
    }
}