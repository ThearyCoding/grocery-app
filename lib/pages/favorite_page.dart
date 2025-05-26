import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/wishlist_controller.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/models/wishlist.dart';
import 'package:grocery_app/pages/detail_product_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final _wishlistController = Get.put(WishlistController());

  @override
  void initState() {
    super.initState();
    _wishlistController.fetchWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Favorite",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Obx(() => _wishlistController.isLoading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _wishlistController.wishlist.value.items.isEmpty
                ? Center(
                    child: Text(
                      "Wishlist is Empty.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                final Item item = _wishlistController
                                    .wishlist.value.items[index];
                                if (item.product == null) return SizedBox();
                                return GestureDetector(
                                  onTap: () => Get.to(() => DetailProductPage(
                                      productId: item.product!.id ?? "")),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15),
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Image.network(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          fit: BoxFit.cover,
                                          item.product!.images.isNotEmpty
                                              ? item.product!.images[0]
                                              : "",
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(Icons.error),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.product!.name ??
                                                      "No name provided",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  item.product!.unit ??
                                                      "No unit provided",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          spacing: 10,
                                          children: [
                                            Text(
                                              "\$${item.product!.price!.toStringAsFixed(2)}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  await _wishlistController
                                                      .removeWishlist(
                                                          productId: item
                                                                  .product!
                                                                  .id ??
                                                              "");
                                                },
                                                icon: Icon(Icons.close)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (_, index) => Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Divider(),
                                  ),
                              itemCount: _wishlistController
                                  .wishlist.value.items.length),
                        ),
                      ],
                    ),
                  )),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Add all to cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ))),
        ));
  }
}
