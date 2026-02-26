import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    'Более 120 000 ₽',
  ];

  final List<String> _roomOptions = [
    'Любое',
    '1 ком.',
    '2 ком.',
    '3 ком.',
    '4+ ком.',
  ];

  final List<String> _typeOptions = [
    'Все',
    'Квартира',
    'Дом',
    'Комната',
    'Студия',
  ];

  void _resetFilters() {
    setState(() {
      _selectedPriceRange = 0;
      _selectedRooms = 0;
      _selectedType = 'Все';
    });
  }

  void _applyFilters() {
    final filters = {
      'type': _selectedType,
      'priceRange': _selectedPriceRange,
      'rooms': _selectedRooms,
    };
    widget.onApply?.call(filters);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          // Ручка
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          // Заголовок
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Фильтры',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: _resetFilters,
                  child: Text(
                    'Сбросить',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Контент
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Тип жилья
                  _buildSectionTitle('Тип жилья'),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    children: _typeOptions.map((type) {
                      final isSelected = _selectedType == type;
                      return ChoiceChip(
                        label: Text(type),
                        selected: isSelected,
                        selectedColor: const Color(0xFF54B435).withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? const Color(0xFF54B435)
                              : Colors.black,
                        ),
                        onSelected: (selected) {
                          setState(() => _selectedType = type);
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24.h),

                  // Цена
                  _buildSectionTitle('Цена'),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: List.generate(_priceRanges.length, (index) {
                      final isSelected = _selectedPriceRange == index;
                      return ChoiceChip(
                        label: Text(_priceRanges[index]),
                        selected: isSelected,
                        selectedColor: const Color(0xFF54B435).withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? const Color(0xFF54B435)
                              : Colors.black,
                          fontSize: 12.sp,
                        ),
                        onSelected: (selected) {
                          setState(() => _selectedPriceRange = index);
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 24.h),

                  // Количество комнат
                  _buildSectionTitle('Количество комнат'),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    children: List.generate(_roomOptions.length, (index) {
                      final isSelected = _selectedRooms == index;
                      return ChoiceChip(
                        label: Text(_roomOptions[index]),
                        selected: isSelected,
                        selectedColor: const Color(0xFF54B435).withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? const Color(0xFF54B435)
                              : Colors.black,
                        ),
                        onSelected: (selected) {
                          setState(() => _selectedRooms = index);
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
          // Кнопка применить
          Padding(
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF54B435),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Применить',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
