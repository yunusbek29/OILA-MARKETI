import 'package:floor/floor.dart';
import 'package:flutter_application_1/data/local/entry/bag_entity.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';

@dao
abstract class BagDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveProduct(ProductModel product);

  @Query("SELECT * FROM bagEntitys")
  Future<List<BagEntity>> getAllProducts();

  @Query("SELECT * FROM bagEntitys WHERE id = :id")
  Future<ProductModel?> getProductById(int id);

  @Query("DELETE FROM bagEntitys WHERE id = :id")
  Future<void> deleteProductById(int id);

  @delete
  Future<void> removeProduct(ProductModel product);
}
