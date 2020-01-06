import 'package:internmatch/models/event.dart';

import "../projectEnv.dart";

class BridgeEnvs {
  static get bridgeUrl {
    return Project.url + "/api/events/init?url=" + Project.url;
  }

static get logOutUrl{
  const url = 'https://keycloak.gada.io/auth/realms/internmatch/protocol/openid-connect/logout?client_id=internmatch&nonce=ce3e5fe3-9e2b-4f7c-9d13-9ff1d5bdd5a5&redirect_uri=https%3A%2F%2Finternmatch-test.gada.io&response_mode=query&response_type=code&state=0c940a59-bb1d-4017-9ae7-329b2d1b4836';
    return url;
    
}

  static get authUrl {
    return authServerUrl +
        "/realms/" +
        realm +
        "/.well-known/openid-configuration";
    //return authServerUrl+"/realms/"+realm+"/protocol/openid-connect/token";
  }

  static var realm;
  static var authServerUrl;
  static var sslRequired;
  static var resource;
  static var credentialsSecret;
  static var clientID;
  static var vertexUrl;
  static var apiUrl;
  static var url;
  static var ENV_GENNY_HOST;
  static var ENV_GENNY_INITURL;
  static var ENV_GENNY_BRIDGE_SERVICE;
  static var ENV_GENNY_BRIDGE_EVENTS;
  static var ENV_GENNY_BRIDGE_VERTEX;
  static var ENV_SIGNATURE_URL;

  static bool fetchSuccess = false;

  static final Map map = {
    'realm': (val) => realm = val,
    'auth-server-url': (val) => authServerUrl = val,
    'ssl-required': (val) => sslRequired = val,
    'resource': (val) => resource = val,
    'credentials': (val) => credentialsSecret = val,
    'vertx_url': (val) => vertexUrl = val,
    'api_url': (val) => apiUrl = val,
    'url': (val) => url = val,
    'clientId': (val) => clientID = val,
    'ENV_GENNY_HOST': (val) => ENV_GENNY_HOST = val,
    'ENV_GENNY_INITURL': (val) => ENV_GENNY_INITURL = val,
    'ENV_GENNY_BRIDGE_SERVICE': (val) => ENV_GENNY_BRIDGE_SERVICE = val,
    'ENV_GENNY_BRIDGE_EVENTS': (val) => ENV_GENNY_BRIDGE_EVENTS = val,
    'ENV_GENNY_BRIDGE_VERTEX': (val) => ENV_GENNY_BRIDGE_VERTEX = val,
    'ENV_SIGNATURE_URL': (val) => ENV_SIGNATURE_URL = val
  };
}
