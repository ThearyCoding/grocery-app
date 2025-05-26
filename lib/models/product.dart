import 'category.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.sold,
    required this.price,
    required this.rating,
    required this.stock,
    required this.unit,
    required this.sku,
    required this.images,
    required this.description,
    required this.exclusiveOffer,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.currentPrice,
    required this.hasActiveOffer,
  });

  final String? id;
  final String? name;
  final Category? category;
  final dynamic brand;
  final int? sold;
  final double? price;
  final int? rating;
  final int? stock;
  final String? unit;
  final String? sku;
  final List<String> images;
  final String? description;
  final ExclusiveOffer? exclusiveOffer;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final double? currentPrice;
  final bool? hasActiveOffer;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      name: json["name"],
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      brand: json["brand"],
      sold: json["sold"],
      price: json["price"],
      rating: json["rating"],
      stock: json["stock"],
      unit: json["unit"],
      sku: json["sku"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      description: json["description"],
      exclusiveOffer: json["exclusiveOffer"] == null
          ? null
          : ExclusiveOffer.fromJson(json["exclusiveOffer"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      currentPrice: json["currentPrice"],
      hasActiveOffer: json["hasActiveOffer"],
    );
  }
  factory Product.empty() {
    return Product(
        id: '',
        name: '',
        category: null,
        brand: null,
        sold: null,
        price: null,
        rating: null,
        stock: null,
        unit: null,
        sku: null,
        images: [],
        description: null,
        exclusiveOffer: null,
        createdAt: null,
        updatedAt: null,
        v: null,
        currentPrice: null,
        hasActiveOffer: null);
  }

  @override
  String toString() {
    return '''
Product(
  id: $id,
  name: $name,
  category: $category,
  brand: $brand,
  sold: $sold,
  price: $price,
  rating: $rating,
  stock: $stock,
  unit: $unit,
  sku: $sku,
  images: $images,
  description: $description,
  exclusiveOffer: $exclusiveOffer,
  createdAt: $createdAt,
  updatedAt: $updatedAt,
  v: $v,
  currentPrice: $currentPrice,
  hasActiveOffer: $hasActiveOffer
)
''';
  }
}

class ExclusiveOffer {
  ExclusiveOffer({
    required this.isActive,
    required this.discountPercent,
    required this.originalPrice,
    required this.validUntil,
    required this.badgeText,
  });

  final bool? isActive;
  final int? discountPercent;
  final double? originalPrice;
  final DateTime? validUntil;
  final String? badgeText;

  factory ExclusiveOffer.fromJson(Map<String, dynamic> json) {
    return ExclusiveOffer(
      isActive: json["isActive"],
      discountPercent: json["discountPercent"],
      originalPrice: json["originalPrice"],
      validUntil: DateTime.tryParse(json["validUntil"] ?? ""),
      badgeText: json["badgeText"],
    );
  }
}
