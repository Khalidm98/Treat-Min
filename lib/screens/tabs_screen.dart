import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import './account_screen.dart';
import './browse_screen.dart';
import './main_screen.dart';
import './settings_screen.dart';
import '../widgets/navigation_bar.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  CarouselController _slider = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CarouselSlider(
          carouselController: _slider,
          options: CarouselOptions(
            height: double.infinity,
            initialPage: _currentIndex,
            viewportFraction: 1,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            onPageChanged: (index, _) {
              setState(() => _currentIndex = index);
            },
          ),
          items: [
            MainScreen(),
            BrowseScreen(),
            SettingsScreen(),
            AccountScreen(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onTap: (index) {
          _slider.animateToPage(index);
        },
        index: _currentIndex,
        items: [
          Image.asset('assets/icons/heart_outline.png'),
          Image.asset('assets/icons/medicine_outline.png'),
          Image.asset('assets/icons/settings_outline.png'),
          Image.asset('assets/icons/profile_outline.png'),
        ],
        activeItems: [
          Image.asset('assets/icons/heart_filled.png'),
          Image.asset('assets/icons/medicine_outline.png'),
          Image.asset('assets/icons/settings_filled.png'),
          Image.asset('assets/icons/profile_filled.png'),
        ],
      ),
    );
  }
}
