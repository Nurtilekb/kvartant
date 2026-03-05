import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';

/// Search Field виджет
class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const SearchField({
    super.key,
    required this.controller,
    this.hintText = 'Поиск...',
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              TextStyle(color: AppColors.grey500, fontSize: AppSizes.textMd),
          prefixIcon: const Icon(Icons.search, color: AppColors.grey500),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.grey500),
                  onPressed: onClear)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.lg, vertical: AppSizes.md),
        ),
      ),
    );
  }
}
