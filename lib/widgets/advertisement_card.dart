import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';
import 'package:_kvartant/models/advertisement.dart';
import 'package:_kvartant/widgets/info_chip.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        decoration: AppDecorations.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение с кнопкой избранного
            SizedBox(
              height: 120.w,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppSizes.radiusXl),
                    ),
                    child: Image.network(
                      advertisement.imageUrl,
                      height: 120.w,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 120.w,
                          color: AppColors.grey200,
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: AppSizes.iconMd,
                              color: AppColors.grey400,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Кнопка избранного
                  Positioned(
                    top: AppSizes.xs,
                    right: AppSizes.xs,
                    child: GestureDetector(
                      onTap: onFavorite,
                      child: Container(
                        padding: EdgeInsets.all(AppSizes.xs),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          advertisement.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: advertisement.isFavorite
                              ? AppColors.error
                              : AppColors.grey500,
                          size: AppSizes.iconSm,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Информация
            Padding(
              padding: EdgeInsets.all(AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Цена
                  Text(
                    advertisement.price,
                    style: AppTextStyles.price,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSizes.xs),
                  // Название
                  Text(
                    advertisement.title,
                    style: AppTextStyles.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSizes.xs),
                  // Адрес
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: AppSizes.iconSm,
                        color: AppColors.grey500,
                      ),
                      SizedBox(width: AppSizes.xs),
                      Expanded(
                        child: Text(
                          advertisement.address,
                          style: AppTextStyles.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      InfoChip(
                        iconColor: AppColors.black,
                        icon: Icons.bed,
                        label: '${advertisement.rooms}',
                        compact: true,
                      ),
                      SizedBox(width: AppSizes.xs),
                      InfoChip(
                        iconColor: AppColors.black,
                        icon: Icons.square_foot,
                        label: advertisement.area,
                        compact: true,
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
