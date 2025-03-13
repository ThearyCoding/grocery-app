import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/widgets/grocery_card_item_widget.dart';
import 'package:grocery_app/widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child:
                          SvgPicture.asset('assets/icons/app_icon_color.svg')),
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
                  _headerExclusiveWidget('Exclusive Offer'),
                  SizedBox(
                    height: 15,
                  ),
                  _itemsWidget(exclusiveOffers),
                  SizedBox(
                    height: 15,
                  ),
                  _headerExclusiveWidget('Best Selling'),
                  SizedBox(
                    height: 15,
                  ),
                  _itemsWidget(bestSelling),
                  SizedBox(
                    height: 15,
                  ),
                  _headerExclusiveWidget('Groceries'),
                  SizedBox(
                    height: 15,
                  ),
                  _itemsGrocery(),
                  SizedBox(
                    height: 15,
                  ),
                  _itemsWidget(groceries),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _itemsGrocery() {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              height: 120,
              width: 250,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.orange.shade400.withOpacity(.24)),
              child: Row(
                spacing: 10,
                children: [
                  Image.asset('assets/images/pulses.png'),
                  Text(
                    'Pulses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 15,
              ),
          itemCount: 5),
    );
  }

  Widget _itemsWidget(List<GroceryItem> items) {
    return Container(
      width: double.infinity,
      height: 250,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(
                width: 15,
              ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GroceryCardItemWidget(item: items[index]);
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
