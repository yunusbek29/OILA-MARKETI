import 'package:flutter_application_1/bloc/bag_bloc/bag_state.dart';
import 'package:flutter_application_1/data/local/database_servise.dart';
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

  int getTotalproduct() {
    return state.bagList.length;
  }

  void getProducts() async {
    final products =
        await DatabaseServise.database?.bagDao.getAllProducts() ?? [];
    emit(state.copyWith(bagList: products));
  }

  void count() {
    for (var i = 0; i < state.bagList.length; i++) {
      state.bagList[i].count++;
    }
    emit(state.copyWith());
  }

  void clearbagList() async {
    for (var element in state.bagList) {
      await DatabaseServise.database?.bagDao.removeProduct(element);
    }
    emit(state.copyWith(bagList: []));
  }
}
