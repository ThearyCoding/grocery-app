import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/pages/detail_product_page.dart';
import '../core/app_colors.dart';

class GroceryCardItemWidget extends StatelessWidget {
  final Product product;
  const GroceryCardItemWidget({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return GestureDetector(
      onTap: () => Get.to(() => DetailProductPage(productId: product.id??"")),
      child: Container(
                padding: EdgeInsets.all(10),
                width: 180,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Color(0xffE2E2E2))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Center(
                      child: Image.network(height: 150, product.images[0]),
                    )),
                     SizedBox(height: 10,),
                    Text(
                    maxLines: 2,
                      product.name?? "No name provided",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),                 
                    Text(
                      product.unit??"No unit provided",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7C7C7C),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price!.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartController.createCart(productId: product.id ?? "");
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.primaryColor),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
    );
  }
}