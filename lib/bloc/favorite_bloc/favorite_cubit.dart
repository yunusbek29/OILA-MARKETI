import 'package:flutter_application_1/bloc/favorite_bloc/favorite_state.dart';
import 'package:flutter_application_1/data/local/database_servise.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());



  void clearbagList() async {
    for (var element in state.favoriteModel) {
      await DatabaseServise.database?.productDao.removeProduct(element);
    }
    emit(state.copyWith(favoriteModel: []));
  }
}
