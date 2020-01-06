import '../models/event.dart';
import './websocket.dart';
import 'dart:convert';
import '../models/bridgeenvs.dart';
import '../models/session_data.dart';
import './message_wrapper.dart';
import './api_helper.dart';

EventHandler eventHandler = new EventHandler();

class EventHandler {
  static final EventHandler _eventHandler = new EventHandler._internal();
  factory EventHandler() {
    return _eventHandler;
  }

  EventHandler._internal();

  initWebSocketConnection() async {
    await socket.initCommunication(BridgeEnvs.vertexUrl);

    print(
        "Length of Access Token:: ${Session.tokenResponse.accessToken.length}");

    this.registerWebsocket();
    this.sendAuth();
  }

  String __getAccessToken() {
    return Session.tokenResponse.accessToken;
    //Get token form database;
  }

  sendPing() {
    socket.sendMessage(json.encode(message.pingMessage()));
  }

  registerWebsocket() {
    socket.sendMessage(
        json.encode(message.registerMessage(this.__getSessionState())));
  }

  sendAuth() {
    this.sendEvent(event: authInit, sendWithToken: true);
  }

  logOut(){
    keycloakApiHelperClass.makeApiRequest(BridgeEnvs.logOutUrl); 
  }

  String __getSessionState() {
    return Session.tokenResponse.tokenAdditionalParameters['session_state'];
  }

  sendEvent({event, sendWithToken, eventType, data, items, beCode}) {
    // generate Event
    var accessToken;
    OutgoingEvent eventObject;

    if (sendWithToken) {
      accessToken = this.__getAccessToken();
    }

    eventObject = event(
        eventType: eventType,
        data: data,
        token: accessToken,
        items: items,
        beCode: beCode);
    final eventMessage = eventObject.eventMsg().toString();
    print('sending event ::' + eventMessage);
    socket.sendMessage(
        json.encode(message.eventMessage('address.inbound', eventMessage)));
  }

  handleIncomingMessage(incomingMessage) {
    var jsonMessage = json.decode(incomingMessage);
    print("EventHandler :: $jsonMessage");
    /* List<dynamic> data = incomingMessage;
    //String jsonString = latin1.decode(incomingMessage);
    
    var sessionState = Session.tokenResponse.tokenAdditionalParameters['session_state'];
    print("Decoded Message :: $data"); */

    /*  var type = jsonString['type'];
    var address = jsonString['address'];
    var body = jsonString['body']['items']['baseEntityAttributes']; */
    /* if(address == sessionState){
      print("Handling JSON Object from Server");
      print("Msg Type :: $type");
       print("Address  :: $address");
        print("BaseEntityAttributes :: $body"); */
  }
}
//}
