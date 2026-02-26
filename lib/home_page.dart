import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_bar_pages/elements/searchBar.dart';

/// Главный экран с Bottom Navigation Bar
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeTab(),
          FavoritesTab(),
          ChatsTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
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
                isSelected: _currentIndex == 0,
                onTap: () => setState(() => _currentIndex = 0),
              ),
              _BottomNavItem(
                icon: Icons.favorite,
                label: 'Избранное',
                isSelected: _currentIndex == 1,
                onTap: () => setState(() => _currentIndex = 1),
              ),
              _BottomNavItem(
                icon: Icons.chat,
                label: 'Чаты',
                isSelected: _currentIndex == 2,
                onTap: () => setState(() => _currentIndex = 2),
              ),
              _BottomNavItem(
                icon: Icons.person,
                label: 'Профиль',
                isSelected: _currentIndex == 3,
                onTap: () => setState(() => _currentIndex = 3),
              ),
            ],
          ),
        ),
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

// ============================================
// ВКЛАДКА 2: ИЗБРАННОЕ
// ============================================
class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  final List<Map<String, dynamic>> _favorites = [
    {
      'title': 'Квартира в центре',
      'address': 'ул. Ленина, 10',
      'price': '50 000 ₽/мес',
      'rooms': 2,
      'area': '60 м²',
      'image': 'https://picsum.photos/400/300?random=1',
    },
    {
      'title': 'Элитная квартира',
      'address': 'ул. Горького, 15',
      'price': '120 000 ₽/мес',
      'rooms': 4,
      'area': '150 м²',
      'image': 'https://picsum.photos/400/300?random=4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Избранное',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border,
                      size: 64.sp, color: Colors.grey[400]),
                  SizedBox(height: 16.h),
                  Text('Нет избранных объявлений',
                      style:
                          TextStyle(fontSize: 16.sp, color: Colors.grey[600])),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: _favorites.length,
              itemBuilder: (context, index) =>
                  _AdvertisementCard(advertisement: _favorites[index]),
            ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 60.h),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF54B435),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// ============================================
// ВКЛАДКА 3: ЧАТЫ
// ============================================
class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _chats = [
      {
        'name': 'Александр',
        'lastMessage': 'Когда можно посмотреть квартиру?',
        'time': '12:30',
        'avatar': 'https://picsum.photos/100/100?random=10',
        'unread': 2,
      },
      {
        'name': 'Мария',
        'lastMessage': 'Отлично, договорились!',
        'time': '10:15',
        'avatar': 'https://picsum.photos/100/100?random=11',
        'unread': 0,
      },
      {
        'name': 'Иван',
        'lastMessage': 'Цена можно ниже?',
        'time': 'Вчера',
        'avatar': 'https://picsum.photos/100/100?random=12',
        'unread': 0,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Чаты',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: NetworkImage(chat['avatar']),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            chat['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.sp),
                          ),
                          Text(
                            chat['time'],
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 12.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat['lastMessage'],
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (chat['unread'] > 0)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF54B435),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                '${chat['unread']}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 60.h),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF54B435),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// ============================================
// ВКЛАДКА 4: ПРОФИЛЬ
// ============================================
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Профиль',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Аватар и имя
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: const Color(0xFF54B435),
                    child: Icon(Icons.person, size: 50.sp, color: Colors.white),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Иван Иванов',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'ivan@example.com',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Меню профиля
            _ProfileMenuItem(
                icon: Icons.person_outline,
                title: 'Редактировать профиль',
                onTap: () {}),
            _ProfileMenuItem(
                icon: Icons.home_outlined,
                title: 'Мои объявления',
                onTap: () {}),
            _ProfileMenuItem(
                icon: Icons.history, title: 'История просмотров', onTap: () {}),
            _ProfileMenuItem(
                icon: Icons.settings_outlined,
                title: 'Настройки',
                onTap: () {}),
            _ProfileMenuItem(
                icon: Icons.help_outline, title: 'Помощь', onTap: () {}),
            _ProfileMenuItem(
                icon: Icons.logout, title: 'Выйти', onTap: () {}, isRed: true),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 60.h),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF54B435),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isRed;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: isRed ? Colors.red : Colors.grey[600]),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            color: isRed ? Colors.red : Colors.black,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      ),
    );
  }
}

class _AdvertisementCard extends StatelessWidget {
  final Map<String, dynamic> advertisement;

  const _AdvertisementCard({required this.advertisement});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.network(
              advertisement['image'],
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  advertisement['title'],
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Text(
                  advertisement['address'],
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _InfoChip(
                        icon: Icons.door_front,
                        label: '${advertisement['rooms']} ком.'),
                    SizedBox(width: 8.w),
                    _InfoChip(
                        icon: Icons.square_foot, label: advertisement['area']),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  advertisement['price'],
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF54B435)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

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
          Icon(icon, size: 16.sp, color: Colors.grey[600]),
          SizedBox(width: 4.w),
          Text(label,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
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
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r)),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Фильтры',
                    style: TextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => setState(() {
                    _selectedPriceRange = 0;
                    _selectedRooms = 0;
                    _selectedType = 'Все';
                  }),
                  child: Text('Сбросить',
                      style:
                          TextStyle(color: Colors.grey[600], fontSize: 14.sp)),
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
                  Text('Тип жилья',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600)),
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
                                : Colors.black),
                        onSelected: (selected) =>
                            setState(() => _selectedType = type),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24.h),
                  Text('Цена',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600)),
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
                            fontSize: 12.sp),
                        onSelected: (selected) =>
                            setState(() => _selectedPriceRange = index),
                      );
                    }),
                  ),
                  SizedBox(height: 24.h),
                  Text('Количество комнат',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600)),
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
                                : Colors.black),
                        onSelected: (selected) =>
                            setState(() => _selectedRooms = index),
                      );
                    }),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Фильтры применены')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF54B435),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text('Применить',
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
