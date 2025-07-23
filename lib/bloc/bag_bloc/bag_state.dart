import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/local/entry/bag_entity.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';

class BagState extends Equatable {
  final bool isEmpty;
  final List<ProductModel> bagList;

  const BagState({this.isEmpty = false, this.bagList = const []});

  BagState copyWith({bool? isEmpty, List<ProductModel>? bagList}) {
    return BagState(
      isEmpty: isEmpty ?? this.isEmpty,
      bagList: bagList ?? this.bagList,
    );
  }

  @override
  List<Object?> get props => [isEmpty, bagList];
}
