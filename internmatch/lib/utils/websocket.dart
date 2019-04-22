import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import './event_handler.dart';

WebSockets socket = new WebSockets();

class WebSockets {
  static final WebSockets _sockets = new WebSockets._internal();

  factory WebSockets(){
    return _sockets;
  }

  WebSockets._internal();
  
  /*websocket ope channel */
  IOWebSocketChannel _channel;

  bool _isOn = false;

  /*CLoses the webSocket Communication*/
  reset(){
    if(_channel != null){
      if(_channel.sink != null){
        _channel.sink.close();
        _isOn = false;
      }
    }
  }

  /* Listener */
  /* List of methods to be called when a new message*/
  /* comes in. */

 ObserverList<Function> _listener = new ObserverList<Function>();

  /* Initializint the web socket connection */

  initCommunication(vertexUrl) async {
  try {
        
        String socketUrl = getUrlForWebSocket(vertexUrl);
        print("WebSocket:: Trying to connect to $socketUrl");
        _channel = IOWebSocketChannel.connect(socketUrl);
        _channel.stream.listen(_onIncomingMessage);
      } catch(e){
          print("WebSocket: Unable to make a connection with :" + vertexUrl);
          print("Exception logs: "+e.toString());
      } 
  }

/*This method customized http: vertexurl to wss*/
  String getUrlForWebSocket(vertexUrl){

    RegExp regExp = new RegExp("^wss:\/\/.*websocket");
    if(regExp.firstMatch(vertexUrl) != null){
        return vertexUrl;
    }

    regExp = new RegExp("https(.*)");
    String url = regExp.firstMatch(vertexUrl)?.group(1);
    if(url !=null){
        return "wss" + url + "/websocket";
    }else{
      return null;
    }
  }

  /* Send message to the vertex*/
  sendMessage(message){
    if(_channel != null){      
      if(_channel.sink != null ){
        _channel.sink.add(json.encode(message));
      }
    }
  }
  

/*Listenes for incomming message from server */
  addListener(Function callback){
    _listener.add(callback);
  }


/*Remove for message from server */
  removeListener(Function callback){
    _listener.remove(callback);
  }


/*invoked each time when receiving the incoming message form the server*/
  _onIncomingMessage(message){
    _isOn = true;
    print("Receiving form the server");
    eventHandler.handleIncomingMessage(json.decode(message));
    }       
}
