import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/models/order.dart';
import 'package:grocery_app/models/order_detail.dart';
import 'package:grocery_app/services/apis/order_api.dart';

class OrderController extends GetxController {
  final Rx<OrderResponse> orderResponse = Rx(OrderResponse());
  final Rx<OrderDetailResponse> orderDetailRes = Rx(OrderDetailResponse());
  final isLoading = false.obs;
  final errorText = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      errorText.value = null;
      isLoading.value = true;

      final ordersRes = await OrderApi().fetchOrders();

      orderResponse.value = ordersRes;
    } catch (e) {
      errorText.value = 'Failed to load orders';
      if (kDebugMode) {
        print('Error fetching orders: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrderDetail({required String orderId}) async {
    try {
      errorText.value = null;
      isLoading.value = true;
      final res = await OrderApi().fetchOrderDetail(orderId: orderId);
      orderDetailRes.value = res;
    } catch (e) {
      errorText.value = 'Failed to load order detail';
      if (kDebugMode) {
        print('Error fetching orders: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'processing':
        return Colors.purple;
      case 'shipped':
        return Colors.indigo;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return const Color(0xFF808080);
    }
  }

  String formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
