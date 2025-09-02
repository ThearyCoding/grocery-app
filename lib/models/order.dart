class OrderResponse {
    OrderResponse({
         this.success,
         this.data,
    });

    final bool? success;
    final List<Order>? data;

    factory OrderResponse.fromJson(Map<String, dynamic> json){ 
        return OrderResponse(
            success: json["success"],
            data: json["data"] == null ? [] : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
        );
    }

}

class Order {
    Order({
         this.id,
         this.userId,
         this.orderStatus,
         this.totalAmount,
         this.createdAt,
         this.items,
    });

    final String? id;
    final String? userId;
    final String? orderStatus;
    final double? totalAmount;
    final DateTime? createdAt;
    final List<Item>? items;

    factory Order.fromJson(Map<String, dynamic> json){ 
        return Order(
            id: json["id"],
            userId: json["userId"],
            orderStatus: json["orderStatus"],
            totalAmount: json["totalAmount"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        );
    }

}

class Item {
    Item({
         this.id,
         this.name,
         this.image,
         this.unit,
         this.quantity,
         this.price,
    });

    final String? id;
    final String? name;
    final String? image;
    final String? unit;
    final int? quantity;
    final double? price;

    factory Item.fromJson(Map<String, dynamic> json){ 
        return Item(
            id: json["id"],
            name: json["name"],
            image: json["image"],
            unit: json["unit"],
            quantity: json["quantity"],
            price: json["price"],
        );
    }

}
