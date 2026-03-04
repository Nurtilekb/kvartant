import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ============================================================================
/// ЦВЕТА
/// ============================================================================
class AppColors {
  AppColors._();

  // Основные цвета
  static const Color primary = Color(0xFF176FF2); // Зелёный
  static const Color primaryLight = Color(0xFF7ED957);
  static const Color primaryDark = Color(0xFF3D8A2A);

  // Нейтральные цвета
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color black87 = Color(0xffde000000);
  static const Color grey = Colors.grey;
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);

  // Статус цвета
  static const Color error = Colors.red;
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
}

/// ============================================================================
/// РАЗМЕРЫ (Screen Util)
/// ============================================================================
class AppSizes {
  AppSizes._();

  // Отступы
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 12.w;
  static double get lg => 16.w;
  static double get xl => 20.w;
  static double get xxl => 24.w;
  static double get xxxl => 32.w;

  // Радиусы
  static double get radiusSm => 4.r;
  static double get radiusMd => 8.r;
  static double get radiusLg => 12.r;
  static double get radiusXl => 16.r;
  static double get radiusXxl => 24.r;

  // Размеры иконок
  static double get iconSm => 16.sp;
  static double get iconMd => 20.sp;
  static double get iconLg => 24.sp;
  static double get iconXl => 32.sp;
  static double get iconXxl => 48.sp;

  // Размеры текста
  static double get textXs => 10.sp;
  static double get textSm => 12.sp;
  static double get textMd => 14.sp;
  static double get textLg => 16.sp;
  static double get textXl => 18.sp;
  static double get textXxl => 20.sp;
  static double get textTitle => 24.sp;
  static double get textHeadline => 28.sp;

  // Bottom Navigation
  static double get bottomNavHeight => 64.h;
  static double get bottomNavRadius => 40.r;
  static double get bottomNavMargin => 14.h;
}

/// ============================================================================
/// ТЕКСТОВЫЕ СТИЛИ
/// ============================================================================
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get headline => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      );

  static TextStyle get title => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      );

  static TextStyle get subtitle => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      );

  static TextStyle get body => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.black,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.grey600,
      );

  static TextStyle get caption => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: AppColors.grey500,
      );

  static TextStyle get button => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get label => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.black87,
      );

  static TextStyle get price => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      );
  static TextStyle get pricetofavcard => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      );
}

/// ============================================================================
/// СТИЛИ КОМПОНЕНТОВ
/// ============================================================================
class AppDecorations {
  AppDecorations._();

  // BoxDecoration для карточек
  static BoxDecoration get card => BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      );

  // BoxDecoration для контейнеров с тенью
  static BoxDecoration get container => BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      );

  // InputDecoration для полей ввода
  static InputDecoration inputField({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: AppColors.grey500, fontSize: 14),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.grey300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.grey300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    );
  }

  // InputDecoration для поиска
  static InputDecoration searchField({
    String? hintText,
    VoidCallback? onClear,
  }) {
    return InputDecoration(
      hintText: hintText ?? 'Поиск...',
      hintStyle: const TextStyle(color: AppColors.grey500, fontSize: 14),
      prefixIcon: const Icon(Icons.search, color: AppColors.grey500),
      suffixIcon: onClear != null
          ? IconButton(
              icon: const Icon(Icons.clear, color: AppColors.grey500),
              onPressed: onClear,
            )
          : null,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    );
  }

  // Стиль ElevatedButton
  static ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        textStyle: AppTextStyles.button,
      );

  // Стиль OutlinedButton
  static ButtonStyle get secondaryButton => OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.grey300),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: AppColors.white,
        textStyle: AppTextStyles.button.copyWith(color: AppColors.black),
      );

  // Стиль AppBar
  static AppBarTheme get appBar => AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        titleTextStyle: AppTextStyles.title,
        centerTitle: false,
      );

  // Стиль BottomNavigationBar
  static BottomNavigationBarThemeData get bottomNavBar =>
      const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey400,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10,
        ),
      );
}

/// ============================================================================
/// ТЕМА ПРИЛОЖЕНИЯ
/// ============================================================================
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.grey100,
        appBarTheme: AppDecorations.appBar,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppDecorations.primaryButton,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: AppDecorations.secondaryButton,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.grey300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.grey300,
          thickness: 1,
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
}

/// ============================================================================
/// УТИЛИТЫ
/// ============================================================================
class AppUtils {
  AppUtils._();

  // Форматирование цены
  static String formatPrice(String price) {
    return price;
  }

  // Валидация email
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Валидация пароля
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }
}
