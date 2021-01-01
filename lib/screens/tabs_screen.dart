import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import './account_screen.dart';
// import './browse_screen.dart';
import './main_screen.dart';
import './settings_screen.dart';
import '../widgets/navigation_bar.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  CarouselController _slider = CarouselController();
  int _currentIndex = 0;
  int _nextIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        carouselController: _slider,
        options: CarouselOptions(
          height: double.infinity,
          initialPage: _currentIndex,
          viewportFraction: 1,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            if (reason == CarouselPageChangedReason.controller) {
              if (index == _nextIndex) {
                setState(() => _currentIndex = index);
              }
            } else {
              setState(() => _currentIndex = index);
            }
          },
        ),
        items: [
          MainScreen(),
          // BrowseScreen(),
          SettingsScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        index: _currentIndex,
        onTap: (index) {
          _nextIndex = index;
          _slider.animateToPage(index);
        },
        items: [
          Image.asset('assets/icons/heart_outlined.png'),
          // Image.asset('assets/icons/medicine_outlined.png'),
          Image.asset('assets/icons/settings_outlined.png'),
          Image.asset('assets/icons/account_outlined.png'),
        ],
        activeItems: [
          Image.asset('assets/icons/heart_filled.png'),
          // Image.asset('assets/icons/medicine_outlined.png'),
          Image.asset('assets/icons/settings_filled.png'),
          Image.asset('assets/icons/account_filled.png'),
        ],
      ),
    );
  }
}
