class Cart {
  Cart({
    required this.id,
    required this.userId,
    required this.items,
  });

  final String? id;
  final String? userId;
  final List<Item> items;

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json["_id"],
      userId: json["userId"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }

  factory Cart.empty() {
    return Cart(id: '', userId: "", items: []);
  }
}

class Item {
  Item({
    required this.id,
    required this.quantity,
    required this.addedAt,
    required this.product,
  });

  final String? id;
  int? quantity;
  final DateTime? addedAt;
  final Product? product;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["_id"],
      quantity: json["quantity"],
      addedAt: DateTime.tryParse(json["addedAt"] ?? ""),
      product:
          json["product"] == null ? null : Product.fromJson(json["product"]),
    );
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.unit,
    required this.images,
  });

  final String? id;
  final String? name;
  final double? price;
  final String? unit;
  final List<String> images;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      name: json["name"],
      price: json["price"],
      unit: json["unit"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
    );
  }
}
