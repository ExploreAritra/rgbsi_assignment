import 'package:sqflite/sqflite.dart';

abstract class BaseDao {
  Database db;

  BaseDao(this.db);
}
