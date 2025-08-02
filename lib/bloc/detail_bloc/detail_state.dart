import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/local/entry/favorite_entity.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';

class DetailState extends Equatable {
  final List<ProductModel> productlar;
  final List<ProductModel> bag;
  final FavoriteEntity favorite;

  const DetailState({
    this.productlar = const [],
    this.bag = const [],
    required this.favorite,
  });

  DetailState copyWith({
    List<ProductModel>? productlar,
    List<ProductModel>? bag,
    FavoriteEntity? favorite,
  }) {
    return DetailState(
      productlar: productlar ?? this.productlar,
      bag: bag ?? this.bag,
      favorite: favorite ?? this.favorite,
    );
  }

  @override
  List<Object?> get props => [productlar, bag, favorite];
}
