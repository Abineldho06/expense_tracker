import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:expense_tracker/views/analytics/analytics.dart';
import 'package:expense_tracker/views/transactions/transactions.dart';
import 'package:expense_tracker/views/homepage/homepage.dart';
import 'package:expense_tracker/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> screens = [
    Homepage(),
    Transactions(),
    AnalyticsScreen(),
    ProfileScreen(),
  ];
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 2, 71, 88), // Deep violet at top
              Color.fromARGB(255, 0, 28, 42), // Rich indigo center
              Color.fromARGB(255, 1, 29, 55), // Rich indigo center
              Color.fromARGB(255, 9, 0, 18), // Subtle purple at bottom
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: screens[_currentPage],
          bottomNavigationBar: DotCurvedBottomNav(
            scrollController: _scrollController,
            hideOnScroll: true,
            indicatorColor: Colors.teal,
            backgroundColor: Colors.white30,
            animationDuration: const Duration(milliseconds: 300),
            animationCurve: Curves.ease,
            selectedIndex: _currentPage,
            indicatorSize: 5,
            borderRadius: 25,
            height: 70,
            onTap: (index) {
              setState(() => _currentPage = index);
            },
            items: [
              Icon(
                Icons.home,
                color: _currentPage == 0 ? Colors.tealAccent : Colors.white,
              ),
              Icon(
                Icons.wallet_outlined,
                color: _currentPage == 1 ? Colors.tealAccent : Colors.white,
              ),
              Icon(
                Icons.analytics_outlined,
                color: _currentPage == 2 ? Colors.tealAccent : Colors.white,
              ),
              Icon(
                Icons.person,
                color: _currentPage == 3 ? Colors.tealAccent : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
