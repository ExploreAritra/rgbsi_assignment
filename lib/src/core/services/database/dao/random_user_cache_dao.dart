
import 'dart:convert';

import 'package:assignment/src/modules/random_user/data/models/random_user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../base_dao.dart';

class RandomUserCacheDao extends BaseDao {
  static const tableName = "tbl_random_user_cache";

  RandomUserCacheDao(Database db) : super(db);

  static createTable(Database db) async {
    const sql = """CREATE TABLE IF NOT EXISTS $tableName(
            json TEXT PRIMARY KEY
          )""";
    return await db.execute(sql);
  }

  static dropTable(Database db) async {
    const sql = "DROP TABLE IF EXISTS $tableName";
    return await db.execute(sql);
  }

  Future<int> insert(RandomUserModel user) async {
    return await db.insert(
      tableName,
        {"json": jsonEncode(user.toJson())},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> insertAll(List<RandomUserModel> users) async {
    try {
      for (var audit in users) {
        await insert(audit);
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<int> deleteAll() async {
    return await db.delete(tableName);
  }


  Future<RandomUserModel?> getRandomUser() async {
    final List<Map<String, dynamic>> users = await db.rawQuery("SELECT * FROM $tableName ORDER BY RANDOM() LIMIT 1;");
    RandomUserModel? userModel;
    if(users.isNotEmpty) {
      userModel = RandomUserModel.fromJson(jsonDecode(users.first["json"]));
    }
    return userModel;
  }
}
