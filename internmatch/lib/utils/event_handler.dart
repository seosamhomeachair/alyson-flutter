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
    print( "Length of Access Token:: ${Session.tokenResponse.accessToken.length}");
    print("Sending Register event");
    socket.sendRegisterMessage();
    //var token = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJwU180dHhEMTJpUVJIZlJaLURRLTFaRWlGS3pWYkttVVFFWjdqOUdPaTZVIn0.eyJqdGkiOiI0ZGZmNzczNi0yMzc5LTRiMjctOWIxOC03ZmY1Y2Q5NDc4YmMiLCJleHAiOjE1NTc5MzkyMzMsIm5iZiI6MCwiaWF0IjoxNTU3ODk2MDMzLCJpc3MiOiJodHRwczovL2JvdW5jZXItc3RhZ2luZy5vdXRjb21lLWh1Yi5jb20vYXV0aC9yZWFsbXMvaW50ZXJubWF0Y2giLCJhdWQiOiJpbnRlcm5tYXRjaCIsInN1YiI6IjViZWQ4ZjAzLWVjNDQtNDg4Zi1iYjc2LTYyOTM4MjY2MmM4YiIsInR5cCI6IkJlYXJlciIsImF6cCI6ImludGVybm1hdGNoIiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiMjZiZTA4YmMtNzUyMC00ZDA1LWFmYjctYzczNmVmNmY2MTE2IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2ludGVybm1hdGNoLm91dGNvbWUtaHViLmNvbSIsImh0dHA6Ly9hbHlzb24uZ2VubnkubGlmZSIsImludGVybm1hdGNoLm91dGNvbWUtaHViLmNvbSIsImh0dHA6Ly9tZXNzYWdlczo4MDgwIiwiaHR0cDovL2xvY2FsaG9zdDo1MDAwIiwiaHR0cHM6Ly9pbnRlcm5tYXRjaC1zdGFnaW5nLm91dGNvbWUtaHViLmNvbSIsImh0dHA6Ly9hcGktc2VydmljZS5nZW5ueS5saWZlIiwiaHR0cDovL2FseXNvbjMuZ2VubnkubGlmZSIsImh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCIsImh0dHA6Ly9hbHlzb243Lmdlbm55LmxpZmUiLCJodHRwOi8vYnJpZGdlLmdlbm55LmxpZmUiLCJodHRwOi8vc29jaWFsOjgwODAiLCJodHRwOi8vYXBpLWludGVybm1hdGNoLm91dGNvbWUtaHViLmNvbSIsImh0dHBzOi8vYXBwMy1pbnRlcm5tYXRjaC5vdXRjb21lLWh1Yi5jb20iLCJodHRwOi8vbG9jYWxob3N0OjgyODAiLCJodHRwOi8vcXdhbmRhLXN0YWdpbmctaW50ZXJucy5vdXRjb21lLWh1Yi5jb20iLCJodHRwczovL2FwaS1pbnRlcm5tYXRjaC1zdGFnaW5nLm91dGNvbWUtaHViLmNvbSIsImh0dHA6Ly9pbnRlcm5tYXRjaC5nZW5ueS5saWZlIiwiaHR0cHM6Ly9hcHAzLWludGVybm1hdGNoLXN0YWdpbmcub3V0Y29tZS1odWIuY29tIiwiaHR0cHM6Ly9hcGktaW50ZXJubWF0Y2gub3V0Y29tZS1odWIuY29tIiwiaHR0cHM6Ly9xd2FuZGEtc3RhZ2luZy1pbnRlcm5zLm91dGNvbWUtaHViLmNvbSIsImh0dHA6Ly9icmlkZ2U6ODA4OCIsImh0dHA6Ly9ydWxlc3NlcnZpY2U6ODA4MCIsImh0dHA6Ly9hbHlzb24uZ2VubnkubGlmZTozMDAwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJ1bWFfYXV0aG9yaXphdGlvbiIsInVzZXIiXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJuYW1lIjoiTmVlbGt1bWFyIFBhdGVsIiwicHJlZmVycmVkX3VzZXJuYW1lIjoibmVlbHA5Njk2QGdtYWlsLmNvbSIsImdpdmVuX25hbWUiOiJOZWVsa3VtYXIiLCJmYW1pbHlfbmFtZSI6IlBhdGVsIiwiZW1haWwiOiJuZWVscDk2OTZAZ21haWwuY29tIn0.aOxHo--h4wdgUEVK0wwrHjRQbjP7gbN_NwDCVzDj4L3gaKOZibQwR2DeP7ocMVY2eyQCQIZGNNEEN07u3wv_KxMmWMnXJ_c3Ll54tRCgVGreVR_u_ophXZYAyFJ3bQX1LLGnNS-I2UpC4yUEmUw6aeyYg18U8Rr7X_smcTmaaPQZfHP0NKYZw__EL1-IC0jFVWmfD7HSda4kbikVAAIsjIn5knbjEqT4NZaj5yZjWgMO0JzVzyT4KYSP5qDVJSFzLfwYh0w-n0kTAHPNwLDcJHL7hE3qRbunzsXz2wFzrHK9hz9SDcL-11Hm3IivMqhpK0-sqiidCnLSpzsgO__gRw";
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

