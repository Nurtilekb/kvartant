import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';
import 'package:_kvartant/models/advertisement.dart';
import 'package:_kvartant/widgets/advertisement_card.dart';
import 'package:_kvartant/widgets/search_field.dart';
import 'package:_kvartant/widgets/filter_button.dart';
import 'package:_kvartant/widgets/filter_bottom_sheet.dart';

/// Вкладка Главная (поиск объявлений)
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _hasActiveFilters = false;

  // Список объявлений
  final List<Advertisement> _advertisements = Advertisement.getSampleList();

  // Фильтрованный список
  List<Advertisement> get _filteredAds {
    if (_searchQuery.isEmpty) return _advertisements;
    return _advertisements.where((ad) {
      final title = ad.title.toLowerCase();
      final address = ad.address.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query) || address.contains(query);
    }).toList();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        onApply: (filters) {
          setState(() => _hasActiveFilters = true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Фильтры применены')),
          );
        },
      ),
    );
  }

  void _toggleFavorite(String id) {
    setState(() {
      final index = _advertisements.indexWhere((ad) => ad.id == id);
      if (index != -1) {
        _advertisements[index].isFavorite = !_advertisements[index].isFavorite;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
      body: SafeArea(
        child: Column(
          children: [
            // Верхняя часть с поиском
            Container(
              padding: EdgeInsets.all(AppSizes.lg),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Поиск объявлений', style: AppTextStyles.title),
                  SizedBox(height: AppSizes.md),
                  // Search Field и кнопка фильтра
                  Row(
                    children: [
                      Expanded(
                        child: SearchField(
                          controller: _searchController,
                          hintText: 'Поиск по названию или адресу...',
                          onChanged: (value) =>
                              setState(() => _searchQuery = value),
                          onClear: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        ),
                      ),
                      SizedBox(width: AppSizes.md),
                      FilterButton(
                        onPressed: _showFilterSheet,
                        hasActiveFilters: _hasActiveFilters,
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
                            Icon(Icons.search_off,
                                size: AppSizes.iconXxl,
                                color: AppColors.grey400),
                            SizedBox(height: AppSizes.lg),
                            Text('Объявления не найдены',
                                style: AppTextStyles.body),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: EdgeInsets.all(AppSizes.lg),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              0.75, // Соотношение для карточки с фото + текстом
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _filteredAds.length,
                        itemBuilder: (context, index) {
                          final ad = _filteredAds[index];
                          return AdvertisementCard(
                            advertisement: ad,
                            onFavorite: () => _toggleFavorite(ad.id),
                          );
                        },
                      )),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: AppSizes.bottomNavHeight + AppSizes.lg),
        child: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Добавить новое объявление')),
            );
          },
          backgroundColor: AppColors.primary,
          heroTag: 'add_ad',
          child: const Icon(Icons.add, color: AppColors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
