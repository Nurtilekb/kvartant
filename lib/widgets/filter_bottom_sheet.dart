import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';

/// Bottom Sheet для фильтров
class FilterBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>)? onApply;

  const FilterBottomSheet({super.key, this.onApply});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int _selectedPriceRange = 0;
  int _selectedRooms = 0;
  String _selectedType = 'Все';

  final List<String> _priceRanges = [
    'До 30 000 ₽',
    '30 000 - 50 000 ₽',
    '50 000 - 80 000 ₽',
    '80 000 - 120 000 ₽',
    'Более 120 000 ₽'
  ];
  final List<String> _roomOptions = [
    'Любое',
    '1 ком.',
    '2 ком.',
    '3 ком.',
    '4+ ком.'
  ];
  final List<String> _typeOptions = [
    'Все',
    'Квартира',
    'Дом',
    'Комната',
    'Студия'
  ];

  void _resetFilters() => setState(() {
        _selectedPriceRange = 0;
        _selectedRooms = 0;
        _selectedType = 'Все';
      });

  void _applyFilters() {
    widget.onApply?.call({
      'type': _selectedType,
      'priceRange': _selectedPriceRange,
      'rooms': _selectedRooms
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppSizes.radiusXxl)),
      ),
      child: Column(
        children: [
          // Ручка
          Container(
            margin: EdgeInsets.only(top: AppSizes.md),
            width: AppSizes.radiusXl,
            height: AppSizes.radiusSm,
            decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
          ),
          // Заголовок
          Padding(
            padding: EdgeInsets.all(AppSizes.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Фильтры', style: AppTextStyles.title),
                TextButton(
                    onPressed: _resetFilters,
                    child: Text('Сбросить', style: AppTextStyles.bodySmall)),
              ],
            ),
          ),
          // Контент
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                      'Тип жилья',
                      _typeOptions,
                      _typeOptions.indexOf(_selectedType),
                      (i) => setState(() => _selectedType = _typeOptions[i])),
                  SizedBox(height: AppSizes.xxl),
                  _buildSection('Цена', _priceRanges, _selectedPriceRange,
                      (i) => setState(() => _selectedPriceRange = i)),
                  SizedBox(height: AppSizes.xxl),
                  _buildSection(
                      'Количество комнат',
                      _roomOptions,
                      _selectedRooms,
                      (i) => setState(() => _selectedRooms = i)),
                  SizedBox(height: AppSizes.xxxl),
                ],
              ),
            ),
          ),
          // Кнопка
          Padding(
            padding: EdgeInsets.all(AppSizes.lg),
            child: SizedBox(
              width: double.infinity,
              height: AppSizes.bottomNavHeight,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
                ),
                child: Text('Применить', style: AppTextStyles.button),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> options, int selected,
      Function(int) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.subtitle),
        SizedBox(height: AppSizes.md),
        Wrap(
          spacing: AppSizes.sm,
          runSpacing: AppSizes.sm,
          children: List.generate(options.length, (index) {
            final isSelected = selected == index;
            return ChoiceChip(
              label: Text(options[index],
                  style: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.black,
                      fontSize: AppSizes.textSm)),
              selected: isSelected,
              selectedColor: AppColors.primary.withOpacity(0.2),
              onSelected: (_) => onSelect(index),
            );
          }),
        ),
      ],
    );
  }
}
