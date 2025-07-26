// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BagDao? _bagDaoInstance;

  FavoriteDao? _favoriteDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `bagEntitys` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `title` TEXT NOT NULL, `price` REAL NOT NULL, `description` TEXT NOT NULL, `category` TEXT NOT NULL, `image` TEXT NOT NULL, `rate` REAL NOT NULL, `ratingCount` INTEGER NOT NULL, `count` INTEGER NOT NULL, `isLiked` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `favorites` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `title` TEXT NOT NULL, `price` REAL NOT NULL, `description` TEXT NOT NULL, `category` TEXT NOT NULL, `image` TEXT NOT NULL, `rate` REAL NOT NULL, `ratingCount` INTEGER NOT NULL, `count` INTEGER NOT NULL, `isLiked` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BagDao get bagDao {
    return _bagDaoInstance ??= _$BagDao(database, changeListener);
  }

  @override
  FavoriteDao get favoriteDao {
    return _favoriteDaoInstance ??= _$FavoriteDao(database, changeListener);
  }
}

class _$BagDao extends BagDao {
  _$BagDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bagEntityInsertionAdapter = InsertionAdapter(
            database,
            'bagEntitys',
            (BagEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'price': item.price,
                  'description': item.description,
                  'category': item.category,
                  'image': item.image,
                  'rate': item.rate,
                  'ratingCount': item.ratingCount,
                  'count': item.count,
                  'isLiked': item.isLiked ? 1 : 0
                }),
        _bagEntityDeletionAdapter = DeletionAdapter(
            database,
            'bagEntitys',
            ['id'],
            (BagEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'price': item.price,
                  'description': item.description,
                  'category': item.category,
                  'image': item.image,
                  'rate': item.rate,
                  'ratingCount': item.ratingCount,
                  'count': item.count,
                  'isLiked': item.isLiked ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BagEntity> _bagEntityInsertionAdapter;

  final DeletionAdapter<BagEntity> _bagEntityDeletionAdapter;

  @override
  Future<List<BagEntity>> getAllProducts() async {
    return _queryAdapter.queryList('SELECT * FROM bagEntitys',
        mapper: (Map<String, Object?> row) => BagEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            price: row['price'] as double,
            description: row['description'] as String,
            category: row['category'] as String,
            image: row['image'] as String,
            rate: row['rate'] as double,
            ratingCount: row['ratingCount'] as int,
            count: row['count'] as int,
            isLiked: (row['isLiked'] as int) != 0));
  }

  @override
  Future<BagEntity?> getProductById(int id) async {
    return _queryAdapter.query('SELECT * FROM bagEntitys WHERE id = ?1',
        mapper: (Map<String, Object?> row) => BagEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            price: row['price'] as double,
            description: row['description'] as String,
            category: row['category'] as String,
            image: row['image'] as String,
            rate: row['rate'] as double,
            ratingCount: row['ratingCount'] as int,
            count: row['count'] as int,
            isLiked: (row['isLiked'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> deleteProductById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM bagEntitys WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> saveProductById(BagEntity oduct) async {
    await _bagEntityInsertionAdapter.insert(oduct, OnConflictStrategy.replace);
  }

  @override
  Future<void> removeProduct(BagEntity product) async {
    await _bagEntityDeletionAdapter.delete(product);
  }
}

class _$FavoriteDao extends FavoriteDao {
  _$FavoriteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favoriteEntityInsertionAdapter = InsertionAdapter(
            database,
            'favorites',
            (FavoriteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'price': item.price,
                  'description': item.description,
                  'category': item.category,
                  'image': item.image,
                  'rate': item.rate,
                  'ratingCount': item.ratingCount,
                  'count': item.count,
                  'isLiked': item.isLiked ? 1 : 0
                }),
        _favoriteEntityDeletionAdapter = DeletionAdapter(
            database,
            'favorites',
            ['id'],
            (FavoriteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'price': item.price,
                  'description': item.description,
                  'category': item.category,
                  'image': item.image,
                  'rate': item.rate,
                  'ratingCount': item.ratingCount,
                  'count': item.count,
                  'isLiked': item.isLiked ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavoriteEntity> _favoriteEntityInsertionAdapter;

  final DeletionAdapter<FavoriteEntity> _favoriteEntityDeletionAdapter;

  @override
  Future<List<FavoriteEntity>> getAllProducts() async {
    return _queryAdapter.queryList('SELECT * FROM favorites',
        mapper: (Map<String, Object?> row) => FavoriteEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            price: row['price'] as double,
            description: row['description'] as String,
            category: row['category'] as String,
            image: row['image'] as String,
            rate: row['rate'] as double,
            ratingCount: row['ratingCount'] as int,
            count: row['count'] as int,
            isLiked: (row['isLiked'] as int) != 0));
  }

  @override
  Future<FavoriteEntity?> getProductById(int id) async {
    return _queryAdapter.query('SELECT * FROM favorites WHERE id = ?1',
        mapper: (Map<String, Object?> row) => FavoriteEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            price: row['price'] as double,
            description: row['description'] as String,
            category: row['category'] as String,
            image: row['image'] as String,
            rate: row['rate'] as double,
            ratingCount: row['ratingCount'] as int,
            count: row['count'] as int,
            isLiked: (row['isLiked'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> deleteProductById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM favorites WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> saveProductById(FavoriteEntity roduct) async {
    await _favoriteEntityInsertionAdapter.insert(
        roduct, OnConflictStrategy.replace);
  }

  @override
  Future<void> removeProduct(FavoriteEntity product) async {
    await _favoriteEntityDeletionAdapter.delete(product);
  }
}
