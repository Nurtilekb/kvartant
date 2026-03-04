import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';

/// Элемент меню профиля
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isRed;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.sm),
      decoration: AppDecorations.card,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: isRed ? AppColors.error : AppColors.grey600),
        title: Text(title, style: TextStyle(fontSize: AppSizes.textLg, color: isRed ? AppColors.error : AppColors.black)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.grey400),
      ),
    );
  }
}
