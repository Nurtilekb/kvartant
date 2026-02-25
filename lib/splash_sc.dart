import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      // Замени на свою картинку
      imagePath: 'assets/images/kvartiras.jpg',
      title: 'Добро пожаловать',
      description: 'Откройте для себя удивительный мир возможностей',
    ),
    OnboardingPage(
      // Замени на свою картинку
      imagePath: 'assets/images/kvartirs.jpg',
      title: 'Простота использования',
      description: 'Интуитивно понятный интерфейс для удобной работы',
    ),
    OnboardingPage(
      // Замени на свою картинку
      imagePath: 'assets/images/prototype.jpg',
      title: 'Начнём',
      description: 'Готовы начать? Присоединяйтесь к нам прямо сейчас!',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToHome();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToHome() {
    // Переход на главный экран приложения
    // Замени на свой экран
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _skip() {
    _goToHome();
  }

  @override
  Widget build(BuildContext context) {
    // общий фон берём из текущей страницы, но вы можете указать любую картинку
    final backgroundPath = _pages[_currentPage].imagePath;

    return Scaffold(
      body: Stack(
        children: [
          // фоновая картинка на весь экран
          Positioned.fill(
            child: Image.asset(
              backgroundPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink();
              },
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Кнопка Пропустить
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white70,
                    ),
                    child: TextButton(
                      onPressed: _skip,
                      child: Text(
                        'Пропустить',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                // Страницы
                SizedBox(height: 250.h),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return _buildPage(_pages[index]);
                    },
                  ),
                ),

                // Индикатор страниц
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 8.h,
                      width: _currentPage == index ? 24.w : 8.w,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Color(0xFF54B435)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),

                // Кнопки Назад/Далее
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Кнопка Назад
                      _currentPage > 0
                          ? TextButton(
                              onPressed: _previousPage,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    size: 18.sp,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Назад',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(width: 80),
                      // Кнопка Далее/Начать
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF54B435),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 16.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1
                              ? 'Начать'
                              : 'Далее',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    // содержимое страницы без отдельной картинки, фон уже в Scaffold
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white54,
              Color.fromARGB(255, 168, 209, 178),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r)),
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Заголовок
            Text(
              page.title,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            // Описание
            Text(
              page.description,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}
