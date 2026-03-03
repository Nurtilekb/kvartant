import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';

/// Bottom Navigation Item виджет
class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.grey400,
            size: AppSizes.iconLg,
          ),
          SizedBox(height: AppSizes.xs),
          Text(
            label,
            style: TextStyle(
              fontSize: AppSizes.textXs,
              color: isSelected ? AppColors.primary : AppColors.grey400,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
