import 'package:flutter_application_1/data/local/database/database.dart';
import 'package:floor/floor.dart';

class DatabaseServise {
  static AppDatabase? _database;
  static AppDatabase? database = _database;
  static initialize() async {
    _database ??= await $FloorAppDatabase
        .databaseBuilder("app_database.db")
        .build();
  }
}
