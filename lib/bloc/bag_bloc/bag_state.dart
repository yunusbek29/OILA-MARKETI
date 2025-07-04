import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/repository/models/product_model.dart';

class BagState extends Equatable {
  final bool isEmpty;

  const BagState({this.isEmpty = false,});

  BagState copyWith({bool? isEmpty, List<ProductModel>? bagList}) {
    return BagState(
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  @override
  List<Object?> get props => [isEmpty];
}
