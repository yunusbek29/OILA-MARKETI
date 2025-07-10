import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';

class BagState extends Equatable {
  final bool isEmpty;
  final bool isLoading;
  final List<ProductModel> allProduct;
  final List<ProductModel> bagList;

  const BagState({
    this.isLoading = false,
    this.isEmpty = false,
    this.bagList = const [],
    this.allProduct = const [],
  });

  BagState copyWith({
    bool? isLoading,
    bool? isEmpty,
    List<ProductModel>? bagList,
    List<ProductModel>? allProduct,
  }) {
    return BagState(
      isEmpty: isEmpty ?? this.isEmpty,
      isLoading: isLoading ?? this.isLoading,
      bagList: bagList ?? this.bagList,
      allProduct: allProduct ?? this.allProduct,
    );
  }

  @override
  List<Object?> get props => [isEmpty, bagList, allProduct];
}
