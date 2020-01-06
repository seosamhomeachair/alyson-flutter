/*getting settings url */
import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

BridgeApiHelperClass bridgeApiHelper = new BridgeApiHelperClass();
KeycloakApiHelperClass keycloakApiHelperClass = new KeycloakApiHelperClass();

class ApiHelper {
  Future<http.Response> makeApiRequest(final url, final clientClass) async {
    if (url.isEmpty) {
      print("$clientClass :::: Invalid Api Endpoint url : $url");
      return null;
    }

    print("$clientClass :::: Making Api request : $url");
    http.Response response = await http.get(url);
    return response;
  }
}

/*Api for makin request to keycloack api*/
class KeycloakApiHelperClass {
  final _client = "KeycloakApiHelperClass";

  static final _bridgeApiHelperClas = new KeycloakApiHelperClass._internal();

  KeycloakApiHelperClass._internal();

  factory KeycloakApiHelperClass() {
    return _bridgeApiHelperClas;
  }

  Future<Map> makeApiRequest(final url) async {
    ApiHelper apiHelper = new ApiHelper();
    http.Response response = await apiHelper.makeApiRequest(url, _client);
    return null; 
  }
}

/*Api for makin request to Bridge api*/
class BridgeApiHelperClass {
  final _client = "BridgeApiHelper";

  static final _bridgeApiHelperClas = new BridgeApiHelperClass._internal();

  BridgeApiHelperClass._internal();

  factory BridgeApiHelperClass() {
    return _bridgeApiHelperClas;
  }

  Future<Map> makeApiRequest(final url) async {
    ApiHelper apiHelper = new ApiHelper();
    http.Response response = await apiHelper.makeApiRequest(url, _client);
    return json.decode(response.body);
  }
}
