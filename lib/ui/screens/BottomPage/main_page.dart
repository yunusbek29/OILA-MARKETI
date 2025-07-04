import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_colors.dart';
import 'package:flutter_application_1/ui/screens/BottomPage/bag_page.dart';
import 'package:flutter_application_1/ui/screens/BottomPage/favorite_page.dart';
import 'package:flutter_application_1/ui/screens/BottomPage/profile_page.dart';
import 'package:flutter_application_1/ui/screens/BottomPage/shop_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<Widget> page = [ShopPage(), BagPage(), FavoritePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[currentIndex],
      bottomNavigationBar: GNav(
        tabBackgroundGradient: LinearGradient(
          colors: [
            AppColors.orange.withAlpha(100),
            AppColors.orange.withAlpha(100),
          ],
        ),
        onTabChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        padding: EdgeInsetsGeometry.all(17),
        tabs: [
          GButton(
            icon: Icons.shopping_cart,
            text: "Shop",
            gap: 5,
            onPressed: () {
              currentIndex == 1;
            },
            iconColor: AppColors.grey,
            iconActiveColor: AppColors.orange,
            textColor: AppColors.orange,
          ),
          GButton(
            icon: Icons.shopping_bag,
            text: "Bag",
            gap: 5,
            onPressed: () {
              currentIndex == 2;
            },
            iconColor: AppColors.grey,
            iconActiveColor: AppColors.orange,
            textColor: AppColors.orange,
          ),
          GButton(
            icon: Icons.favorite,
            text: "Favorite",
            gap: 5,
            iconColor: AppColors.grey,
            onPressed: () {
              currentIndex == 3;
            },
            iconActiveColor: AppColors.orange,
            textColor: AppColors.orange,
          ),
          GButton(
            icon: Icons.person,
            text: "profile",
            gap: 5,
            onPressed: () {
              currentIndex == 4;
            },
            iconColor: AppColors.grey,
            iconActiveColor: AppColors.orange,
            textColor: AppColors.orange,
          ),
        ],
      ),
      drawerEdgeDragWidth: 10,
    );
  }
}
