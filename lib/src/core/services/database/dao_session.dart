
import 'package:assignment/src/core/services/database/dao/random_dog_cache_dao.dart';
import 'package:assignment/src/core/services/database/dao/random_user_cache_dao.dart';
import 'package:sqflite/sqflite.dart';

class DaoSession {
  static DaoSession? _instance;

  late Database _db;

  late RandomDogCacheDao randomDogCacheDao;
  late RandomUserCacheDao randomUserCacheDao;

  DaoSession._(Database db) {
    _db = db;
    randomDogCacheDao = RandomDogCacheDao(db);
    randomUserCacheDao = RandomUserCacheDao(db);
  }

  factory DaoSession(Database db) {
    //if the instance exists return it and if it's not yet created call initDb() for initializing the database
    _instance ??= DaoSession._(db);
    return _instance!;
  }

  Future<void> cleanDatabase() async {
    try {
      await _db.transaction((txn) async {
        final batch = txn.batch();
        batch.delete(RandomDogCacheDao.tableName);
        batch.delete(RandomUserCacheDao.tableName);
        // clean database on logout or any other case
        await batch.commit();
      });

    } catch (error) {
      throw Exception('DaoSession.cleanDatabase: $error');
    }
  }
}
