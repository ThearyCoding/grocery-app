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
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final List<Widget> _pages = [
    HomePage(),
    ExplorePage(),
    CartPage(),
    FavoritePage(),
    AccountPage()
  ];

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, index, _) => _pages[index],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, index, _) => Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1))],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              onTap: (newIndex) => _currentIndex.value = newIndex,
              currentIndex: index,
              selectedItemColor: AppColors.primaryColor,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              unselectedItemColor: Colors.black,
              items: [
                _buildNavItem('Shop', 'assets/icons/shop_icon.svg', 0, index),
                _buildNavItem('Explore', 'assets/icons/explore_icon.svg', 1, index),
                _buildNavItem('Cart', 'assets/icons/cart_icon.svg', 2, index),
                _buildNavItem('Favorite', 'assets/icons/favourite_icon.svg', 3, index),
                _buildNavItem('Account', 'assets/icons/account_icon.svg', 4, index),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String label, String asset, int itemIndex, int currentIndex) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        asset,
        height: 24,
        colorFilter: ColorFilter.mode(
          itemIndex == currentIndex ? AppColors.primaryColor : Colors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
