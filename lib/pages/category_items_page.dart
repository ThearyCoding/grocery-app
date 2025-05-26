import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/product_controller.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/pages/filter_page.dart';

import '../widgets/grocery_card_item_widget.dart';

class CategoryItemsPage extends StatefulWidget {
  final Category category;
  const CategoryItemsPage({super.key, required this.category});

  @override
  State<CategoryItemsPage> createState() => _CategoryItemsPageState();
}

class _CategoryItemsPageState extends State<CategoryItemsPage> {
  final productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    productController.fetchProductByCategory(
        categoryId: widget.category.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => FilterPage())),
                icon: Icon(Icons.sort)),
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          widget.category.name ?? "uncategorized",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () => productController.isLoadingCategory.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GridView.builder(
                    itemCount: productController.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.8,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return GroceryCardItemWidget(
                        product: productController.products[index],
                      );
                    }),
              ),
      ),
    );
  }
}
