import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Главный экран с поиском объявлений
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Пример списка объявлений
  final List<Map<String, dynamic>> _advertisements = [
    {
      'title': 'Квартира в центре',
      'address': 'ул. Ленина, 10',
      'price': '50 000 ₽/мес',
      'rooms': 2,
      'area': '60 м²',
      'image': 'https://picsum.photos/400/300?random=1',
    },
    {
      'title': 'Студия near метро',
      'address': 'ул. Пушкина, 5',
      'price': '35 000 ₽/мес',
      'rooms': 1,
      'area': '35 м²',
      'image': 'https://picsum.photos/400/300?random=2',
    },
    {
      'title': '3-комнатная квартира',
      'address': 'пр. Мира, 25',
      'price': '75 000 ₽/мес',
      'rooms': 3,
      'area': '90 м²',
      'image': 'https://picsum.photos/400/300?random=3',
    },
    {
      'title': 'Элитная квартира',
      'address': 'ул. Горького, 15',
      'price': '120 000 ₽/мес',
      'rooms': 4,
      'area': '150 м²',
      'image': 'https://picsum.photos/400/300?random=4',
    },
    {
      'title': 'Квартира с ремонтом',
      'address': 'ул. Советская, 8',
      'price': '45 000 ₽/мес',
      'rooms': 2,
      'area': '55 м²',
      'image': 'https://picsum.photos/400/300?random=5',
    },
  ];

  // Фильтрованный список
  List<Map<String, dynamic>> get _filteredAds {
    if (_searchQuery.isEmpty) {
      return _advertisements;
    }
    return _advertisements.where((ad) {
      final title = ad['title'].toString().toLowerCase();
      final address = ad['address'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query) || address.contains(query);
    }).toList();
  }

  // Функция фильтрации (открыть фильтры)
  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Верхняя часть с поиском
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Заголовок
                  Text(
                    'Поиск объявлений',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Search Field и кнопка фильтра
                  Row(
                    children: [
                      // Search Field
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Поиск по названию или адресу...',
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14.sp,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[500],
                              ),
                              suffixIcon: _searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.grey[500],
                                      ),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {
                                          _searchQuery = '';
                                        });
                                      },
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),

                      // Stack для кнопки фильтра (чтобы можно было переместить)
                      Stack(
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF54B435),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: IconButton(
                              onPressed: _showFilterSheet,
                              icon: Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ),
                          // Красная точка-индикатор (если есть активные фильтры)
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
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Список объявлений
            Expanded(
              child: _filteredAds.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64.sp,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Объявления не найдены',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: _filteredAds.length,
                      itemBuilder: (context, index) {
                        return _AdvertisementCard(
                          advertisement: _filteredAds[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // Float Bottom Bar
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 60.h),
        child: FloatingActionButton(
          onPressed: () {
            // Действие при нажатии (например, добавить объявление)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Добавить новое объявление'),
              ),
            );
          },
          backgroundColor: const Color(0xFF54B435),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BottomNavItem(
                  icon: Icons.home,
                  label: 'Главная',
                  isSelected: true,
                  onTap: () {},
                ),
                _BottomNavItem(
                  icon: Icons.favorite,
                  label: 'Избранное',
                  isSelected: false,
                  onTap: () {},
                ),
                _BottomNavItem(
                  icon: Icons.chat,
                  label: 'Чаты',
                  isSelected: false,
                  onTap: () {},
                ),
                _BottomNavItem(
                  icon: Icons.person,
                  label: 'Профиль',
                  isSelected: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Виджет карточки объявления
class _AdvertisementCard extends StatelessWidget {
  final Map<String, dynamic> advertisement;

  const _AdvertisementCard({required this.advertisement});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Image.network(
              advertisement['image'],
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180.h,
                  color: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 48.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                );
              },
            ),
          ),

          // Информация
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Цена
                Text(
                  advertisement['price'],
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF54B435),
                  ),
                ),
                SizedBox(height: 8.h),

                // Название
                Text(
                  advertisement['title'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),

                // Адрес
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16.sp,
                      color: Colors.grey[500],
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      advertisement['address'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Характеристики
                Row(
                  children: [
                    _InfoChip(
                      icon: Icons.bed,
                      label: '${advertisement['rooms']} ком.',
                    ),
                    SizedBox(width: 12.w),
                    _InfoChip(
                      icon: Icons.square_foot,
                      label: advertisement['area'],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Виджет чипа с иконкой
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: Colors.grey[600],
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

/// Элемент нижней навигации
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavItem({
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
            color: isSelected ? const Color(0xFF54B435) : Colors.grey[400],
            size: 24.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: isSelected ? const Color(0xFF54B435) : Colors.grey[400],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom Sheet для фильтров
class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // Состояние фильтров
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
    '4+ ком.'
  ];
  final List<String> _typeOptions = [
    'Все',
    'Квартира',
    'Дом',
    'Комната',
    'Студия'
  ];

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
                  onPressed: () {
                    setState(() {
                      _selectedPriceRange = 0;
                      _selectedRooms = 0;
                      _selectedType = 'Все';
                    });
                  },
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

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Тип жилья
                  Text(
                    'Тип жилья',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                          setState(() {
                            _selectedType = type;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24.h),

                  // Цена
                  Text(
                    'Цена',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                          setState(() {
                            _selectedPriceRange = index;
                          });
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 24.h),

                  // Количество комнат
                  Text(
                    'Количество комнат',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                          setState(() {
                            _selectedRooms = index;
                          });
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
                onPressed: () {
                  // Применить фильтры
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Фильтры применены'),
                    ),
                  );
                },
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
}
