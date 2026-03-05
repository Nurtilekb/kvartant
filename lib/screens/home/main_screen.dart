import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';
import 'package:_kvartant/widgets/bottom_nav_item.dart';
import 'package:_kvartant/screens/home/home_tab.dart';
import 'package:_kvartant/screens/home/favorites_tab.dart';
import 'package:_kvartant/screens/home/chats_tab.dart';
import 'package:_kvartant/screens/home/profile_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Список вкладок
  final List<Widget> _tabs = const [
    HomeTabScreen(),
    FavoritesTab(),
    ChatsTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.bottomNavMargin),
      padding: EdgeInsets.only(
        left: AppSizes.xxl,
        right: AppSizes.xxl,
        bottom: AppSizes.md,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.bottomNavRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: AppSizes.bottomNavHeight,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(AppSizes.bottomNavRadius),
              border: Border.all(
                color: AppColors.white.withOpacity(0.4),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomNavItem(
                  icon: Icons.home_rounded,
                  label: 'Главная',
                  isSelected: _currentIndex == 0,
                  onTap: () => setState(() => _currentIndex = 0),
                ),
                BottomNavItem(
                  icon: Icons.favorite_rounded,
                  label: 'Избранное',
                  isSelected: _currentIndex == 1,
                  onTap: () => setState(() => _currentIndex = 1),
                ),
                BottomNavItem(
                  icon: Icons.chat_rounded,
                  label: 'Чаты',
                  isSelected: _currentIndex == 2,
                  onTap: () => setState(() => _currentIndex = 2),
                ),
                BottomNavItem(
                  icon: Icons.person_rounded,
                  label: 'Профиль',
                  isSelected: _currentIndex == 3,
                  onTap: () => setState(() => _currentIndex = 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
