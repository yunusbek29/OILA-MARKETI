import 'package:floor/floor.dart';

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
  final int count;
  final bool isLiked;

  FavoriteEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.ratingCount,
    required this.count,
    required this.isLiked,
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
}
