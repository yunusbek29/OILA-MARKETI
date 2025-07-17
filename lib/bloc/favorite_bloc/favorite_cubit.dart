import 'package:flutter_application_1/bloc/favorite_bloc/favorite_state.dart';
import 'package:flutter_application_1/data/remote/fakestoreapi/product.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());

  void getLoadList() async {
    emit(state.copyWith(isLoading: true));

    final respone = await Product.GET(Product.GET_PRODUCT, {});

    if (respone != null) {
      final newProduct = userFromJson(respone);
      emit(state.copyWith(productModel: newProduct, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
}
