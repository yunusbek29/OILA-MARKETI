import 'package:flutter_application_1/bloc/detail_bloc/detail_state.dart';
import 'package:flutter_application_1/data/local/database_servise.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailState());
  void addList(ProductModel product) {
    List<ProductModel> pro = [];
    if (state.bag.contains(product)) {
      product.count++;
    } else {
      pro.add(product);
    }

    emit(state.copyWith(bag: pro));
  }

  void addToFavorite(ProductModel product) async {
    if (product.isLiked == false) {
      await DatabaseServise.database?.favoriteDao.saveProductById(
        product.toFavoriteEntity(),
      );
    } else {
      await DatabaseServise.database?.favoriteDao.deleteProductById(product.id);
    }
  }
}
