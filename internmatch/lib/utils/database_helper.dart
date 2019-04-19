import 'dart:io';
import '../models/keycloak_token.dart';
import '../models/base_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
 

 // Path provider: https://pub.dartlang.org/packages/path_provider#-installing-tab-
class DatabaseHelper{

  static const String dbName = "database";
  static const String tokenTable ="Tokens";
  static const String baseEntityTable ="BaseEntity";
  static const String baseEntityLayoutTable ="BaseEntityLayout";

  static final DatabaseHelper instance = new DatabaseHelper.internal();

  factory DatabaseHelper () => instance;

  static Database _db;

  Future<Database> get db async{

    if(_db != null){

      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async{

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,"$dbName"); //home://directory/files/maindb.db
    
    _db = await openDatabase(path,version: 1, onCreate: createGennyTable);

  }


  void createGennyTable(Database db, version) async{

        print("Success");
        print(_db);

        /*creteTokenTables(db, version);
        creteBaseEntityTables(db,version);
        layoutBaseEntityTable(db,version);*/
  }

  void creteTokenTables(Database db,int version) async{

       var querry = "CREATE TABLE '$tokenTable'('id' INTEGER PRIMARY KEY,'token' TEXT)";
       executeQuery(db, querry);
  }

  void creteBaseEntityTables(Database db,int version) async{

       var querry = "CREATE TABLE '$baseEntityTable'('id' INTEGER PRIMARY KEY,'code' TEXT, 'name' TEXT, 'link' TEXT)";
       executeQuery(db, querry);
  }

  void createBaseEntityLayoutTable(Database db,int version) async{

       var querry = "CREATE TABLE '$baseEntityLayoutTable'('id' INTEGER PRIMARY KEY,'token' TEXT)";
       executeQuery(db, querry);
  }

  void executeQuery(Database db, querry) async{
   
    await db.execute(querry );
  }

  //CRUD Operations

//Insertion returns 1 or 0 i.e. Integer

Future<int> saveToken(KeyCloakToken token) async{

    return insertInToDB(token, "$tokenTable");
  }

Future<int> savebaseEntity(BaseEntity baseEntity) async{

    return insertInToDB(baseEntity, "$baseEntityTable");
  }

Future<int> saveBasenEntityLayout(BaseEntity itemlayouts) async{
    
    return insertInToDB(itemlayouts, "$baseEntityLayoutTable");
}


Future<int> insertInToDB (item,tableName) async{
      var dbClient = await db;
      int result = await dbClient.insert("$tableName", item.toMap());
      return result;
  }


/* fetching all values from database */
Future<KeyCloakToken> retrieveToken (id) async{

  retrieveFromDB(id,"$tokenTable");
  return KeyCloakToken.fromMap(result.first);
}

Future<BaseEntity> retrieveBaseEntity (id) async{

  retrieveFromDB(id,"$baseEntityTable");
  return BaseEntity.fromMap(result.first);
}

Future<BaseEntity> retrieveBaseEntityLayout (id) async{

  retrieveFromDB(id,"$baseEntityLayoutTable");
  return BaseEntity.fromMap(result.first);
}

var result;
Future<dynamic> retrieveFromDB(int id, tableName) async{

    var dbClient = await db;

    result = await dbClient.rawQuery("SELECT * FROM '$tableName' WHERE 'id' = $id");

    if(result.length == 0) return null;

    return result;
   
}
/* Future<int> getCount() async{

    var dbClient = await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName"));
}

Future<KeyCloakToken> fetchTokenFromDb(int id) async{

    var dbClient = await db;

    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $tokenId = $id");

    if(result.length == 0) return null;

    return new KeyCloakToken.fromMap(result.first);
}

Future<List> getAllTokens() async{
     var dbClient = await db;
     var result = await dbClient.rawQuery("SELECT * FROM $tableName");
     return result.toList();
}

Future<int> deleteTokenFromDB(int id) async{
  var dbClient = await db;
  return await dbClient.delete(tableName,
  where: "$tokenId =?",whereArgs: [id]);
}

Future<int> updateToken(KeyCloakToken entity) async{
  var dbClient = await db;
  return await dbClient.update(tableName,
  entity.toMap(), where: "$tokenId=?",whereArgs: [entity.id]);
}

/*Future<String> getToken() async{

    Student tokenDB = await fetchTokenFromDb(1);
    if(tokenDB == null){
        Student student = vertex.getToken();
        saveToken(student);
        return getToken();
    }
    return tokenDB.token;
}*/ */
     
    

Future close() async{
    var dbClient = await db;
    return dbClient.close();
}
}