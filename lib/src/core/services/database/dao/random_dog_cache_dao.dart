import 'package:assignment/src/modules/random_dog/data/models/random_dog_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../base_dao.dart';

class RandomDogCacheDao extends BaseDao {
  static const tableName = "tbl_random_dog_cache";

  RandomDogCacheDao(Database db) : super(db);

  static createTable(Database db) async {
    const sql = """CREATE TABLE IF NOT EXISTS $tableName(
            message TEXT PRIMARY KEY,
            status TEXT,
            path TEXT
          )""";
    return await db.execute(sql);
  }

  static dropTable(Database db) async {
    const sql = "DROP TABLE IF EXISTS $tableName";
    return await db.execute(sql);
  }

  Future<int> insert(RandomDogModel dog) async {
    return await db.insert(
      tableName,
        dog.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> insertAll(List<RandomDogModel> dogs) async {
    try {
      for (var dog in dogs) {
        await insert(dog);
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

  Future<List<RandomDogModel>> getAll() async {
    final List<Map<String, dynamic>> dogs = await db.query(tableName);
    if (dogs.isEmpty) return [];
    return dogs.map((json) => RandomDogModel.fromJson(json: json)).toList();
  }

  Future<List<RandomDogModel>> getRandomDog() async {
    final List<Map<String, dynamic>> dogs = await db.rawQuery("SELECT * FROM $tableName ORDER BY RANDOM() LIMIT 1;");
    return List<RandomDogModel>.from(dogs.map((x) => RandomDogModel.fromJson(json: x)));
  }
}
