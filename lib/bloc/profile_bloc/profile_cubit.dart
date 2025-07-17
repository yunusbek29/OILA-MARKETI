import 'dart:convert';
import 'package:flutter_application_1/bloc/profile_bloc/profile_state.dart';
import 'package:flutter_application_1/data/remote/fakestoreapi/product.dart';
import 'package:flutter_application_1/data/local/entry/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  void requestBacend() async {
    emit(state.copyWith(isLoading: true));

    final response = await Product.GET('${Product.GET_USER}/3', {});
    final user = UserModel.fromJson(jsonDecode(response.toString()));
    emit(state.copyWith(userModel: user, isLoading: false));
  }

  void getShowAddress() {
    if (state.showAddress) {
      emit(state.copyWith(showAddress: false));
    } else {
      emit(state.copyWith(showAddress: true));
    }
  }

  void getShowTerms() {
    if (state.showTerms) {
      emit(state.copyWith(showTerms: false));
    } else {
      emit(state.copyWith(showTerms: true));
    }
  }
}
