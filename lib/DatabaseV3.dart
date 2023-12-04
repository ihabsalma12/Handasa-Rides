import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class DatabaseV3{

  Database? myDB;


  Future<Database?> checkingMyData() async{
    if (myDB == null){
      myDB = await initialize();
      return myDB;
    }
    else{
      return myDB;
    }

    //reduce these lines
  }

  int Version = 1;

  initialize() async{
    String myDBpath = await getDatabasesPath();
    String path = join(myDBpath, 'userfile.db');
    Database myMainData = await openDatabase(path, version: Version,
        onCreate: (db, version){
          db.execute('''
        CREATE TABLE IF NOT EXISTS 'RIDER_PROFILE'(
         'ID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
         'NAME' TEXT NOT NULL,
         'EMAIL' TEXT NOT NULL,)
         ''');

          debugPrint("RIDER_PROFILE has been created!");
        }
    );
    return myMainData;
  }



  Reading(sql) async{
    Database? myData = await checkingMyData();
    var response = myData!.rawQuery(sql); //list of maps
    return response;
  }

  Writing(sql) async{
    Database? myData = await checkingMyData();
    var response = myData!.rawInsert(sql); //int
    return response;
  }

  Deleting(sql) async{
    Database? myData = await checkingMyData();
    var response = myData!.rawDelete(sql); //int
    return response;
  }

  Updating(sql) async{
    Database? myData = await checkingMyData();
    var response = myData!.rawUpdate(sql); //int
    return response;
  }




  ifExist() async{
    String myDBpath = await getDatabasesPath();
    String path = join(myDBpath, 'userfile.db');
    return await databaseExists(path)? debugPrint("RIDER_PROFILE EXIST"): debugPrint("RIDER_PROFILE NOT EXIST");
  }

  resetting() async{
    String myDBpath = await getDatabasesPath();
    String path = join(myDBpath, 'userfile.db');
    await deleteDatabase(path);
  }


}
