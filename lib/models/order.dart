class OrderResponse {
  OrderResponse({this.success, this.data});
  final bool? success;
  final List<OrderItem>? data;

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      success: json["success"] as bool?,
      data: (json["data"] as List<dynamic>?)
              ?.map((x) => OrderItem.fromJson(x as Map<String, dynamic>))
              .toList() 
          ?? <OrderItem>[],
    );
  }
}

class OrderItem {
  OrderItem({
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

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["id"] as String?,
      userId: json["userId"] as String?,
      orderStatus: json["orderStatus"] as String?,
      totalAmount: (json["totalAmount"] as num?)?.toDouble(),
      createdAt: DateTime.tryParse(json["createdAt"] as String? ?? ""),
      items: (json["items"] as List<dynamic>?)
              ?.map((x) => Item.fromJson(x as Map<String, dynamic>))
              .toList() 
          ?? <Item>[],
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

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"] as String?,
      name: json["name"] as String?,
      image: json["image"] as String?,
      unit: json["unit"] as String?,
      quantity: (json["quantity"] as num?)?.toInt(),
      price: (json["price"] as num?)?.toDouble(),
    );
  }
}
