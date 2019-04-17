import '../models/event.dart';
import './websocket.dart';
import 'dart:convert';
import '../models/bridgeenvs.dart';

EventHandler eventHandler = new EventHandler();

class EventHandler{

    static final EventHandler _eventHandler = new EventHandler._internal();

    factory EventHandler(){
      return _eventHandler;
    }


    EventHandler._internal();

    initWebSocketConnection() async{
      
      print(BridgeEnvs.ENV_GENNY_BRIDGE_VERTEX);
      socket.initCommunication(BridgeEnvs.ENV_GENNY_BRIDGE_VERTEX);

      sendEvent({event:authInit,sendWithToken: false});
    }
s
    String __getAccessToken(){

      final String token = null;

      //Get token form database;
      return token;
    }

    sendEvent({ event, sendWithToken, eventType, data}){
  
        // generate Event
      final token = this.__getAccessToken();
      OutgoingEvent eventObject;

      sendWithToken ? eventObject = event( eventType, data, token)
      : eventObject = event( eventType, data);

      print( 'sending event ::' + eventObject.toString() );
      socket.sendMessage( eventObject.message() );
    }

    handleIncomingMessage(incomingMessage){

      Map message = json.decode(incomingMessage);
      //Neeed more to do 
      print (message);

    }

}