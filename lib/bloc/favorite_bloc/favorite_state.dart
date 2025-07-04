import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';

class FavoriteState extends Equatable {
  final List<ProductModel> productModel;
  final List<ProductModel> favoriteModel;
  final bool isLoading;

  const FavoriteState({
    this.isLoading = false,
    this.productModel = const [],
    this.favoriteModel = const [],
  });

  FavoriteState copyWith({
    bool? isLoading,
    List<ProductModel>? productModel,
    List<ProductModel>? favoriteModel,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      productModel: productModel ?? this.productModel,
      favoriteModel: favoriteModel ?? this.favoriteModel,
    );
  }

  @override
  List<Object?> get props => [productModel, favoriteModel, isLoading];
}
