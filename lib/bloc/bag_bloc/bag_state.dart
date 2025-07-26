import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/local/entry/bag_entity.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';

class BagState extends Equatable {
  final bool isEmpty;
  final List<BagEntity> bagList;
  final List<ProductModel> allProduct;

  const BagState({
    this.isEmpty = false,
    this.bagList = const [],
    this.allProduct = const [],
  });

  BagState copyWith({
    bool? isEmpty,
    List<BagEntity>? bagList,
    List<ProductModel>? allProduct,
  }) {
    return BagState(
      isEmpty: isEmpty ?? this.isEmpty,
      bagList: bagList ?? this.bagList,
      allProduct: allProduct ?? this.allProduct,
    );
  }

  @override
  List<Object?> get props => [isEmpty, bagList, allProduct];
}
