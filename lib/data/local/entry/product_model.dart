import 'dart:convert';
import 'package:flutter_application_1/data/local/entry/bag_entity.dart';
import 'package:flutter_application_1/data/local/entry/favorite_entity.dart';

List<ProductModel> userFromJson(String str) => List<ProductModel>.from(
  json.decode(str).map((x) => ProductModel.fromJson(x)),
);

String userToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rate;
  final int ratingCount;
  int count;
  bool isLiked;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.ratingCount,
    this.count = 1,
    this.isLiked = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rate: (json['rating']['rate'] as num).toDouble(),
      ratingCount: json['rating']['count'],
      count: json['count'] ?? 1,
      isLiked: json['isLiked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": {"rate": rate, "count": ratingCount},
  };

  ProductModel copyWith({
  int? id,
  String? title,
  double? price,
  String? description,
  String? category,
  String? image,
  double? rate,
  int? ratingCount,
  int? count,
  bool? isLiked,
}) {
  return ProductModel(
    id: id ?? this.id,
    title: title ?? this.title,
    price: price ?? this.price,
    description: description ?? this.description,
    category: category ?? this.category,
    image: image ?? this.image,
    rate: rate ?? this.rate,
    ratingCount: ratingCount ?? this.ratingCount,
    count: count ?? this.count,
    isLiked: isLiked ?? this.isLiked,
  );
}

  @override
  bool operator ==(Object other) {
    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  BagEntity toBagEntity() {
    return BagEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rate: rate,
      ratingCount: ratingCount,
      count: count,
      isLiked: isLiked,
    );
  }

  FavoriteEntity toFavoriteEntity() {
    return FavoriteEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rate: rate,
      ratingCount: ratingCount,
      count: count,
      isLiked: !isLiked,
    );
  }
}
