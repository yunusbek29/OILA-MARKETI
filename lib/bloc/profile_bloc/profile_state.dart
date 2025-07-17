import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/local/entry/user_model.dart';

class ProfileState extends Equatable {
  final UserModel? userModel;
  final bool isLoading;
  final bool showAddress;
  final bool showTerms;

  const ProfileState({
    this.userModel,
    this.isLoading = false,
    this.showAddress = false,
    this.showTerms = false,
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? showAddress,
    bool? showTerms,
    UserModel? userModel,
  }) {
    return ProfileState(
      userModel: userModel ?? this.userModel,
      isLoading: isLoading ?? this.isLoading,
      showAddress: showAddress ?? this.showAddress,
      showTerms: showTerms ?? this.showTerms,
    );
  }

  @override
  List<Object?> get props => [userModel, isLoading, showAddress, showTerms];
}
