import 'dart:convert';

import 'package:get/get.dart';
import 'package:grocery_app/core/constants.dart';
import 'package:grocery_app/models/cart.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class CartApi {
  final _tokenStorage = TokenStorage();
  final url = Uri.parse("${AppConstants.baseUrl}/carts");
  Map<String, String>? headers(String token) {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
  }

  Future<void> createCart({required String productId}) async {
    try {
      final token = await _tokenStorage.getToken();

      final response = await http.post(url,
          headers: headers(token!), body: jsonEncode({"productId": productId}));

      if (response.statusCode == 200) {
        Get.snackbar("Success", "product added to cart.");
      } else {
        Get.snackbar("Error", "error creating cart.");
        dev.log(response.body);
      }
    } catch (e) {
      dev.log("error createing cart: $e");
    }
  }

  Future<Cart> fetchCart() async {
    try {
      final token = await _tokenStorage.getToken();

      final response = await http.get(url, headers: headers(token!));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return Cart.fromJson(jsonData);
      } else {
        dev.log(response.body);
        return Cart.empty();
      }
    } catch (e) {
      dev.log("error fetching cart: $e");
      return Cart.empty();
    }
  }

  Future<void> updateQuantity(
      {required String productId, required int quantity}) async {
    try {
      final token = await _tokenStorage.getToken();

      final url = Uri.parse("${AppConstants.baseUrl}/carts/items/$productId");
      final response = await http.patch(url,
          headers: headers(token!), body: jsonEncode({"quantity": quantity}));

      if (response.statusCode == 200) {
        dev.log(response.body);
      } else {
        Get.snackbar("Error", response.body);
      }
    } catch (e) {
      dev.log("error update qty: $e");
    }
  }

  Future<void> removeItem({required String productId}) async {
    try {
      final token = await _tokenStorage.getToken();

      final url = Uri.parse("${AppConstants.baseUrl}/carts/items/$productId");
      final response = await http.delete(url, headers: headers(token!));

      if (response.statusCode == 200) {
        dev.log(response.body);
      } else {
        dev.log(response.body);
        Get.snackbar("Error", response.body);
      }
    } catch (e) {
      dev.log("errro remove item: $e");
    }
  }
}
