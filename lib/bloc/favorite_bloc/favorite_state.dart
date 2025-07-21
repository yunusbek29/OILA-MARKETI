import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/local/entry/favorite_entity.dart';

class FavoriteState extends Equatable {
  final List<FavoriteEntity> favoriteModel;

  const FavoriteState({this.favoriteModel = const []});

  FavoriteState copyWith({bool? isLoading, List<FavoriteEntity>? favoriteModel}) {
    return FavoriteState(favoriteModel: favoriteModel ?? this.favoriteModel);
  }

  @override
  List<Object?> get props => [favoriteModel];
}
