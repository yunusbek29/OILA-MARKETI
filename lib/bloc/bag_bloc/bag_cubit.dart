import 'package:flutter_application_1/bloc/bag_bloc/bag_state.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagCubit extends Cubit<BagState> {
  BagCubit() : super(BagState());

  void isEmptys() {
    if (state.bagList.isEmpty) {
      emit(state.copyWith(isEmpty: true));
    } else {
      emit(state.copyWith(isEmpty: false));
    }
  }

  double getTotalPrice() {
    double total = 0;
    for (int i = 0; i < state.bagList.length; i++) {
      total += state.bagList[i].price * state.bagList[i].count;
    }
    return total;
  }

  void addToBag(ProductModel product) {
    List<ProductModel> bag = [];
    if (state.bagList.contains(product)) {
      product.count++;
    } else {
      product.count = 1;
      bag.add(product);
      emit(state.copyWith(bagList: bag));
    }
  }

  void removeBagCount(ProductModel product) {
    if (product.count == 1) {
      state.bagList.remove(product);
      emit(state.copyWith(bagList: state.bagList));
    } else {
      product.count--;
    }
  }
}
