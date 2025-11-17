import 'dart:convert';

import 'package:get/get.dart';
import 'package:grocery_app/core/constants.dart';
import 'package:grocery_app/models/cart.dart';
import 'package:grocery_app/services/notification/notification_service.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'package:grocery_app/utils/snacbar_utils.dart';
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

  Future<Map<String, dynamic>?> applyPromoCode(String code) async {
    try {
      final token = await _tokenStorage.getToken();

      final url = Uri.parse("${AppConstants.baseUrl}/promocodes/mobile/apply");
      final response = await http.post(url,
          headers: headers(token!), body: jsonEncode({"code": code}));

      if (response.statusCode == 200) {
        SnacbarUtils.showSnacbar(
            title: "Success", message: jsonDecode(response.body)["message"]);
        return jsonDecode(response.body);
      } else {
        SnacbarUtils.showSnacbar(
            title: "Error", message: jsonDecode(response.body)["message"]);
        dev.log(response.body);
        return null;
      }
    } catch (e) {
      dev.log("error applying promo code: $e");
      return null;
    }
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

  Future<bool?> checkOut({
    required String addressId,
    String? promoCode,
    required String paymentId,
    required double totalAmount,
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      final token = await _tokenStorage.getToken();

      final url = Uri.parse("${AppConstants.baseUrl}/orders/checkout");
      final response = await http.post(url,
          body: jsonEncode({
            "addressId": addressId,
            "promoCode": promoCode,
            "paymentId": paymentId,
            "totalAmount": totalAmount,
            "items": items
          }),
          headers: headers(token!));

      if (response.statusCode == 201) {
        dev.log(response.body);
        SnacbarUtils.showSnacbar(
            title: "Success", message: jsonDecode(response.body)["message"]);
        await NotificationService.createNotification(
          payload: jsonEncode({
            "id": jsonDecode(response.body)["orderId"],
            "route_name": "/order_detail_page",
          }),
            body: "You have placed successfully", title: "Order Sucessfull");
        return jsonDecode(response.body)["success"] ?? false;
      } else {
        dev.log(response.body);
        SnacbarUtils.showSnacbar(
            message: jsonDecode(response.body)["message"], isError: true);
        return jsonDecode(response.body)["success"] ?? false;
      }
    } catch (e) {
      dev.log("error placing order: $e");
      return false;
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
