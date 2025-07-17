import 'package:flutter_application_1/bloc/shop_bloc/shop_state.dart';
import 'package:flutter_application_1/data/remote/fakestoreapi/product.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopState());

  void getLoadList() async {
    emit(state.copyWith(isLoading: true));

    final respone = await Product.GET(Product.GET_PRODUCT, {});

    if (respone != null) {
      final newProduct = userFromJson(respone);
      emit(state.copyWith(productmodel: newProduct, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  void getIsOrder() {
    if (state.isOrder) {
      emit(state.copyWith(isOrder: false));
    } else {
      emit(state.copyWith(isOrder: true));
    }
  }

  Future<void> refresh() async {
    emit(state.copyWith(isLoading: true));

    final respone = await Product.GET(Product.GET_PRODUCT, {});

    if (respone != null) {
      final newProduct = userFromJson(respone);
      state.productmodel.clear();
      emit(state.copyWith(productmodel: newProduct, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
}
