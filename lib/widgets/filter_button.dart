import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';

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
        Container(
          width: AppSizes.bottomNavHeight,
          height: AppSizes.bottomNavHeight,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.tune, color: AppColors.white, size: AppSizes.iconLg),
          ),
        ),
        if (hasActiveFilters)
          Positioned(
            right: AppSizes.sm,
            top: AppSizes.sm,
            child: Container(
              width: AppSizes.textSm,
              height: AppSizes.textSm,
              decoration: BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}
