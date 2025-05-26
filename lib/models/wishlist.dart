class Wishlist {
    Wishlist({
        required this.id,
        required this.userId,
        required this.items,
    });

    final String? id;
    final String? userId;
    final List<Item> items;

    factory Wishlist.fromJson(Map<String, dynamic> json){ 
        return Wishlist(
            id: json["_id"],
            userId: json["userId"],
            items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        );
    }
    factory Wishlist.empty(){
      return Wishlist(id: null, userId: null, items: []);
    }

}

class Item {
    Item({
        required this.id,
        required this.addedAt,
        required this.product,
    });

    final String? id;
    final DateTime? addedAt;
    final Product? product;

    factory Item.fromJson(Map<String, dynamic> json){ 
        return Item(
            id: json["_id"],
            addedAt: DateTime.tryParse(json["addedAt"] ?? ""),
            product: json["product"] == null ? null : Product.fromJson(json["product"]),
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

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["_id"],
            name: json["name"],
            price: json["price"],
            unit: json["unit"],
            images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        );
    }

}
