import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';

class SearchState extends Equatable {
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final bool isLoading;
  final bool isSearching;

  const SearchState({
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.isLoading = false,
    this.isSearching = false,
  });

  SearchState copyWith({
    List<ProductModel>? allProducts,
    List<ProductModel>? filteredProducts,
    bool? isLoading,
    bool? isSearching,
  }) {
    return SearchState(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      isLoading: isLoading ?? this.isLoading,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    isLoading,
    isSearching,
  ];
}
