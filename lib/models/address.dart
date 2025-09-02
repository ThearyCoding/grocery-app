class AddressResponse {
    AddressResponse({
         this.success,
         this.data,
    });

    final bool? success;
    final List<Address>? data;

    factory AddressResponse.fromJson(Map<String, dynamic> json){ 
        return AddressResponse(
            success: json["success"],
            data: json["data"] == null ? [] : List<Address>.from(json["data"]!.map((x) => Address.fromJson(x))),
        );
    }

}

class Address {
    Address({
         this.location,
         this.id,
         this.userId,
         this.title,
         this.name,
         this.phoneNumber,
         this.detail,
         this.address,
         this.isDefault,
         this.tag,
         this.photos,
         this.createdAt,
         this.updatedAt,
         this.v,
    });

    final Location? location;
    final String? id;
    final String? userId;
    final String? title;
    final String? name;
    final String? phoneNumber;
    final String? detail;
    final String? address;
    final bool? isDefault;
    final String? tag;
    final List<dynamic>? photos;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Address.fromJson(Map<String, dynamic> json){ 
        return Address(
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            id: json["_id"],
            userId: json["userId"],
            title: json["title"],
            name: json["name"],
            phoneNumber: json["phoneNumber"],
            detail: json["detail"],
            address: json["address"],
            isDefault: json["isDefault"],
            tag: json["tag"],
            photos: json["photos"] == null ? [] : List<dynamic>.from(json["photos"]!.map((x) => x)),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Location {
    Location({
         this.lat,
         this.lng,
    });

    final double? lat;
    final double? lng;

    factory Location.fromJson(Map<String, dynamic> json){ 
        return Location(
            lat: json["lat"],
            lng: json["lng"],
        );
    }

}
