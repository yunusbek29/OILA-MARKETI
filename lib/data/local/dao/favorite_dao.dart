import 'package:floor/floor.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';

@dao
abstract class FavoriteDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveFavoriteById(ProductModel product);

  @Query("SELECT * FROM favorites")
  Future<List<ProductModel>> getAllProducts();

  @Query("SELECT * FROM favorites WHERE id = :id")
  Future<ProductModel?> getProductById(int id);

  @Query("DELETE FROM favorites WHERE id = :id")
  Future<void> deleteProductById(int id);

  @delete
  Future<void> removeProduct(ProductModel product);
}
