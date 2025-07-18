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

  ProductDao? _productDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `products` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `title` TEXT NOT NULL, `price` REAL NOT NULL, `description` TEXT NOT NULL, `category` TEXT NOT NULL, `image` TEXT NOT NULL, `rate` REAL NOT NULL, `ratingCount` INTEGER NOT NULL, `count` INTEGER NOT NULL, `isLiked` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productModelInsertionAdapter = InsertionAdapter(
            database,
            'products',
            (ProductModel item) => <String, Object?>{
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
        _productModelDeletionAdapter = DeletionAdapter(
            database,
            'products',
            ['id'],
            (ProductModel item) => <String, Object?>{
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

  final InsertionAdapter<ProductModel> _productModelInsertionAdapter;

  final DeletionAdapter<ProductModel> _productModelDeletionAdapter;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    return _queryAdapter.queryList('SELECT * FROM products',
        mapper: (Map<String, Object?> row) => ProductModel(
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
  Future<ProductModel?> getProductById(int id) async {
    return _queryAdapter.query('SELECT * FROM products WHERE productId = ?1',
        mapper: (Map<String, Object?> row) => ProductModel(
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
    await _queryAdapter.queryNoReturn(
        'DELETE FROM products WHERE productId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> saveProduct(ProductModel product) async {
    await _productModelInsertionAdapter.insert(
        product, OnConflictStrategy.replace);
  }

  @override
  Future<void> removeProduct(ProductModel product) async {
    await _productModelDeletionAdapter.delete(product);
  }
}
