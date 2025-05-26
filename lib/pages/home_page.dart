import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/controllers/product_controller.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/widgets/grocery_card_item_widget.dart';
import 'package:grocery_app/widgets/loading-widget/loading_card_widget.dart';
import 'package:grocery_app/widgets/loading-widget/loading_feature_widget.dart';
import 'package:grocery_app/widgets/loading-widget/loading_header_widget.dart';
import 'package:grocery_app/widgets/search_widget.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = Get.put(ProductController());
  final categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Obx(
                () => Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: SvgPicture.asset(
                            'assets/icons/app_icon_color.svg')),
                    SizedBox(
                      height: 5,
                    ),
                    _headerWidget(),
                    SizedBox(
                      height: 15,
                    ),
                    SearchWidget(),
                    _bannerWidget(),
                    SizedBox(
                      height: 5,
                    ),
                    productController.isLoadingNewest.isTrue
                        ? LoadingHeaderWidget()
                        : _headerExclusiveWidget('Exclusive Offer'),
                    SizedBox(
                      height: 15,
                    ),
                    productController.isLoadingExclusive.value
                        ? LoadingCardWidget()
                        : _itemsWidget(productController.productsExclusive),
                    SizedBox(
                      height: 15,
                    ),
                    productController.isLoadingNewest.isTrue
                        ? LoadingHeaderWidget()
                        : _headerExclusiveWidget('Best Selling'),
                    SizedBox(
                      height: 15,
                    ),
                    productController.isLoadingBestSelling.value
                        ? LoadingCardWidget()
                        : _itemsWidget(productController.productsBestSelling),
                    SizedBox(
                      height: 15,
                    ),
                    productController.isLoadingNewest.isTrue
                        ? LoadingHeaderWidget()
                        : _headerExclusiveWidget('Groceries'),
                    SizedBox(
                      height: 15,
                    ),
                    categoryController.isLoading.isTrue
                        ? LoadingFeatureWidget()
                        : _featureItems(),
                    SizedBox(
                      height: 15,
                    ),
                    productController.isLoadingBestSelling.value
                        ? LoadingCardWidget()
                        : _itemsWidget(productController.productNewest),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _featureItems() {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final category = categoryController.categories[index];
            return Container(
              height: 120,
              width: 250,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: gridColors[index % gridColors.length]
                      .withValues(alpha: 0.1)),
              child: Row(
                spacing: 10,
                children: [
                  Image.network(
                      width: 80, fit: BoxFit.cover, category.image ?? ""),
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      category.name ?? "No name provided",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 15,
              ),
          itemCount: categoryController.categories.length),
    );
  }

  Widget _itemsWidget(List<Product> products) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(
                width: 15,
              ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GroceryCardItemWidget(product: products[index]);
          }),
    );
  }

  Widget _bannerWidget() {
    return Container(
      padding: EdgeInsets.all(15),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/banner_background.png'))),
      child: Row(
        spacing: 15,
        children: [
          Image.asset('assets/images/banner_image.png'),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Fresh Vegatables',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Get up to 40% OFF',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _headerExclusiveWidget(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          'See all',
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Widget _headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/location_icon.svg'),
        SizedBox(
          width: 10,
        ),
        Text(
          'Chamkar Mon, Phnom Penh',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
