import 'package:flutter_application_1/bloc/favorite_bloc/favorite_state.dart';
import 'package:flutter_application_1/data/local/database_servise.dart';
import 'package:flutter_application_1/data/local/entry/favorite_entity.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());

  void clearbagList() async {
    for (var element in state.favoriteModel) {
      await DatabaseServise.database?.favoriteDao.deleteProductById(element.id);
    }
    emit(state.copyWith(favoriteModel: []));
  }

  void getFavorite() async {
    List<ProductModel> favorites = [];
    final favoriteList = await DatabaseServise.database?.favoriteDao
        .getAllProducts();

    if (favoriteList != null) {
      favorites.addAll(favoriteList);
    }

    emit(state.copyWith(favoriteModel: favorites));
  }
}
