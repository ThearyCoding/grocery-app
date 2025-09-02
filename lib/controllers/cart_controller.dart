import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/models/cart.dart';
import 'package:grocery_app/services/apis/cart_api.dart';
import 'package:grocery_app/utils/snacbar_utils.dart';

class CartController extends GetxController {
  final discount = 0.0.obs;
  final promoCodeController = TextEditingController().obs;
  RxString addressId = "".obs;
  RxString address = "".obs;
  @override
  void onInit() {
    super.onInit();

    fetchCart();
  }

  @override
  void onClose() {
    super.onClose();
    promoCodeController.value.dispose();
    clearCart();
  }

  final _cartApi = CartApi();
  Rx<Cart> cart = Cart.empty().obs;
  final isLoading = false.obs;
  Future<void> createCart({required String productId}) async {
    await _cartApi.createCart(productId: productId);
  }

  Future<void> clearCart() async {
    cart.value.items.clear();
    cart.refresh();
  }

  Future<void> applyPromoCode() async {
    if (promoCodeController.value.text.isEmpty) return;
    // isLoading(true);
    final result =
        await _cartApi.applyPromoCode(promoCodeController.value.text);
    if (result?['discountType'] == "percentage") {
      discount.value = (result?["discountValue"] ?? 0) / 100 * subTotal.value;
    } else if (result?['discountType'] == "fixed") {
      discount.value = result?["discountValue"] ?? 0;
    }
    getSummaryItems();
  }

  Future<bool?> checkOut() async {
    if (addressId.value.isEmpty && address.value.isEmpty) {
      SnacbarUtils.showSnacbar(
          message: "Please select an address", isError: true);
      return false;
    }
    final totalAmount = getSummaryItems().last['amount'] as double;
    final items = cart.value.items
        .map((e) => {
              "productId": e.product!.id,
              "quantity": e.quantity,
              "price": e.product!.price,
              "subTotal": (e.product!.price ?? 0) * (e.quantity ?? 0)
            })
        .toList();
    bool? result = await _cartApi.checkOut(
        promoCode: promoCodeController.value.text,
        addressId: addressId.value,
        paymentId: "",
        totalAmount: totalAmount,
        items: items);
    if (result == true) {
      clearCart();
      fetchCart();
      return true;
    }
    return false;
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
    double total = shipping + estimatedTaxes + otherfee + subTotal.value;
    total -= discount.value;
    return [
      {"title": "Subtotal", "amount": subTotal},
      {"title": "Address", "amount": shipping, "editable": true},
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
