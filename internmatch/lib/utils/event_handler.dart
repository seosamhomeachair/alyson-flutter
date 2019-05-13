import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';

import '../models/event.dart';
import './websocket.dart';
import 'dart:convert';
import '../models/bridgeenvs.dart';
import '../models/session_data.dart';


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
    print("Sending Auth event");
    socket.sendRegisterMessage();
    socket.sendMessage(
      new AuthInit(Session.tokenResponse.accessToken).message(),
    );
  }

  String __getAccessToken() {
    final String token = null;

    //Get token form database;
    return token;
  }

  sendEvent({event, sendWithToken, eventType, data}) {
    // generate Event
    final token = this.__getAccessToken();
    OutgoingEvent eventObject;

    sendWithToken
        ? eventObject = event(eventType, data, token)
        : eventObject = event(eventType, data);

    print('sending event ::' + eventObject.toString());
    socket.sendMessage(eventObject.message());
  }

  handleIncomingMessage(incomingMessage) {
    IOWebSocketChannel _channel;
    _channel =
          Session.tokenResponse.tokenAdditionalParameters['session_state'];
         // _channel.sink.add(webSocketChannel);
     new StreamBuilder(
        stream: _channel.stream,
        initialData: 45 ,
        builder: (context, snapshot)  {
         if(!snapshot.hasData){
           print("Data from Backend :: $snapshot");
         }
         else if(snapshot.hasError){
           print(snapshot.hasError);
         }
        }
            
      );
    /* As messages are sent as a String
        let's deserialize it to get the corresponding
        JSON object */

   /*  List<dynamic> message = incomingMessage;
    //Neeed more to do
       print(message);
       return message; */
   /* List<dynamic> data = incomingMessage;
    //String jsonString = latin1.decode(incomingMessage);
    //var jsonMessage = json.decode(jsonString);
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

