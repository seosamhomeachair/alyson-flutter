/*  import 'dart:typed_data';
import 'dart:convert';
class Compression {

   // Compress the data
//   encode(string){
 String incomingByteArray;
//   }

    
//   // Decompress the data
//   decode(){
_incomingCompressedMessage(message) async {
    print("Comporession being used.");// eslint-disable-line
   codecFunc(message).then((result) => {
      incomingByteArray = convertDataURIToBinary( message );
      const decompressedDataArray = message.decompress( incomingByteArray );
      const decompressedStr = new TextDecoder( 'utf-8' ).decode( decompressedDataArray );
      var decoded = utf8.decode( decompressedStr );
      const deeplyParsed = deepParseJson( decoded );

      callback( deeplyParsed );

  });  
    
  }

  String convertDataURIToBinary( base64 ) {
  // var base64Index = dataURI.indexOf(BASE64_MARKER) + BASE64_MARKER.length;
  // var base64 = dataURI.substring(base64Index);
  var raw = utf8.encode( base64 );
  var rawLength = raw.length;
  var array = new Uint8List(rawLength);

  for ( var i = 0; i < rawLength; i++ ) {
    array[i] = raw.indexOf( i );
  }

  return array.toString();
}
 }

 */