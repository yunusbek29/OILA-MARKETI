import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';

class SearchState extends Equatable {
  
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final bool isLoading;

  SearchState({
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.isLoading = false,

  });

  SearchState copyWith({
    List<ProductModel>? allProducts,
    List<ProductModel>? filteredProducts,
    bool? isLoading,
  }) {
    return SearchState(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [allProducts, filteredProducts, isLoading];
}
