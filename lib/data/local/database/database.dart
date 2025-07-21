import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_application_1/data/local/dao/favorite_dao.dart';
import 'package:flutter_application_1/data/local/dao/bag_dao.dart';
import 'package:flutter_application_1/data/local/entry/bag_entity.dart';
import 'package:flutter_application_1/data/local/entry/favorite_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:flutter_application_1/data/local/entry/product_model.dart';

part 'database.g.dart';

@Database(version: 2, entities: [BagEntity, FavoriteEntity])
abstract class AppDatabase extends FloorDatabase {
  BagDao get bagDao;
  FavoriteDao get favoriteDao;
}
