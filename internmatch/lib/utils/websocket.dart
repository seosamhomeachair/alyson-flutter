import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:internmatch/models/session_data.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import './event_handler.dart';

WebSockets socket = new WebSockets();

class WebSockets {
  static final WebSockets _sockets = new WebSockets._internal();

  factory WebSockets() {
    return _sockets;
  }

  WebSockets._internal();

  /*websocket ope channel */
  IOWebSocketChannel _channel;

  //WebSockets.listen();

  bool _isOn = false;

  /*CLoses the webSocket Communication*/
  reset() {
    if (_channel != null) {
      if (_channel.sink != null) {
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
      var webSocketChannel =
          Session.tokenResponse.tokenAdditionalParameters['session_state'];
     _channel.sink.add(webSocketChannel);

      /* common handler to receiving message from server */
      _channel.stream.listen(_onIncomingMessage);
    } catch (e) {
      print("WebSocket: Unable to make a connection with :" + vertexUrl);
      print("Exception logs: " + e.toString());
    }
  }

  /*This method customized http: vertexurl to wss*/
  String getUrlForWebSocket(vertexUrl) {
    RegExp regExp = new RegExp("^wss:\/\/.*websocket");
    if (regExp.firstMatch(vertexUrl) != null) {
      return vertexUrl;
    }

    regExp = new RegExp("https(.*)");
    String url = regExp.firstMatch(vertexUrl)?.group(1);
    if (url != null) {
      return "wss" + url + "/websocket";
    } else {
      return null;
    }
  }

/* Send Resgister Event message to the vertex*/
  sendRegisterMessage() {
    if (_channel != null) {
      if (_channel.sink != null) {
        // WebSockets.listen();
        // print("Listening to WebSokcet ::");
        var msg = {
          'type': 'register',
          'address':
              '${Session.tokenResponse.tokenAdditionalParameters['session_state']}',
          'headers': {},
        };
        print("Register Event MSG Length :: ${msg.length}");
        print("Registering Event sending to server :: $msg");
        _channel.sink.add(json.encode(msg));
      }
    }
  }

  /* Send Auth_INIT Event message to the vertex*/
  sendMessage(message) {
    if (_channel != null) {
      if (_channel.sink != null) {
        var msg = {
          'type': 'send',
          'address': 'address.inbound',
          'headers': {},
          'body': {'data': message}
        };
        print("New Auth_INIT Event MSG Length :: ${msg.length}");
        print("Auth_INIT sending to server :: $msg");
        _channel.sink.add(json.encode(msg));
      }
    }
  }

  /*Listenes for incomming message from server */
  addListener(Function callback) {
    _listener.add(callback);
  }

  /*Remove for message from server */
  removeListener(Function callback) {
    _listener.remove(callback);
  }

  /*invoked each time when receiving the incoming message form the server*/
  _onIncomingMessage(message) {
    _isOn = true;
    print("Receiving form the server");
    print(message);
    var webSocketChannel =
          Session.tokenResponse.tokenAdditionalParameters['session_state'];
      _channel.sink.add(webSocketChannel);
      var eMessage = eventHandler.handleIncomingMessage(message);
      // var serverData = latin1.decode(eMessage);
      print("Server Data ::: $eMessage");
    }
  }

