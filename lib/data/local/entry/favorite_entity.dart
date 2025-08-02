import 'package:floor/floor.dart';
import 'package:flutter_application_1/data/local/entry/product_model.dart';

@Entity(tableName: 'favorites')
class FavoriteEntity {
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

  FavoriteEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.ratingCount,
    this.count = 0,
    this.isLiked = false,
  });

  factory FavoriteEntity.fromJson(Map<String, dynamic> json) {
    return FavoriteEntity(
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
    "count": count,
    "isLiked": isLiked,
  };

  @override
  bool operator ==(Object other) {
    return other is FavoriteEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  ProductModel toProductModel() {
    return ProductModel(
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
  static FavoriteEntity get initial {
    return FavoriteEntity(
      id: 0,
      title: '',
      price: 0.0,
      description: '',
      category: '',
      image: '',
      rate: 0.0,
      ratingCount: 0,
      count: 0,
      isLiked: false,
    );
  }
  FavoriteEntity copyWith({
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
    return FavoriteEntity(
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
}
