import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';

class DetailState extends Equatable {
  final List<ProductModel> productlar;
  final List<ProductModel> bag;

  const DetailState({
    this.productlar = const [],
    this.bag = const [],
  });

  DetailState copyWith({
    List<ProductModel>? productlar,
    List<ProductModel>? bag,
  }) {
    return DetailState(
      productlar: productlar ?? this.productlar,
      bag: bag ?? this.bag,
    );
  }

  @override
  List<Object?> get props => [productlar,  bag];
}
