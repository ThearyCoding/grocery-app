class OrderDetailResponse {
    OrderDetailResponse({
         this.success,
         this.data,
    });

    final bool? success;
    final OrderData? data;

    factory OrderDetailResponse.fromJson(Map<String, dynamic> json){ 
        return OrderDetailResponse(
            success: json["success"],
            data: json["data"] == null ? null : OrderData.fromJson(json["data"]),
        );
    }

}

class OrderData {
    OrderData({
         this.id,
         this.createdAt,
         this.discount,
         this.promoCode,
         this.tax,
         this.otherFee,
         this.address,
         this.subtotal,
         this.items,
         this.orderStatus,
         this.totalAmount,
    });

    final String? id;
    final DateTime? createdAt;
    final double? discount;
    final String? promoCode;
    final double? tax;
    final double? otherFee;
    final String? address;
    final double? subtotal;
    final List<Item>? items;
    final String? orderStatus;
    final double? totalAmount;

    factory OrderData.fromJson(Map<String, dynamic> json) {
  return OrderData(
    id: json["id"],
    createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    discount: (json["discount"] as num?)?.toDouble(),
    promoCode: json["promoCode"],
    tax: (json["tax"] as num?)?.toDouble(),
    otherFee: (json["otherFee"] as num?)?.toDouble(),
    address: json["address"],
    subtotal: (json["subtotal"] as num?)?.toDouble(),
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    orderStatus: json["orderStatus"],
    totalAmount: (json["totalAmount"] as num?)?.toDouble(),
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
         this.subtotal,
    });

    final String? id;
    final String? name;
    final String? image;
    final String? unit;
    final int? quantity;
    final double? price;
    final double? subtotal;

factory Item.fromJson(Map<String, dynamic> json) {
  return Item(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    unit: json["unit"],
    quantity: json["quantity"],
    price: (json["price"] as num?)?.toDouble(),
    subtotal: (json["subtotal"] as num?)?.toDouble(),
  );
}


}
