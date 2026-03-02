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
      imagePath: 'assets/images/kvartiras.jpg', // замените на свои изображения
      title: 'Kvartant',
      description:
          "Аренда без посредников Найди квартиру напрямую у владельца.Без комиссий. Без риелторов. Без переплат.",
    ),
    OnboardingPage(
      imagePath: 'assets/images/kvartirs.jpg',
      title: 'Прямое общение',
      description:
          'Связывайся с владельцами напрямую.Договаривайся об условиях быстро и честно',
    ),
    OnboardingPage(
        imagePath: 'assets/images/prototype.jpg',
        title: 'Просто. Безопасно. Удобно.',
        description:
            "Kvartant — новая культура аренды жилья.Твой дом начинается здесь. "),
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
      _goToSignIn();
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

  void _goToSignIn() {
    // Переход на экран входа (замените на нужный маршрут)
    Navigator.of(context).pushReplacementNamed('/signin');
  }

  void _skip() => _goToSignIn();

  @override
  Widget build(BuildContext context) {
    // Фоновая картинка меняется в зависимости от текущей страницы
    final backgroundPath = _pages[_currentPage].imagePath;

    return Scaffold(
      body: Stack(
        children: [
          // Фоновое изображение на весь экран
          Positioned.fill(
            child: Image.asset(
              backgroundPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Кнопка "Пропустить"
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: TextButton(
                      onPressed: _skip,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white70,
                        foregroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: Text(
                        'Пропустить',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
                // Основной контент (страницы)
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
                            ? const Color(0xFF54B435)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Кнопки "Назад" и "Далее/Начать"
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Кнопка "Назад" (появляется только не на первой странице)
                      _currentPage > 0
                          ? TextButton(
                              onPressed: _previousPage,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    size: 18.sp,
                                  ),
                                  Text(
                                    'Назад',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(width: 80), // резервируем место
                      // Кнопка "Далее" / "Начать"
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF54B435),
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
    return Center(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 28.w),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Title
            Text(
              page.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 20.h),

            /// Divider line (маленький акцент)
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),

            SizedBox(height: 24.h),

            /// Description
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 300.w,
              ),
              child: Text(
                page.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                ),
              ),
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
