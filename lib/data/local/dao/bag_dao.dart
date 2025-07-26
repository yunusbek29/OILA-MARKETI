import 'package:floor/floor.dart';
import 'package:flutter_application_1/data/local/entry/bag_entity.dart';

@dao
abstract class BagDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveProductById(BagEntity oduct);

  @Query("SELECT * FROM bagEntitys")
  Future<List<BagEntity>> getAllProducts();

  @Query("SELECT * FROM bagEntitys WHERE id = :id")
  Future<BagEntity?> getProductById(int id);

  @Query("DELETE FROM bagEntitys WHERE id = :id")
  Future<void> deleteProductById(int id);

  @delete
  Future<void> removeProduct(BagEntity product);
}
