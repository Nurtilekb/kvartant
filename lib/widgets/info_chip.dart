import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';

/// Info Chip виджет - отображает иконку с текстом
class InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoChip({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSizes.iconSm, color: AppColors.grey600),
          SizedBox(width: AppSizes.xs),
          Text(label, style: TextStyle(fontSize: AppSizes.textSm, color: AppColors.grey600)),
        ],
      ),
    );
  }
}
