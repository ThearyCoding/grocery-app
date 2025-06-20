import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/models/cart.dart';
import 'package:grocery_app/services/apis/cart_api.dart';

class CartController extends GetxController {


  @override
  onInit(){
    super.onInit();

    fetchCart();
  }
  final _cartApi = CartApi();
  Rx<Cart> cart = Cart.empty().obs;
  final isLoading = false.obs;
  Future<void> createCart({required String productId}) async {
    await _cartApi.createCart(productId: productId);
  }

  Future<void> fetchCart() async {
    isLoading(true);
    final data = await _cartApi.fetchCart();

    cart = data.obs;
    isLoading(false);
    getSubTotal();
  }

  final subTotal = 0.0.obs;

  void getSubTotal() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      subTotal.value = 0.0;
      for (var item in cart.value.items) {
        final total = item.quantity! * (item.product!.price ?? 0);
        subTotal.value += total;
      }
    });
  }

  List<Map<String, dynamic>> getSummaryItems() {
    getSubTotal();
    double shipping = 0.0;
    double estimatedTaxes = 0.0;
    double otherfee = 3.0;
    final total = shipping + estimatedTaxes + otherfee + subTotal.value;
    return [
      {"title": "Subtotal", "amount": subTotal},
      {"title": "Shipping", "amount": shipping, "editable": true},
      {"title": "Estimated Taxes", "amount": estimatedTaxes},
      {"title": "Others Fees", "amount": otherfee},
      {"title": "Total", "amount": total, "bold": true},
    ];
  }

  Future<void> updateQuantity(
      {required String productId, required int quantity}) async {
    int index =
        cart.value.items.indexWhere((item) => item.product!.id == productId);

    if (index != -1) {
      final currentQty = cart.value.items[index].quantity ?? 1;
      final newQty = currentQty + quantity;

      if (newQty < 1) return;

      cart.value.items[index].quantity = newQty;
      cart.refresh();

      await _cartApi.updateQuantity(productId: productId, quantity: newQty);
    }

    getSubTotal();
  }

  Future<void> removeItem({required String productId}) async {
    int index =
        cart.value.items.indexWhere((item) => item.product!.id == productId);

    if (index != -1) {
      cart.value.items.removeAt(index);
      cart.refresh();
      await _cartApi.removeItem(productId: productId);
    }
  }
}
