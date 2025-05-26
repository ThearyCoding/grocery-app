import 'package:flutter/material.dart';

class Category {
  Category({
    required this.id,
    required this.name,
    required this.isActive,
    required this.image,
    required this.v,
  });

  final String? id;
  final String? name;
  final bool? isActive;
  final String? image;
  final int? v;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"],
      name: json["name"],
      isActive: json["isActive"],
      image: json["image"],
      v: json["__v"],
    );
  }
}

List<Color> gridColors = [
  Color(0xff53B175),
  Color(0xffF8A44C),
  Color(0xffF7A593),
  Color(0xffD3B0E0),
  Color(0xffFDE598),
  Color(0xffB7DFF5),
  Color(0xff836AF6),
  Color(0xffD73B77),
];
