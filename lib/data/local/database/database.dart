import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_application_1/data/local/dao/product_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:flutter_application_1/data/local/entry/product_model.dart';

part 'database.g.dart';

@Database(version: 1, entities: [ProductModel])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get productDao;
}