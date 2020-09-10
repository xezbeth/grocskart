import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:grocskart/Customer/CartTracker.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String tableName = "cart_table";
  String id = "id";
  String name = "name";
  String image = "image";
  String desc = "desc";
  String quantity = "quantity";
  String price = "price";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'cart.db';

    var cartDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return cartDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName($id INTERGER PRIMARY KEY,$name TEXT,$image TEXT,"
        "$desc TEXT,$quantity INTEGER,$price INTEGER)");
  }

  Future<List<Map>> getCartMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $tableName");
    return result;
  }

  Future<int> insertToCart(CartTraker cartItem) async {
    Database db = await this.database;
    var result = await db.rawInsert(
        "INSERT INTO $tableName VALUES(${cartItem.id},'${cartItem.name}','${cartItem.image}','${cartItem.desc}',${cartItem.quantity},${cartItem.price})");
    return result;
  }

  Future<int> updateToCart(CartTraker cartItem) async {
    Database db = await this.database;
    var result = await db
        .rawUpdate("UPDATE $tableName SET $quantity = ${cartItem.quantity}"
            " WHERE $id = ${cartItem.id}");
    return result;
  }

  Future<int> deleteFromCart(CartTraker cartItem) async {
    Database db = await this.database;
    var result =
        await db.rawDelete("DELETE FROM $tableName WHERE $id = ${cartItem.id}");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
