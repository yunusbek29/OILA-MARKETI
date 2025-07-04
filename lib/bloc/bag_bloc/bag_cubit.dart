import 'package:flutter_application_1/bloc/bag_bloc/bag_state.dart';
import 'package:flutter_application_1/ui/screens/pages/global_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagCubit extends Cubit<BagState> {
  BagCubit() : super(BagState());

  void isEmptys() {
    if (bagList.isEmpty) {
      emit(state.copyWith(isEmpty: true));
    } else {
      emit(state.copyWith(isEmpty: false));
    }
  }

  double getTotalPrice() {
    double total = 0;
    for (int i = 0; i < bagList.length; i++) {
      total += bagList[i].price * bagList[i].count;
    }
    return total;
  }
}
