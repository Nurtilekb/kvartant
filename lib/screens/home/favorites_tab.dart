import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';
import 'package:_kvartant/models/advertisement.dart';
import 'package:_kvartant/widgets/advertisement_card.dart';

/// Вкладка Избранное
class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  late List<Advertisement> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = Advertisement.getSampleList()
        .map((ad) => Advertisement(
              id: ad.id,
              title: ad.title,
              address: ad.address,
              price: ad.price,
              rooms: ad.rooms,
              area: ad.area,
              imageUrl: ad.imageUrl,
              isFavorite: true,
            ))
        .toList();
  }

  void _toggleFavorite(String id) {
    setState(() => _favorites.removeWhere((ad) => ad.id == id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text('Избранное', style: AppTextStyles.title),
        centerTitle: false,
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: AppSizes.iconXxl, color: AppColors.grey400),
                  SizedBox(height: AppSizes.lg),
                  Text('Нет избранных объявлений', style: AppTextStyles.body),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(AppSizes.lg),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final ad = _favorites[index];
                return AdvertisementCard(
                  advertisement: ad,
                  onFavorite: () => _toggleFavorite(ad.id),
                );
              },
            ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: AppSizes.bottomNavHeight + AppSizes.lg),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: AppColors.white),
          heroTag: 'add_fav',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
