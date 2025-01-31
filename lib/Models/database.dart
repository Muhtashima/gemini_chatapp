
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'chat.dart';

class DatabaseHelper{
  static Database? _ref;
  static final DatabaseHelper instance = DatabaseHelper._internal();
  final int _version = 1;
  final String _sql = " CREATE TABLE IF NOT EXISTS "
      "chats( id INTEGER PRIMARY KEY AUTOINCREMENT, prompt TEXT, output TEXT )";


  DatabaseHelper._internal();

  // initialize Database

  Future<Database> _initDatabase() async {

    String databaseName = 'chats.db';
    String _path = join(await getDatabasesPath(), databaseName);


     return await openDatabase(
      _path,
      version: _version,
      onCreate: (db, version) {
       db.execute(_sql);
      },
    );

  }

  FutureOr<Database> get ref async{
    if(_ref != null){
      return _ref!;
    }
    else{
      _ref = await _initDatabase();
      return _ref!;
    }
  }

  //CREATE Database
  Future<void> insert(Chat chat)async {
    final db = await ref;
    await db.insert('chats', chat.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //READ Database
  Future<List<Chat>> getAll() async {
    final db = await ref;
    //data querying offers various options using arguments
    //like where, groupBy, having, orderBy, and columns within the query() helper.
    final List<Map<String, Object?>> queries = await db.query('chats');
    return queries.map((json) => Chat.fromMap(json)).toList();
  }
  
  Future<Chat> getChat(int id) async{
    final db = await ref;
    Chat chat = Chat.fromMap((await db.query('chats', where: 'id = ?', whereArgs: [id], limit: 1))[0]);
    return chat;
  }
  //UPDATE Database
  //DELETE Database
}

class ChatProvider extends ChangeNotifier{
  List<Chat> _chats = [];
  List<Chat> get chats => _chats;
  List<String> get listOfChats => _chats.map((chat) => chat.toString()).toList();
  final DatabaseHelper _helper = DatabaseHelper.instance;


  Future<void> getListOfChats() async {
    _chats = await _helper.getAll();
    notifyListeners();
  }
  Future<void> getChatByID(int id) async {
    await _helper.getChat(id);
    notifyListeners();
  }
  Future<void> addChat(Chat chat) async {
    await _helper.insert(chat);
    notifyListeners();
  }


}