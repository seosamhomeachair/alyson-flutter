
import 'dart:convert';

import 'package:web_socket_channel/io.dart';

void main()async {
  final ping = {'type':'ping'};
  
  var url = "ws://bridge.genny.life/frontend/websocket";
  var msg = json.encode(ping);
  var socket = IOWebSocketChannel.connect(Uri.parse(url));
  socket.stream.listen(_listener);
  socket.sink.add(msg);

}

_listener(msg){
  print(msg.toString());
  print((latin1.decode(msg)).toString());
}




       
      
        
  