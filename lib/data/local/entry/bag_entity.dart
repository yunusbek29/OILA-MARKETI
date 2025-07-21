import 'dart:convert';

import 'package:floor/floor.dart';

List<BagEntity> userFromJson(String str) => List<BagEntity>.from(
  json.decode(str).map((x) => BagEntity.fromJson(x)),
);

String userToJson(List<BagEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
@Entity(tableName: 'products')
class BagEntity {
  @PrimaryKey(autoGenerate: true)
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

  BagEntity({
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

  factory BagEntity.fromJson(Map<String, dynamic> json) {
    return BagEntity(
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

  @override
  bool operator ==(Object other) {
    return other is BagEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

}
