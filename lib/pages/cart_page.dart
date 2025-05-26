import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/models/cart.dart';
import 'package:grocery_app/pages/checkout_page.dart';
import 'package:grocery_app/pages/detail_product_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    cartController.fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Cart",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Obx(
          () => cartController.isLoading.isTrue
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final Item item =
                                cartController.cart.value.items[index];
                            final totalPrice = (item.quantity ?? 0) *
                                item.product!.price!.toDouble();
                            return GestureDetector(
                              onTap: () => Get.to(
                                  () => DetailProductPage(
                                      productId: item.product!.id ?? ""),
                                  transition: Transition.downToUp),
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Image.network(
                                      item.product!.images.first,
                                      width: 90,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.product!.name ??
                                                      "no name provided",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    cartController.removeItem(
                                                        productId:
                                                            item.product!.id ??
                                                                "");
                                                  },
                                                  icon: Icon(Icons.close))
                                            ],
                                          ),
                                          Text(item.product!.unit.toString()),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController
                                                          .updateQuantity(
                                                              productId: item
                                                                      .product!
                                                                      .id ??
                                                                  "",
                                                              quantity: -1);
                                                    },
                                                    child: Container(
                                                      width: 45,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xffE2E2E2))),
                                                      child: Icon(Icons.remove),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                      item.quantity.toString()),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController
                                                          .updateQuantity(
                                                              productId: item
                                                                      .product!
                                                                      .id ??
                                                                  "",
                                                              quantity: 1);
                                                    },
                                                    child: Container(
                                                      width: 45,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xffE2E2E2))),
                                                      child: Icon(Icons.add),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Text(
                                                  "\$${totalPrice.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Divider(),
                              ),
                          itemCount: cartController.cart.value.items.length),
                    ],
                  ),
                ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton.icon(
            iconAlignment: IconAlignment.end,
            icon: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green.shade600),
                child: Text(
                  "\$35.35",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                backgroundColor: AppColors.primaryColor),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => CheckoutPage())),
            label: Text(
              "Go to checkout",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ));
  }
}
