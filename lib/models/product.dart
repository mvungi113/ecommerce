import 'package:flutter/material.dart';

@immutable
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String imageUrl;
  final List<String> images;
  final double rating;
  final int reviews;
  final String category;
  final bool isFeatured;
  final bool isNew;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.imageUrl,
    required this.images,
    this.rating = 0.0,
    this.reviews = 0,
    required this.category,
    this.isFeatured = false,
    this.isNew = false,
  });

  double get finalPrice => discountPrice ?? price;
  bool get hasDiscount => discountPrice != null;
  double get discountPercentage => hasDiscount
      ? ((price - discountPrice!) / price * 100).roundToDouble()
      : 0;
}

class Category {
  final String id;
  final String name;
  final String icon;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}
