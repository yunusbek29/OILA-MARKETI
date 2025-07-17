import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';

class ShopState extends Equatable {
  final bool isOrder;
  final bool isLoading;
  final List<ProductModel> productmodel;

  const ShopState({
    this.isOrder = false,
    this.isLoading = false,
    this.productmodel = const [],
  });

  ShopState copyWith({
    bool? isOrder,
    bool? isLoading,
    List<ProductModel>? productmodel,
  }) {
    return ShopState(
      isOrder: isOrder ?? this.isOrder,
      isLoading: isLoading ?? this.isLoading,
      productmodel: productmodel ?? this.productmodel,
    );
  }

  @override
  List<Object?> get props => [isOrder, isLoading, productmodel];
}
