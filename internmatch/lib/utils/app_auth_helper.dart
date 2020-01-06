import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/bridgeenvs.dart';

class AppAuthHelper {
  static FlutterAppAuth appAuth = new FlutterAppAuth();
  static var _redirectUrl = "io.demo-app.appauth://oauth/login_success";
  static var refreshExpireIn;

  static authTokenResponse() async {
    var result = await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(BridgeEnvs.clientID, _redirectUrl,
          // discoveryUrl: '${BridgeEnvs.url}/realms/${BridgeEnvs.realm}/account'
          discoveryUrl: '${BridgeEnvs.authUrl}',
          clientSecret: '${BridgeEnvs.credentialsSecret['secret']}'),
    );
    print("Result from Key Cloak :: ${result.accessToken}");
    print(
        "Autorization Additional Parameters  :: ${result.authorizationAdditionalParameters}");
    print("Additional parameters :: ${result.tokenAdditionalParameters}");
    refreshExpireIn = result.tokenAdditionalParameters['refresh_expires_in'];
    /* Receiving new token from Key Cloak if Refresh Token expires */
    print("Refresh Token Expires In :: $refreshExpireIn");
    if (refreshExpireIn == 86400000) {
      print("Fetching New Access Token...");
      authTokenResponse();
    }
    return result;
  }
static logOut() async {
    const url = 'https://keycloak.gada.io/auth/realms/internmatch/protocol/openid-connect/logout?client_id=internmatch&nonce=ce3e5fe3-9e2b-4f7c-9d13-9ff1d5bdd5a5&redirect_uri=https%3A%2F%2Finternmatch-test.gada.io&response_mode=query&response_type=code&state=0c940a59-bb1d-4017-9ae7-329b2d1b4836';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
