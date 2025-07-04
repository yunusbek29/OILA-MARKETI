import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';

class SearchState extends Equatable {
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final bool isLoading;
  final bool isEmpty;

  const SearchState({
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.isEmpty = false,
    this.isLoading = true,
  });

  SearchState copyWith({
    List<ProductModel>? allProducts,
    List<ProductModel>? filteredProducts,
    bool? isEmpty,
    bool? isLoading,
  }) {
    return SearchState(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      isEmpty: isEmpty ?? this.isEmpty,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    isEmpty,
    isLoading,
  ];
}
