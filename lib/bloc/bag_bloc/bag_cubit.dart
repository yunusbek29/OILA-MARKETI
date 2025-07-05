import 'package:flutter_application_1/bloc/bag_bloc/bag_state.dart';
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
}
