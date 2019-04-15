
class BaseEntity{

  String _token;
  int _id;

  BaseEntity(this._token);

  BaseEntity.map(dynamic obj){
    this._token = obj['token'];
    this._id = obj['id'];
  }

  String get token => _token;
  int get id => _id;

  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map["token"] = _token;
  
    if(id != null) {
      map['id'] = _id;
    }
    return map;

  }


  BaseEntity.fromMap(Map<String,dynamic> map){
    this._token = map["token"];
    this._id = map["id"];
  }
}