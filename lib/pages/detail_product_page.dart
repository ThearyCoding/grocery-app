import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/controllers/product_controller.dart';
import 'package:grocery_app/controllers/wishlist_controller.dart';
import 'package:grocery_app/widgets/custom_button.dart';

class DetailProductPage extends StatefulWidget {
  final String productId;
  const DetailProductPage({super.key, required this.productId});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  final cartController = Get.put(CartController());
  final wishlistController = Get.put(WishlistController());
  final productController = Get.put(ProductController());
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.wait([
      productController.fetchSingleProduct(productId: widget.productId),
      wishlistController.isInWishlist(productId: widget.productId)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final product = productController.product.value;

      var description = product.description ?? "No description provided";

      if (description == "") {
        description = "No description provided";
      }

      return productController.isLoadingDetail.isTrue
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    )),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: IconButton(
                        onPressed: () async {
                          await wishlistController.toggleWishlist(
                              productId: widget.productId);
                        },
                        icon: wishlistController.isInWishlistProduct.isTrue
                            ? Icon(
                                Icons.favorite_outlined,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite_border)),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Image.network(
                        product.images[0],
                        width: double.infinity,
                        height: 200,
                      )),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        product.name ?? "No name provided",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        product.unit ?? "No unit",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 15,
                            children: [
                              Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color(0xffE2E2E2),
                                      )),
                                  child: Icon(Icons.remove)),
                              Text(
                                "0",
                                style: TextStyle(fontSize: 17),
                              ),
                              Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color(0xffE2E2E2),
                                      )),
                                  child: Icon(Icons.add)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.hasActiveOffer == true) ...[
                                Text(
                                  '\$${product.price!.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(
                                  '\$${product.currentPrice!.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ] else ...[
                                Text(
                                  '\$${product.price!.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Divider(),
                      ExpansionTile(
                        title: Text("Product Details"),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(description),
                          )
                        ],
                      ),
                      ListTile(
                        title: Text("Nutritions"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Reviews"),
                        trailing: Row(
                          spacing: 10,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                  5,
                                  (index) => Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 20,
                                      )),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomButton(
                    label: 'Add to Basket',
                    onPressed: () {
                      cartController.createCart(productId: product.id ?? "");
                    }),
              ),
            );
    });
  }
}
