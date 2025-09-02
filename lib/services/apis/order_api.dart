import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:grocery_app/core/constants.dart';
import 'package:grocery_app/models/order.dart';
import 'package:grocery_app/models/order_detail.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'package:grocery_app/utils/api_headers.dart';
import 'package:http/http.dart' as http;

class OrderApi {
  Future<OrderResponse> fetchOrders() async {
    try {
      final token = await TokenStorage().getToken();

      final response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/orders/my-orders"),
        headers: headers(token!),
      );

      if (response.statusCode == 200) {
        final dataJson = jsonDecode(response.body) as Map<String, dynamic>;
        return OrderResponse.fromJson(dataJson);
      } else {
        if (kDebugMode) {
          print("Failed to load orders: ${response.body}");
        }
        return OrderResponse();
      }
    } catch (e) {
      return OrderResponse();
    }
  }

    Future<OrderDetailResponse> fetchOrderDetail({required String orderId}) async {
    try {
      final token = await TokenStorage().getToken();

      final response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/orders/my-orders/$orderId"),
        headers: headers(token!),
      );

      if (response.statusCode == 200) {
        final dataJson = jsonDecode(response.body) as Map<String, dynamic>;
        return OrderDetailResponse.fromJson(dataJson);
      } else {
        if (kDebugMode) {
          print("Failed to load orders detail: ${response.body}");
        }
        return OrderDetailResponse();
      }
    } catch (e) {
      if(kDebugMode){
        print("Failed to load orders detail: $e");
      }
      return OrderDetailResponse();
    }
  }

  
}
