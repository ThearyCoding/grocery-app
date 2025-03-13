import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/pages/account_page.dart';
import 'package:grocery_app/pages/cart_page.dart';
import 'package:grocery_app/pages/explore_page.dart';
import 'package:grocery_app/pages/favorite_page.dart';
import 'package:grocery_app/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    ExplorePage(),
    CartPage(),
    FavoritePage(),
    AccountPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey)]),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38.withValues(alpha: .1),
                  spreadRadius: 0,
                  blurRadius: 37,
                  offset: Offset(0, -12)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                currentIndex: currentIndex,
                selectedItemColor: AppColors.primaryColor,
                selectedLabelStyle: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                unselectedItemColor: Colors.black,
                items: [
                  BottomNavigationBarItem(
                      label: 'Shop',
                      icon: SvgPicture.asset(
                          color: currentIndex == 0
                              ? AppColors.primaryColor
                              : Colors.black,
                          'assets/icons/shop_icon.svg')),
                  BottomNavigationBarItem(
                      label: 'Explore',
                      icon: SvgPicture.asset(
                          color: currentIndex == 1
                              ? AppColors.primaryColor
                              : Colors.black,
                          'assets/icons/explore_icon.svg')),
                  BottomNavigationBarItem(
                      label: 'Cart',
                      icon: SvgPicture.asset(
                          color: currentIndex == 2
                              ? AppColors.primaryColor
                              : Colors.black,
                          'assets/icons/cart_icon.svg')),
                  BottomNavigationBarItem(
                      label: 'Favorite',
                      icon: SvgPicture.asset(
                          color: currentIndex == 3
                              ? AppColors.primaryColor
                              : Colors.black,
                          'assets/icons/favourite_icon.svg')),
                  BottomNavigationBarItem(
                      label: 'Account',
                      icon: SvgPicture.asset(
                          color: currentIndex == 4
                              ? AppColors.primaryColor
                              : Colors.black,
                          'assets/icons/account_icon.svg'))
                ]),
          ),
        ),
      ),
    );
  }
}
