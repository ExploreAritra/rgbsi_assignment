

import 'package:assignment/src/core/services/database/dao/random_dog_cache_dao.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/random_user_cache_dao.dart';
import 'dao_session.dart';
import 'package:path/path.dart';

class DbProvider {
  DbProvider._();

  final int dbVersion = 1;
  final String dbName = "random_dog.db";

  static final instance = DbProvider._();

  Database? _db;
  DaoSession? _daoSession;

  Future<DaoSession> getDaoSession() async {
    //if the database exists return it and if it's not yet created call initDb() for initializing the database
    _db ??= await _initDb();
    _daoSession ??= DaoSession(_db!);
    return _daoSession!;
  }

  _initDb() async {
    //reference the path on the device where the database file will be saved
    // var directory = await getDatabasesPath();

    final directory = (await getDatabasesPath());

    // provide the full path to the database on the device and the db name
    final path = join(directory, dbName);

    return await openDatabase(
      path,
      version: dbVersion,
      onOpen: (db) {},
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _onCreate(Database db, int version) async {
    await _createAllTables(db);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    return Future.value();
  }


  Future<void> _createAllTables(Database db) async {
    await RandomDogCacheDao.createTable(db);
    await RandomUserCacheDao.createTable(db);
    // Create All Tables Here
  }

  // ignore: unused_element
  Future<void> _dropAllTables(Database db) async {
    await RandomDogCacheDao.dropTable(db);
    await RandomUserCacheDao.dropTable(db);
    // Drop All Tables Here
    return Future.value();
  }
}