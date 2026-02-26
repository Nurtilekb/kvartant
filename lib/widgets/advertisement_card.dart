import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:_kvartant/models/advertisement.dart';
import 'package:_kvartant/widgets/info_chip.dart';

/// Карточка объявления
class AdvertisementCard extends StatelessWidget {
  final Advertisement advertisement;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  const AdvertisementCard({
    super.key,
    required this.advertisement,
    this.onTap,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
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
            // Изображение с кнопкой избранного
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: Image.network(
                    advertisement.imageUrl,
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
                // Кнопка избранного
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: onFavorite,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        advertisement.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: advertisement.isFavorite ? Colors.red : Colors.grey,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Информация
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Цена
                  Text(
                    advertisement.price,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF54B435),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Название
                  Text(
                    advertisement.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
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
                        advertisement.address,
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
                      InfoChip(
                        icon: Icons.bed,
                        label: '${advertisement.rooms} ком.',
                      ),
                      SizedBox(width: 12.w),
                      InfoChip(
                        icon: Icons.square_foot,
                        label: advertisement.area,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
