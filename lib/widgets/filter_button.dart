import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Кнопка фильтра в Stack (с индикатором)
class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool hasActiveFilters;

  const FilterButton({
    super.key,
    required this.onPressed,
    this.hasActiveFilters = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Кнопка
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: const Color(0xFF54B435),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.tune,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ),
        // Индикатор активных фильтров
        if (hasActiveFilters)
          Positioned(
            right: 8.w,
            top: 8.h,
            child: Container(
              width: 10.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
