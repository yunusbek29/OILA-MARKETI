import 'package:flutter_application_1/data/local/database/database.dart';

class DatabaseServise {
  static AppDatabase? _database;
  static AppDatabase? database = _database;
  static initialize() async {
    database ??= await $FloorAppDatabase
        .databaseBuilder("app_database.db")
        .build();
  }
}
