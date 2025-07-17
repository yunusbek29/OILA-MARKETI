import 'package:floor/floor.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';

@dao
abstract class ProductDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveProduct(ProductModel product);
  
  @Query("SELECT * FROM products")
  Future<List<ProductModel>> getAllProducts();

  @Query("SELECT * FROM products WHERE id = :id")
  Future<ProductModel> getProductById(int id);

  @Query("DELETE FROM products WHERE id = :id")
  Future<void> clearProducts();

  @delete
  Future<void> removeProduct();
}
