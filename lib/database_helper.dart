import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:opart_v2/model_opart.dart';
import 'package:opart_v2/opart_page.dart';

import 'main.dart';

class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE opart (
                id INTEGER PRIMARY KEY,
                data STRING NOT NULL )
              ''').then((value) {
      for (int i = 0; i < savedOpArt.length; i++) {
        insert(savedOpArt[i]);
      }
    });
  }

  // Database helper methods:
  Future<int> insert(Map<String, dynamic> data) async {
    Database db = await database;
    int id = await db.insert('data', data);
    return id;
  }

  Future<List<Map<String, dynamic>>> getData() async {
    Database db = await database;
    List<Map> maps = await db.query(
      'opart',
    );
    if (maps.length > 0) {
      return maps;
    }

    return null;
  }

  delete(int i) async {
    Database db = await database;
    List<Map> maps = await db.query(
      'opart',
    );

    if (maps.length > 0) {
      return await db.rawDelete('DELETE FROM opart WHERE id = ?', [i]);
    }
    return maps;
  }

  getUserDb() async {
    await getData().then((map) {
      if(map != null){
      for (int i = 0; i < map.length; i++) {
        Map<String, dynamic> _data = jsonDecode(map[i]['data']);
        savedOpArt.add(_data);
      }}
    });
  }

  deleteDB() async {
    Database db = await database;
    db.delete('opart');
  }
}
