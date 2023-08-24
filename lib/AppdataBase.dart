import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'NoteModel.dart';

class AppDataBase {
  AppDataBase._();

  static final AppDataBase db = AppDataBase._();
  static final Table_name = "user";
  static final Column_userId = "user_id";
  static final Column_email = "user_email";
  static final Column_mobileNo = "user_mobile_number";
  static final Column_password = "user_password";
  static final Column_gender = "user_gender";

  Database? _database;

  Future<Database> getDB() async {
    if (_database != null) {
      return _database!;
    }
    else {
      return await initDB();
    }
  }

  Future<Database> initDB() async {
    Directory documentsPath = await getApplicationDocumentsDirectory();
    var dbPAth = join(documentsPath.path, "UserDB.db");
    return openDatabase(dbPAth,
        version: 1,
        onCreate: (db, version) {
          // now here we will create tables
          db.execute(
              "Create table $Table_name ( $Column_userId integer primary key autoincrement, $Column_email text primary key , $Column_mobileNo integer primary key, $Column_password text, $Column_gender text )");
        }
    );
  }

  Future<bool> AddUser(NoteModel details) async{
    var db= await getDB();
    var rowsEffected= await db.insert(Table_name, details.toMAp());
    if(rowsEffected>0){
      return true;
    }
    else{
      return false;
    }

  }
  Future<List<NoteModel>> fetchUser()async{
    var db= await getDB();
    List<Map<String, Object?>> users= await db.query(Table_name);

    List<NoteModel> listUsers=[];
    for(Map<String, Object?> user in users){
      NoteModel model=NoteModel.fromMap(user);
      listUsers.add(model);
    }
    return listUsers;
  }

  Future<bool> updateNote(NoteModel user)async{
    var db= await getDB();
    var count = await db.update(Table_name, user.toMAp(), where: "$Column_userId= ${user.user_id}");
    return count>0;

  }
  
   Future<bool> CheckUser(NoteModel user)async{
    var db=await getDB();
    List<Map<String,Object?>> checkingUser= await db.query(Table_name, where: "$Column_email= ${user.user_email }");
    if(checkingUser.length>0){
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> CheckPassword(NoteModel user)async{
    var db=await getDB();
    List<Map<String,Object?>> checkingUser= await db.query(Table_name, where:" $Column_email=? and $Column_mobileNo=?" ,whereArgs: [user.user_email,user.user_mobile_number] );
    if(checkingUser.length>0){
      return true;
    }
    else{
      return false;
    }
  }
}