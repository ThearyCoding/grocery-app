import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/category_controller.dart';
import 'package:grocery_app/controllers/product_controller.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/pages/category_items_page.dart';
import 'package:grocery_app/pages/search_sort_page.dart';
import 'package:grocery_app/widgets/grocery_card_item_widget.dart';
import 'package:grocery_app/widgets/search_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final categoryController = Get.put(CategoryController());
  final productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Find Product',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SearchWidget(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchSortPage(),
                            ));
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _buildCategoriesSection(),
                     SizedBox(
                      height: 15,
                    ),
                    _buildNewArrivalsSection()
                  ],
                ),
              ),
            )));
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        _buildHeader(title: "All categories",isCategory: true),
        GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categoryController.categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.9),
            itemBuilder: (context, index) {
              final category = categoryController.categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryItemsPage(
                                category: category,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.grey.shade50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        width: 50,
                        height: 50,
                        category.image ?? "",
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        category.name ?? "no name provided",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }

  Row _buildHeader({required String title,bool isCategory = false}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        isCategory ?  Text(
            "Show all",
            style: TextStyle(color: AppColors.primaryColor),
          ): SizedBox.shrink()
        ],
      );
  }

  Widget _buildNewArrivalsSection(){
    return Obx((){
      final products = productController.productNewest;
      return Column(
        spacing: 15,
      children: [
        _buildHeader(title: "New Arrivals"),

        SizedBox(
         width: double.infinity,
      height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index) {
            return GroceryCardItemWidget(product: products[index]);
          }, separatorBuilder: (_,__) => SizedBox(width: 10,), itemCount: products.length),
        )
      ],
    );
    });
  }
}
