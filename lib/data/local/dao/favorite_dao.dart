import 'package:floor/floor.dart';
import 'package:flutter_application_1/data/local/entry/favorite_entity.dart';

@dao
abstract class FavoriteDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveProductById(FavoriteEntity roduct);

  @Query("SELECT * FROM favorites")
  Future<List<FavoriteEntity>> getAllProducts();

  @Query("SELECT * FROM favorites WHERE id = :id")
  Future<FavoriteEntity?> getProductById(int id);

  @Query("DELETE FROM favorites WHERE id = :id")
  Future<void> deleteProductById(int id);

  @delete
  Future<void> removeProduct(FavoriteEntity product);
}
