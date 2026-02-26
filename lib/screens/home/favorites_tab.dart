import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:_kvartant/models/advertisement.dart';
import 'package:_kvartant/widgets/advertisement_card.dart';

/// Вкладка Избранное
class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  // Список избранных объявлений
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
    setState(() {
      _favorites.removeWhere((ad) => ad.id == id);
    });
  }

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
                  Icon(
                    Icons.favorite_border,
                    size: 64.sp,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Нет избранных объявлений',
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
