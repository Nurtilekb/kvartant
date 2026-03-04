import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';

/// Info Chip виджет - отображает иконку с текстом
class InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool compact; // Новый параметр для компактного вида

  const InfoChip({
    super.key,
    required this.icon,
    required this.label,
    this.compact = false,
    required Color iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: compact ? 28 : 32,
      padding:
          EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.xs),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSizes.iconSm, color: AppColors.grey600),
          SizedBox(width: AppSizes.xs),
          Text(label,
              style: TextStyle(
                  fontSize: AppSizes.textSm, color: AppColors.grey600)),
        ],
      ),
    );
  }
}
