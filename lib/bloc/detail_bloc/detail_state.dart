import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';

class DetailState extends Equatable {
  final List<ProductModel> productlar;
  final List<ProductModel> favorites;
  final List<ProductModel> bag;

  const DetailState({
    this.productlar = const [],
    this.favorites = const [],
    this.bag = const [],
  });

  DetailState copyWith({
    List<ProductModel>? productlar,
    List<ProductModel>? favorites,
    List<ProductModel>? bag,
  }) {
    return DetailState(
      productlar: productlar ?? this.productlar,
      favorites: favorites ?? this.favorites,
      bag: bag ?? this.bag,
    );
  }

  @override
  List<Object?> get props => [productlar, favorites, bag];
}
