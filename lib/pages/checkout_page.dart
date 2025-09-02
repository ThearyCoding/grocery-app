import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/pages/address_list_page.dart';
import 'package:grocery_app/pages/order_accepted_page.dart';
import 'package:grocery_app/widgets/custom_button.dart';
import 'package:iconly/iconly.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                size: 18,
              )),
          title: Text(
            "CheckOut",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Obx(() {
                  return cartController.isLoading.isTrue
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                                height: 15,
                              ),
                          itemCount: cartController.cart.value.items.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = cartController.cart.value.items[index];
                            return Row(
                              spacing: 15,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Image.network(
                                        width: 150,
                                        height: 150,
                                        item.product!.images.first),
                                    Positioned(
                                      right: -5,
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color(0xff727272),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          item.quantity.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: 5,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product!.name ?? "No name",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        item.product!.unit ?? "No unit",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "\$${(item.quantity! * (item.product!.price ?? 0)).toStringAsFixed(2)}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryColor),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          });
                }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: cartController.promoCodeController.value,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          hintText: 'Enter discount code',
                          hintStyle: const TextStyle(color: Colors.black38),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.black12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 1.5),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        minimumSize: const Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        await cartController.applyPromoCode();
                      },
                      child: const Text(
                        "Apply",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return cartController.isLoading.isTrue
                      ? SizedBox()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartController.getSummaryItems().length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final summaryItems =
                                cartController.getSummaryItems()[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Text(
                                        summaryItems["title"],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                              summaryItems["bold"] == true
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                      summaryItems['title'] == 'Shipping'
                                          ? Icon(IconlyBold.location, size: 18)
                                          : SizedBox.shrink()
                                    ],
                                  ),
                                  summaryItems["editable"] == true
                                      ? GestureDetector(
                                          onTap: () async {
                                            final result = await Get.to(
                                                () => AddressListPage());
                                            if (result != null) {
                                              cartController.addressId.value =
                                                  result['id'];
                                              cartController.address.value =
                                                  result['address'];
                                            }
                                          },
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6),
                                            child: Text(
                                              cartController
                                                      .address.value.isEmpty
                                                  ? "Add Address"
                                                  : cartController
                                                      .address.value,
                                              style: TextStyle(fontSize: 16),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          "\$${summaryItems['amount']}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ],
                              ),
                            );
                          },
                        );
                })
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: GetPlatform.isIOS
              ? EdgeInsets.only(bottom: 20)
              : EdgeInsets.only(bottom: 5),
          width: double.infinity,
          height: 70,
          child: CustomButton(
            label: "Order now",
            onPressed: () async {
              final result = await cartController.checkOut();

              if (result == true) {
                Get.off(() => OrderAcceptedPage());
              }
            },
          ),
        ));
  }
}
