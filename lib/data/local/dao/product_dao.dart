import 'package:floor/floor.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';

@dao
abstract class ProductDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveProduct(ProductModel product);

  @Query("SELECT * FROM products")
  Future<List<ProductModel>> getAllProducts();

  @Query("SELECT * FROM products WHERE productId = :id")
  Future<ProductModel?> getProductById(int id);

  @Query("DELETE FROM products WHERE productId = :id")
  Future<void> deleteProductById(int id);

  @delete
  Future<void> removeProduct(ProductModel product);
}
