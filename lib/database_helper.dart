import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:opart_v2/model_opart.dart';

class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = 'MyDatabase.db';
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
   Future<Database> _initDatabase() async {
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
    String jsonMap = jsonEncode(data);
    Database db = await database;
    int id = await db.insert('opart', {'data': jsonMap});
    return id;
  }

  Future<List<Map<String, dynamic>>> getData() async {
    Database db = await database;
    List<Map> maps = await db.query(
      'opart',
    );
    if (maps.isNotEmpty) {
      return maps;
    }

    return null;
  }

  Future<void> delete(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'opart',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> getUserDb() async {
    await getData().then((map) {
      if (map != null) {
        for (int i = 0; i < map.length; i++) {
          Map<String, dynamic> _data = jsonDecode(map[i]['data']);

          Map<String, dynamic> fixedData = {};
          fixedData.addAll({'id': map[i]['id']});

          for (int j = 0; j < _data.length; j++) {
            _data.forEach((key, value) {
              if (key == 'type') {
                fixedData.addAll({
                  'type': OpArtType.values
                      .firstWhere((e) => e.toString() == _data['type']),
                });
              } else if (key == 'colors') {
                value.toString().replaceAll('[', '');

                value.toString().replaceAll(']', '');

                List<String> stringList = value.split(',');

                List<Color> colorList = [];
                for (int j = 0; j < stringList.length; j++) {
                  String valueString =
                      stringList[j].split('(0x')[1].split(')')[0];
                  int intValue = int.parse(valueString, radix: 16);
                  colorList.add(Color(intValue));
                }
                fixedData.addAll({'colors': colorList});
              } else if (value.toString().contains('Color(')) {
                String valueString = value.split('(0x')[1].split(')')[0];
                int intValue = int.parse(valueString, radix: 16);
                Color otherColor =  Color(intValue);
                fixedData.addAll({key: otherColor});
              } else {
                fixedData.addAll({key: value});
              }
            });
          }

          savedOpArt.add(fixedData);
        }
        rebuildMain.value++;
      }
    });
  }

  Future<void> deleteDB() async {
    Database db = await database;
   await db.delete('opart');
  }
}
