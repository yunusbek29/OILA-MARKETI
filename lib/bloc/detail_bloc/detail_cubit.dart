import 'package:flutter_application_1/bloc/detail_bloc/detail_state.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';
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

  void addToBag(ProductModel product) {
    final List<ProductModel> newList = List.from(state.bag);

    final index = newList.indexWhere((e) => e.id == product.id);

    if (index != -1) {
      newList[index].count++;
    } else {
      product.count = 1;
      newList.add(product);
    }

    emit(state.copyWith(bag: newList));
  }
}
