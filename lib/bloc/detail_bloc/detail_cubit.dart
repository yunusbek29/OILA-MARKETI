import 'package:flutter_application_1/bloc/detail_bloc/detail_state.dart';
import 'package:flutter_application_1/data/local/database_servise.dart';
import 'package:flutter_application_1/data/local/entry/favorite_entity.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailState(favorite: FavoriteEntity.initial));
  void addList(ProductModel product) {
    List<ProductModel> pro = [];
    if (state.bag.contains(product)) {
      product.count++;
    } else {
      pro.add(product);
    }

    emit(state.copyWith(bag: pro));
  }

  void addToFavorite(FavoriteEntity product) async {
    await DatabaseServise.database?.favoriteDao.saveProductById(product);
    emit(state.copyWith(favorite: product));
  }

  void deleteFromFavorite(int id) async {
    await DatabaseServise.database?.favoriteDao.deleteProductById(id);
    emit(state.copyWith(favorite: FavoriteEntity.initial));
  }

  Future<FavoriteEntity?> getFavorite(int id) async {
    final favorite = await DatabaseServise.database?.favoriteDao.getProductById(
      id,
    );
    emit(state.copyWith(favorite: favorite?? FavoriteEntity.initial));
    return favorite;
  }
}
